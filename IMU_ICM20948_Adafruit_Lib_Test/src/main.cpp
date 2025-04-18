#include <Arduino.h>
#include <Adafruit_ICM20X.h>
#include <Adafruit_ICM20948.h>
#include <Adafruit_Sensor.h>
#include "Mahony_DPEng.h"
#include "Madgwick_DPEng.h"
#include <Wire.h>
extern "C" {
#include "madgwickFilter.h"
}

Adafruit_ICM20948 icm;
uint16_t measurement_delay_us = 65535; // Delay between measurements for testing
// For SPI mode, we need a CS pin
//#define ICM_CS 10
// For software-SPI mode we need SCK/MOSI/MISO pins
//#define ICM_SCK 13
//#define ICM_MISO 12
//#define ICM_MOSI 11

//int index = 0;

// Mag calibration values are calculated via ahrs_calibration example sketch results.
// These values must be determined for each baord/environment.
// See the image in this sketch folder for the values used
// below.

// Offsets applied to raw x/y/z mag values
float mag_offsets[3] = { -22.03F, 21.39F, 31.85F };

// Soft iron error compensation matrix
float mag_softiron_matrix[3][3] = { {  1.009,  -0.004,  0.016 },
                                    { -0.004,   1.034,  0.016 },
                                    {  0.016,   0.016,  0.959 } };

float mag_field_strength = 45.50F;

// Offsets applied to compensate for gyro zero-drift error for x/y/z
float gyro_zero_offsets[3] = { 0.0F, 0.0F, 0.0F };

// Mahony is lighter weight as a filter and should be used
// on slower systems
//Mahony_DPEng filter;
//Madgwick_DPEng filter;

void setup(void) {
  Serial.begin(115200);
  while(!Serial)
    delay(10); // will pause until serial console opens

  Serial.println("Adafruit ICM20948 test!");

  // Try to initialize!
  if(!icm.begin_I2C()) {
    // if (!icm.begin_SPI(ICM_CS)) {
    // if (!icm.begin_SPI(ICM_CS, ICM_SCK, ICM_MISO, ICM_MOSI)) {

    Serial.println("Failed to find ICM20948 chip");
    while(1) {
      delay(10);
    }
  }
  Serial.println("ICM20948 Found!");
  // icm.setAccelRange(ICM20948_ACCEL_RANGE_16_G);
  Serial.print("Accelerometer range set to: ");
  switch(icm.getAccelRange()) {
  case ICM20948_ACCEL_RANGE_2_G:
    Serial.println("+-2G");
    break;
  case ICM20948_ACCEL_RANGE_4_G:
    Serial.println("+-4G");
    break;
  case ICM20948_ACCEL_RANGE_8_G:
    Serial.println("+-8G");
    break;
  case ICM20948_ACCEL_RANGE_16_G:
    Serial.println("+-16G");
    break;
  }
  Serial.println("OK");

  // icm.setGyroRange(ICM20948_GYRO_RANGE_2000_DPS);
  Serial.print("Gyro range set to: ");
  switch(icm.getGyroRange()) {
  case ICM20948_GYRO_RANGE_250_DPS:
    Serial.println("250 degrees/s");
    break;
  case ICM20948_GYRO_RANGE_500_DPS:
    Serial.println("500 degrees/s");
    break;
  case ICM20948_GYRO_RANGE_1000_DPS:
    Serial.println("1000 degrees/s");
    break;
  case ICM20948_GYRO_RANGE_2000_DPS:
    Serial.println("2000 degrees/s");
    break;
  }

  //  icm.setAccelRateDivisor(4095);
  uint16_t accel_divisor = icm.getAccelRateDivisor();
  float accel_rate = 1125 / (1.0 + accel_divisor);

  Serial.print("Accelerometer data rate divisor set to: ");
  Serial.println(accel_divisor);
  Serial.print("Accelerometer data rate (Hz) is approximately: ");
  Serial.println(accel_rate);

  //  icm.setGyroRateDivisor(255);
  uint8_t gyro_divisor = icm.getGyroRateDivisor();
  float gyro_rate = 1100 / (1.0 + gyro_divisor);

  Serial.print("Gyro data rate divisor set to: ");
  Serial.println(gyro_divisor);
  Serial.print("Gyro data rate (Hz) is approximately: ");
  Serial.println(gyro_rate);

  // icm.setMagDataRate(AK09916_MAG_DATARATE_10_HZ);
  Serial.print("Magnetometer data rate set to: ");
  switch(icm.getMagDataRate()) {
  case AK09916_MAG_DATARATE_SHUTDOWN:
    Serial.println("Shutdown");
    break;
  case AK09916_MAG_DATARATE_SINGLE:
    Serial.println("Single/One shot");
    break;
  case AK09916_MAG_DATARATE_10_HZ:
    Serial.println("10 Hz");
    break;
  case AK09916_MAG_DATARATE_20_HZ:
    Serial.println("20 Hz");
    break;
  case AK09916_MAG_DATARATE_50_HZ:
    Serial.println("50 Hz");
    break;
  case AK09916_MAG_DATARATE_100_HZ:
    Serial.println("100 Hz");
    break;
  }
  Serial.println();

  // Print the CSV header
  Serial.println("#10000,100"); // 100 Hz sensor update rate
  //Serial.println("Index,AccelX,AccelY,AccelZ,GyroX,GyroY,GyroZ,MagX,MagY,MagZ,Temp");

  //Serial.print("Index,AccelX_H,AccelX_L,AccelY_H,AccelY_L,");
  //Serial.print("AccelZ_H,AccelZ_L,GyroX_H,GyroX_L,GyroY_H,");
  //Serial.print("GyroY_L,GyroZ_H,GyroZ_L,MagX_H,MagX_L,");
  //Serial.println("MagY_H,MagY_L,MagZ_H,MagZ_L,Temp_H,Temp_L");
  // Manually insert because huge size resets the CPU somehow
  //Serial.println("Index,AccelX_H,AccelX_L,AccelY_H,AccelY_L,AccelZ_H,AccelZ_L,GyroX_H,GyroX_L,GyroY_H,GyroY_L,GyroZ_H,GyroZ_L,MagX_H,MagX_L,MagY_H,MagY_L,MagZ_H,MagZ_L,Temp_H,Temp_L");
}

void loop() {

  //  /* Get a new normalized sensor event */
  sensors_event_t accel;
  sensors_event_t gyro;
  sensors_event_t mag;
  sensors_event_t temp;
  icm.getEvent(&accel, &gyro, &temp, &mag);

  // Apply mag offset compensation (base values in uTesla)
  float x = mag.magnetic.x - mag_offsets[0];
  float y = mag.magnetic.y - mag_offsets[1];
  float z = mag.magnetic.z - mag_offsets[2];

  // Apply mag soft iron error compensation
  float mx = x * mag_softiron_matrix[0][0] + y * mag_softiron_matrix[0][1] + z * mag_softiron_matrix[0][2];
  float my = x * mag_softiron_matrix[1][0] + y * mag_softiron_matrix[1][1] + z * mag_softiron_matrix[1][2];
  float mz = x * mag_softiron_matrix[2][0] + y * mag_softiron_matrix[2][1] + z * mag_softiron_matrix[2][2];

  // Apply gyro zero-rate error compensation
  float gx = gyro.gyro.x + gyro_zero_offsets[0];
  float gy = gyro.gyro.y + gyro_zero_offsets[1];
  float gz = gyro.gyro.z + gyro_zero_offsets[2];

  // Update the filter
  //filter.update(gx, gy, gz, accel.acceleration.x, accel.acceleration.y, accel.acceleration.z, mx, my, mz);

  // Print the orientation filter output
  // Note: To avoid gimbal lock you should read quaternions not Euler
  // angles, but Euler angles are used here since they are easier to
  // understand looking at the raw values. See the ble fusion sketch for
  // and example of working with quaternion data.
  // USE THIS WHERE ROLL AND PITCH WORKs
  float roll = 0.0;//filter.getRoll();
  float pitch = 0.0;//filter.getPitch();
  float heading = 0.0;//filter.getYaw();

  // USE THIS TO TRY UNIVERSAL madgwickFilter in C
  imu_filter(accel.acceleration.x, accel.acceleration.y, accel.acceleration.z, gx, gy, gz);
  eulerAngles(q_est, &roll, &pitch, &heading);

  // For Drone 3D IMU Data Visualization

  // Normal Filter
  Serial.println();
  Serial.print("ROLL=");
  Serial.print(roll, 2);
  Serial.print(" PITCH=");
  Serial.print(pitch, 2);
  Serial.print(" YAW=");
  Serial.println(heading, 2);



  // For CSV File for SD Card
  /*
  Serial.print(index++);
  Serial.print(",");
  Serial.print(accel.acceleration.x);
  Serial.print(",");
  Serial.print(accel.acceleration.y);
  Serial.print(",");
  Serial.print(accel.acceleration.z);
  Serial.print(",");
  Serial.print(gyro.gyro.x);
  Serial.print(",");
  Serial.print(gyro.gyro.y);
  Serial.print(",");
  Serial.print(gyro.gyro.z);
  Serial.print(",");
  Serial.print(mag.magnetic.x);
  Serial.print(",");
  Serial.print(mag.magnetic.y);
  Serial.print(",");
  Serial.print(mag.magnetic.z);
  Serial.print(",");
  Serial.println(temp.temperature);
  */

  // For calibration with MotionCal, 10 is a scale factor
  /*
  Serial.print("Raw:");
  Serial.print((int)(accel.acceleration.x * 10));
  Serial.print(',');
  Serial.print((int)(accel.acceleration.y * 10));
  Serial.print(',');
  Serial.print((int)(accel.acceleration.z * 10));
  Serial.print(',');
  Serial.print((int)(gyro.gyro.x * 10));
  Serial.print(',');
  Serial.print((int)(gyro.gyro.y * 10));
  Serial.print(',');
  Serial.print((int)(gyro.gyro.z * 10));
  Serial.print(',');
  Serial.print((int)(mag.magnetic.x * 10));
  Serial.print(',');
  Serial.print((int)(mag.magnetic.y * 10));
  Serial.print(',');
  Serial.print((int)(mag.magnetic.z * 10));
  Serial.println();
  */

  /* // For reg values in hex
  Serial.print(index++);
 Serial.print(",");

 // Print accelerometer data
 Serial.print(buffer[0], HEX);
 Serial.print(",");
 Serial.print(buffer[1], HEX);
 Serial.print(",");
 Serial.print(buffer[2], HEX);
 Serial.print(",");
 Serial.print(buffer[3], HEX);
 Serial.print(",");
 Serial.print(buffer[4], HEX);
 Serial.print(",");
 Serial.print(buffer[5], HEX);
 Serial.print(",");

 // Print gyroscope data
 Serial.print(buffer[6], HEX);
 Serial.print(",");
 Serial.print(buffer[7], HEX);
 Serial.print(",");
 Serial.print(buffer[8], HEX);
 Serial.print(",");
 Serial.print(buffer[9], HEX);
 Serial.print(",");
 Serial.print(buffer[10], HEX);
 Serial.print(",");
 Serial.print(buffer[11], HEX);
 Serial.print(",");

 // Print magnetometer data as 0 (since it's assumed to be 0)
 Serial.print("00,00,00,00,00,00,"); // 3x (high, low) bytes

 // Print temperature data at the end
 Serial.print(buffer[12], HEX);
 Serial.print(",");
 Serial.println(buffer[13], HEX); // Use println() to add a newline
   */

  delay(10); // 100 Hz
  //  delayMicroseconds(measurement_delay_us);
}