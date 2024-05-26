%% Monte Carlo Simulation

close all
clear;
clc


%% Parameters

% Number of simulations runs
Nrun=1000;

% Load some parameters defined in file RC_setup.m:
%   Number of simulation days (num_days), 
%   number of samples in a day (DaySamplingNum), parameter to the heat
%   transfer when radiator is turned on (c1), ... turned off (c2), 
%   parameters associated to the comfort cost (comfort1, comfort2),
%   admissible indoor and outdoor temp values (TAint,TAout)
[num_days,DaySamplingNum,temp_anomalies, ...
    c1,c2,comfort1,comfort2,TAout,TAint]=RC_setup();

% Load the simulated temperatures (discretized)
load("mean_temp")
MeanTemperature = round_mean_temp;

% Load and define the prob of temp anomaly
load("prob_anomaly");
pW = prob_anomaly;

% Length of each run:
% e.g from 1 Jan to 31 Jan there are 2976 states of Tint and Tout (Tout is
% simulated); => there will be 2975 values of gt and ut, while g(T), the 
% terminal cost, 
T = DaySamplingNum*num_days-1;  



%% Initialization

% Inizialize matrices to store results of simulation runs
x_star=zeros(T+1,Nrun*2);
u_star=zeros(T,Nrun);
gt_star_comfort=zeros(T,Nrun);
gt_star_methane=zeros(T,Nrun);
w_star=zeros(T+1,Nrun);


x_h1=zeros(T+1,Nrun*2);
u_h1=zeros(T,Nrun);
gt_h1=zeros(T,Nrun);
gt_h1_comfort = zeros(T,Nrun);
gt_h1_methane = zeros(T,Nrun);
w_h1=zeros(T+1,Nrun);


x_h2=zeros(T+1,Nrun*2);
u_h2=zeros(T,Nrun);
gt_h2=zeros(T,Nrun);
gt_h2_comfort = zeros(T,Nrun);
gt_h2_methane = zeros(T,Nrun);
w_h2=zeros(T+1,Nrun);



%% Compute different policies: Optimal, Heuristic 1, Heuristic 2

% Optimal Policy
[U_star, V] = RC_optimal_policy(T, MeanTemperature, pW);

% Heuristic policy 1: heating system activation below 14.5 °C and deactivation above 21 °C
u1=0;  % input: '0' = radiator is turned on
u2=1;  % input: '1' = radiator is turned off
U_h1 = repmat([u1 u2]',1,T); 

% Heuristic policy 2: 
U_h2 = repmat([u1 u2]',1,T); 


%% Main loop

% Initial state for the indoor temp
Tint = 21.0;  % Initial temperature of the room

for h=1:Nrun
    % Optimal policy
    [x_star(:,(2*h-1):(2*h)), u_star(:,h), gt_star(:,h), stage_cost_matrix, w_star(:,h)] = RC_OP_single_run(MeanTemperature,pW,T,U_star,Tint);
    gt_star_comfort(:,h) = stage_cost_matrix(:,1);
    gt_star_methane(:,h) = stage_cost_matrix(:,2);

    % Heuristic policy 1
    [x_h1(:,(2*h-1):(2*h)), u_h1(:,h), gt_h1(:,h), stage_cost_matrix, w_h1(:,h)] =  RC_heuristic_single_run("heuristic 1", MeanTemperature,pW,T,U_h1,Tint);
    gt_h1_comfort(:,h) = stage_cost_matrix(:,1);
    gt_h1_methane(:,h) = stage_cost_matrix(:,2);
    
    % Heuristic policy 2
    [x_h2(:,(2*h-1):(2*h)), u_h2(:,h), gt_h2(:,h), stage_cost_matrix, w_h2(:,h)] =  RC_heuristic_single_run("heuristic 2", MeanTemperature,pW,T,U_h2,Tint);
    gt_h2_comfort(:,h) = stage_cost_matrix(:,1);
    gt_h2_methane(:,h) = stage_cost_matrix(:,2);

end


%% Plot and write results 

% Some plots
[J_star, J_star_methane, J_star_comfort, J_h1, J_h1_methane, J_h1_comfort, J_h2, J_h2_methane, ... 
    J_h2_comfort] = DP_RC_plot(gt_star, gt_star_comfort, gt_star_methane, gt_h1, gt_h1_comfort, gt_h1_methane, gt_h2, ...
    gt_h2_comfort, gt_h2_methane, Nrun, T);


% Write some results
disp(' ');
disp(['Time horizon T = ' num2str(T) ]);
disp(['Number of simulation runs = ' num2str(Nrun)])
disp(['Initial indoor temperature Tint = ' num2str(Tint)])
disp(' ');
disp('********* Average total cost ***********' )
disp(['Optimal policy     = ' num2str(mean(J_star))]); 
disp(['  - Cost of methane = ' num2str(mean(J_star_methane)) ' euro']);
disp(['  - Cost in term of comfort  = ' num2str(mean(J_star_comfort))]);
disp(' ');
disp(['Heuristic policy 1 = ' num2str(mean(J_h1))]); 
disp(['  - Cost of methane = ' num2str(mean(J_h1_methane)) ' euro']);
disp(['  - Cost in term of comfort  = ' num2str(mean(J_h1_comfort))]);
disp(' ');
disp(['Heuristic policy 2 = ' num2str(mean(J_h2))]); 
disp(['  - Cost of methane = ' num2str(mean(J_h2_methane)) ' euro']);
disp(['  - Cost in term of comfort  = ' num2str(mean(J_h2_comfort))]);
disp(' ');
disp(['Expected optimal total cost from Tint: V0(Tint) = ' num2str(V(end,find(TAint == Tint),1)) ] );





