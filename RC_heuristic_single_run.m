function  [x, ut, gt, stage_cost_matrix, epsilon] =  RC_heuristic_single_run(heuristic, ...
    MeanTemperature,pW,T,U,Tint)

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
Temp_simulation = repmat(MeanTemperature',1, num_days);
Temp_simulation = Temp_simulation+epsilon;  % add the noise
x(:,1) = Temp_simulation;  % store the results in the first column



%% Internal Temperature and cost simulation (heuristic policy)

% Initialization
x(1,2) = Tint;  % indoor temperature at time 0
u = U(1,1);  % initial input: '0' = radiator is turned on
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
    
    [Tint_plus] = RC_prediction_func(Text,Tint,u,c1,c2);
    [cost, comfort, methane] = RC_stage_cost(Tint, u, t, k, comfort1, comfort2);
    
    % Populate the stage cost vector, the costs matrix and the input vector
    ut(t,1) = u;
    
    gt(t,1) = cost;
    stage_cost_matrix(t,1) = comfort;
    stage_cost_matrix(t,2) = methane;
    
    % Round for quantization of temp
    x(t+1,2) = round(Tint_plus,1);
    Tint = Tint_plus;
    
    if strcmp(heuristic, 'heuristic 1')
        
        %% Heuristic policy 1:
        %   heating system activation below 'min_temp' and deactivation
        %   above 'max_temp'
        if u == 0 && Tint<=min_temp
            u = U(2,t);
        elseif u == 1 && Tint >= max_temp
            u = U(1,t);
        end
    elseif strcmp(heuristic, 'heuristic 2')
        
        %% Heuristic policy 2:
        %   heating system activation below 16 C° and deactivation
        %   above 19 C°
        if u == 0 && Tint<=16
            u = U(2,t);
        elseif u == 1 && Tint >= 19
            u = U(1,t);
        end
    end
    
end

%% Uncomment to see single run plot of the heuristic
time = linspace(1,T,T);

% Plot of the evolution of the system (single run)
% if strcmp(heuristic, 'heuristic 1')
%     figure,
%     plot(time/4, x(1:T,2))
%     hold on
%     plot(time/4, x(1:T,1), 'blue')
%     hold on
%     strcmp(heuristic, 'heuristic 1')
%     plot(time/4, ut+((min_temp+max_temp)/2)-0.5)
%     legend('Indoor Temp', 'Outdoor Temp', 'State of radiator');
%     xlabel('Time [Hours]');
%     ylabel('Temperature (C°)'); 
%     grid on
% elseif strcmp(heuristic, 'heuristic 2')
%     figure,
%     plot(time/4, x(1:T,2))
%     hold on
%     plot(time/4, x(1:T,1), 'blue')
%     hold on
%     strcmp(heuristic, 'heuristic 1')
%     plot(time/4, ut+((16+19)/2)-0.5)
%     legend('Indoor Temp', 'Outdoor Temp', 'State of radiator');
%     xlabel('Time [Hours]');
%     ylabel('Temperature (C°)'); 
%     grid on 
% end 
