# sensor_actuator_emulator
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15243424.svg)](https://doi.org/10.5281/zenodo.15243424)

This repository contains various code components for building and testing a FPGA-based Sensor-Actuator Emulation System designed for digital control applications. The project covers hardware description in VHDL/Verilog, data conversion and analysis scripts in Python, and firmware for embedded platforms including PlatformIO and STM32CubeIDE.

## 📁 Repository Structure

- **`hdl/`**
  VHDL/Verilog modules for building a IMU Sensor, PWM Analyzer and HALL Sensor with corresponding key-testbenches.

- **`python_scripts/`**
  Python scripts for:
  - Converting CSV files containing IMU Data as Register Values into VHDL LUTs.
  - Analyzing streamed IMU data against reference datasets for validation.

- **`IMU_ICM20948_Adafruit_Lib_Test/`**
  A PlatformIO-based project to test and validate the Adafruit ICM-20948 IMU sensor library.

- **`I2C_SPI_Nucleo_Test/`**
  STM32CubeIDE project targeting the STM32L432KC Nucleo board. This firmware tests the I2C/SPI interface of the emulated IMU sensor.

## ✅ Use Cases

- Rapid development of digital control test systems using emulated sensor data.
- End-to-end workflow from simulation to hardware-in-the-loop (HIL) testing.
- Verification of data integrity and timing behavior with real IMU stream comparisons.
- Evaluation of third-party libraries (e.g., Adafruit IMU drivers) in embedded environments.

## 🔧 Tools & Technologies

- **VHDL/Verilog** (synthesis and simulation)
- **Python 3** (data preprocessing and analysis)
- **PlatformIO** (embedded development)
- **STM32CubeIDE** (firmware development for STM32)

---

This repository is ideal for researchers, students, and engineers working on embedded control systems, digital emulation environments, or sensor interface prototyping.

