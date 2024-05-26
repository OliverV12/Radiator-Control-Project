function [num_days,DaySamplingNum,temp_anomalies, ...
    c1,c2,comfort1,comfort2,TAout,TAint]=RC_setup()


% Outdoor mean temp parameters in a day
quantum_out = 0.5; % quantum of outdoor temp (C°)
avg_min_out_temp = 5;
avg_max_out_temp = 9;
TAout = avg_min_out_temp:quantum_out:avg_max_out_temp;  % Admissible outdoor temp values

% Indoor temp parameters
quantum_int = 0.1;  % quantum of indoor temp (C°)
min_int_temp = 14.5;
max_int_temp = 21.0;
TAint = min_int_temp:quantum_int:max_int_temp; % Admissible indoor temp values

% Number of simulation days
num_days = 20;

SamplingNum = 15;  % sampling period
DaySamplingNum = 60/SamplingNum*24; % number of samples in a day

% Define the temp anomalies
min_anomaly = -3.5;

max_anomaly = 4.0;
temp_anomalies = (min_anomaly:0.5:max_anomaly);

% Thermal Model Parameters
c1 = 0.0067; % Parameter associated to the heat transfer when u = 0
c2 = 0.1541; % Parameter associated to the heat transfer when u = 1

%% Parameters associated to the comfort cost
comfort1 = 0.01; 
comfort2 = comfort1*5;






