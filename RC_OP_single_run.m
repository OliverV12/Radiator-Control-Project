function  [x, ut, gt, stage_cost_matrix, epsilon] =  RC_OP_single_run(MeanTemperature, ...
    pW,T,U,Tint)

% Load some parameters defined in file RC_setup.m:
[num_days,DaySamplingNum,temp_anomalies, ...
    c1,c2,comfort1,comfort2,~,TAint]=RC_setup();

% State x(:,t)=(i,j); i = outdoor temperature, j = indoor temperature
x=zeros(T+1,2);

% Stage cost
gt = zeros(T,1);

% Input vector
ut = zeros(T,1);

% Generate T IID realization of the r.v. anomaly 
epsilon = randsample(temp_anomalies, T+1, true, pW);  % temp anomaly vector

% Outdor temp simulation
average_temp_simulation = repmat(MeanTemperature',1, num_days);
Temp_simulation = average_temp_simulation+epsilon;  % add the noise
x(:,1) = Temp_simulation;  % store the results in the first column



%% Internal Temperature and cost simulation (optimal policy)

% Initialization
x(1,2) = Tint;  % indoor temperature at time 0
k=0; % counter of the days
stage_cost_matrix = zeros(T,2);  % it contains both the stage cost due to methane
% and the stage cost in terms of comfort
min_temp = TAint(1);
max_temp = TAint(length(TAint));
DAY = 1;

for t=1:T
    if mod(t, ((96*DAY)+1) ) == 0 && t>=DaySamplingNum+1  % It selects the day
        k = k+1; 
        DAY = DAY+1;
    end
    
    Text = x(t,1);
    
    % Find U indices at time t
    num_bin = (Text - average_temp_simulation(t))/0.5;
    index_temp_out = 8+num_bin;  % temp anomaly 0 stays in the entry 8
    index_temp_int = find(TAint==Tint);
    
    u = U(index_temp_out,index_temp_int,t);

    [Tint_plus] = RC_prediction_func(Text,Tint,u,c1,c2);
    [cost, comfort, methane] = RC_stage_cost(Tint, u, t, k, comfort1, comfort2);
    
    % Populate the stage cost vector, the costs matrix and the input vector
    ut(t,1) = u;
    
    gt(t,1) = cost;
    stage_cost_matrix(t,1) = comfort;
    stage_cost_matrix(t,2) = methane;
    
    % Round for quantization of temp
    x(t+1,2) = round(Tint_plus,1);
    Tint = round(Tint_plus,1);
    
end

%% Uncomment to see single run plot of the OP
% time = linspace(1,T,T);
% 
% % Plot of the OP evolution of the system (single run)
% figure,
% plot(time/4, x(1:T,2))
% hold on
% plot(time/4, x(1:T,1), 'blue')
% hold on
% legend('Indoor Temp', 'Outdoor Temp');
% xlabel('Time [Hours]');
% ylabel('Temperature (C°)'); 
% grid on

