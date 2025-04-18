%% Script Init
clc;
clear;
close all;

data_max = 500;

%% LFSR

%% Read Data
histogram_lfsr_data = readlines("./histogram_lfsr_data.txt");
histogram_lfsr_data = typecast(uint8(bin2dec(histogram_lfsr_data)),'uint8');
histogram_lfsr_data = histogram_lfsr_data(1:data_max); % limit data

%% Plot LFSR as Histogram data
figure;

% Plot histogram with 256 bins (for values 0x00 to 0xFF)
binwidth = 5;
histogram(histogram_lfsr_data, 'BinLimits', [0, 255], 'BinWidth', binwidth);
grid on;
%set(gca, 'YScale', 'log'); % log
ylim([0 11]); % y limit

% display 0x00 to 0xFF on x axis
xticks(0:15:255);
xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));

% Title and axis labels
title('Histogram of LFSR values');
xlabel('LFSR Output Value');
ylabel('Frequency');

%% Accel X

%% Read Data

data_max = 50;

% High Low Register without noise
accel_x_l_regs_00 = readlines("./histogram_pn_gen_data_accel_x_l_00.txt");
accel_x_l_regs_00 = typecast(uint8(bin2dec(accel_x_l_regs_00)),'uint8');
accel_x_l_regs_00 = accel_x_l_regs_00(1:data_max); % limit data

accel_x_h_regs_00 = readlines("./histogram_pn_gen_data_accel_x_h_00.txt");
accel_x_h_regs_00 = typecast(uint8(bin2dec(accel_x_h_regs_00)),'uint8');
accel_x_h_regs_00 = accel_x_h_regs_00(1:data_max); % limit data

% High Low Register with noise level 1
accel_x_l_regs_01 = readlines("./histogram_pn_gen_data_accel_x_l_01.txt");
accel_x_l_regs_01 = typecast(uint8(bin2dec(accel_x_l_regs_01)),'uint8');
accel_x_l_regs_01 = accel_x_l_regs_01(1:data_max); % limit data

accel_x_h_regs_01 = readlines("./histogram_pn_gen_data_accel_x_h_01.txt");
accel_x_h_regs_01 = typecast(uint8(bin2dec(accel_x_h_regs_01)),'uint8');
accel_x_h_regs_01 = accel_x_h_regs_01(1:data_max); % limit data

% High Low Register with noise level 2
accel_x_l_regs_10 = readlines("./histogram_pn_gen_data_accel_x_l_10.txt");
accel_x_l_regs_10 = typecast(uint8(bin2dec(accel_x_l_regs_10)),'uint8');
accel_x_l_regs_10 = accel_x_l_regs_10(1:data_max); % limit data

accel_x_h_regs_10 = readlines("./histogram_pn_gen_data_accel_x_h_10.txt");
accel_x_h_regs_10 = typecast(uint8(bin2dec(accel_x_h_regs_10)),'uint8');
accel_x_h_regs_10 = accel_x_h_regs_10(1:data_max); % limit data

% High Low Register with noise level 3
accel_x_l_regs_11 = readlines("./histogram_pn_gen_data_accel_x_l_11.txt");
accel_x_l_regs_11 = typecast(uint8(bin2dec(accel_x_l_regs_11)),'uint8');
accel_x_l_regs_11 = accel_x_l_regs_11(1:data_max); % limit data

accel_x_h_regs_11 = readlines("./histogram_pn_gen_data_accel_x_h_11.txt");
accel_x_h_regs_11 = typecast(uint8(bin2dec(accel_x_h_regs_11)),'uint8');
accel_x_h_regs_11 = accel_x_h_regs_11(1:data_max); % limit data

%% Plot Accel X Data as Histogram in Subplots
figure;
binwidth = 5;

% Define colors
color_00 = 'k'; % Black
color_01 = 'r'; % Red
color_10 = 'g'; % Green
color_11 = 'b'; % Blue

% Subplot 1: Only accel_x_l_regs_00
subplot(2,2,1);
histogram(accel_x_l_regs_00, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_00);
grid on;
ylim([0 5.5]);
xticks(0:15:255);
xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));
title('Histogram of Accel X Low Byte Register - No Noise');
xlabel('Accel X Low Byte Values');
ylabel('Frequency');

% Subplot 2: accel_x_l_regs_00 and accel_x_l_regs_01
subplot(2,2,2);
histogram(accel_x_l_regs_00, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_00);
hold on;
histogram(accel_x_l_regs_01, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_01);
grid on;
ylim([0 5.5]);
xticks(0:15:255);
xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));
title('Histogram of Accel X Low Byte Register - Noise Level 1');
xlabel('Accel X Low Byte Values');
ylabel('Frequency');

% Subplot 3: accel_x_l_regs_00 and accel_x_l_regs_10
subplot(2,2,3);
histogram(accel_x_l_regs_00, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_00);
hold on;
histogram(accel_x_l_regs_10, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_10);
grid on;
ylim([0 5.5]);
xticks(0:15:255);
xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));
title('Histogram of Accel X Low Byte Register - Noise Level 2');
xlabel('Accel X Low Byte Values');
ylabel('Frequency');

% Subplot 4: accel_x_l_regs_00 and accel_x_l_regs_11
subplot(2,2,4);
histogram(accel_x_l_regs_00, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_00);
hold on;
histogram(accel_x_l_regs_11, 'BinLimits', [0, 255], 'BinWidth', binwidth, 'FaceColor', color_11);
grid on;
ylim([0 5.5]);
xticks(0:15:255);
xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));
title('Histogram of Accel X Low Byte Register - Noise Level 3');
xlabel('Accel X Low Byte Values');
ylabel('Frequency');


% Plot histogram with 256 bins (for values 0x00 to 0xFF)
%binwidth = 5;
%histogram(accel_x_l_regs_00, 'BinLimits', [0, 255], 'BinWidth', binwidth);
%hold on;
%histogram(accel_x_l_regs_01, 'BinLimits', [0, 255], 'BinWidth', binwidth);
%grid on;
%%set(gca, 'YScale', 'log'); % log
%%ylim([0 11]); % y limit

% display 0x00 to 0xFF on x axis
%xticks(0:15:255);
%xticklabels(arrayfun(@(x) sprintf('0x%02X', x), 0:15:255, 'UniformOutput', false));

% Title and axis labels
%title('Histogram of Accel X Low Byte Values');
%xlabel('Accel X Low Byte Value');
%ylabel('Frequency');

%% Plot Accel X Data with and without Noise

% Constants
SENSORS_GRAVITY_EARTH = 9.80665;
accel_scale = 2048.0;

% Calc accX without noise
rawAccX_00 = int16(bitshift(uint8(accel_x_h_regs_00), 8) + uint8(accel_x_l_regs_00));
accXscaled_00 = double(rawAccX_00)/accel_scale;
accX_00 = accXscaled_00 * SENSORS_GRAVITY_EARTH;
% Calc accX with noise level 1
rawAccX_01 = int16(bitshift(uint8(accel_x_h_regs_01), 8) + uint8(accel_x_l_regs_01));
accXscaled_01 = double(rawAccX_01)/accel_scale;
accX_01 = accXscaled_01 * SENSORS_GRAVITY_EARTH;
% Calc accX with noise level 2
rawAccX_10 = int16(bitshift(uint8(accel_x_h_regs_10), 8) + uint8(accel_x_l_regs_10));
accXscaled_10 = double(rawAccX_10)/accel_scale;
accX_10 = accXscaled_10 * SENSORS_GRAVITY_EARTH;
% Calc accX with noise level 3
rawAccX_11 = int16(bitshift(uint8(accel_x_h_regs_11), 8) + uint8(accel_x_l_regs_11));
accXscaled_11 = double(rawAccX_11)/accel_scale;
accX_11 = accXscaled_11 * SENSORS_GRAVITY_EARTH;

% Calc xaxis timing
time_between_points_sec = 0.01;  % Time between each data point in seconds
time_sec = (0:numel(accX_00)-1) * time_between_points_sec;

% Create a figure
figure;

% First subplot: accX_00
subplot(3, 2, 1); % 3 rows, 2 columns, first subplot
plot(time_sec, accX_00,'-ok','LineWidth',2);
title('AccX Data - No Noise');
xlabel('Time (sec)');
ylabel('Acceleration X (m/sec^2)');
grid on;

% Second subplot: accX_01
subplot(3, 2, 2); % 3 rows, 2 columns, second subplot
plot(time_sec, accX_01,'-or','LineWidth',2);
title('AccX Data - Noise Level 1');
xlabel('Time (sec)');
ylabel('Acceleration X (m/sec^2)');
grid on;

% Third subplot: accX_10
subplot(3, 2, 3); % 3 rows, 2 columns, third subplot
plot(time_sec, accX_10,'-og','LineWidth',2);
title('AccX Data - Noise Level 2');
xlabel('Time (sec)');
ylabel('Acceleration X (m/sec^2)');
grid on;

% Fourth subplot: accX_11
subplot(3, 2, 4); % 3 rows, 2 columns, fourth subplot
plot(time_sec, accX_11,'-ob','LineWidth',2);
title('AccX Data - Noise Level 3');
xlabel('Time (sec)');
ylabel('Acceleration X (m/sec^2)');
grid on;

% Fifth subplot: All together
subplot(3, 2, [5, 6]); % 3 rows, 2 columns, span across bottom part (5th)
plot(time_sec, accX_00, 'k','LineWidth',2); hold on;
plot(time_sec, accX_01, 'r','LineWidth',2);
plot(time_sec, accX_10, 'g','LineWidth',2);
plot(time_sec, accX_11, 'b','LineWidth',2);
title('AccX Data - Combined View');
xlabel('Time (sec)');
ylabel('Acceleration X (m/sec^2)');
legend({'AccX Data - No Noise', 'AccX Data - Noise Level 1', 'AccX Data - Noise Level 2', 'AccX Data - Noise Level 3'});
grid on;
