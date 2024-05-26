function [ec]=DP_RC_expected_cost(s2,u,V_next,t,k,vector_Tout,pW)

%% Expected cost

% (s(1),s(2)) = (s1,s2) = (Tout,Tint) is current state, u is current input,
%
% ec is the expected value of stage cost + value function
%
% we are in the case in which the cost is deterministic gt(st, ut, wt) =
% gt(st,ut) = gt(s2t,ut) for all wt


%% Parameters

% Load setup data
[~,~,temp_anomalies, ...
    c1,c2,comfort1,comfort2,~,TAint]=RC_setup();

% Number of possible out temp anomaly values 
N_w = length(temp_anomalies);  

% Number of possible int temp values
N_int = length(TAint);

% Rename more intuitively s2 
Tint = s2;



%% Expected value of stage cost 

% Stage cost is deterministic
esc = RC_stage_cost(Tint, u, t, k, comfort1, comfort2);



%% Expected value of cost-to-go

% Consider all possible next temp states (outdoor and indoor)  
% Tout_next = vector_Tout_next; % next outdoor temp states (stochastic)

Tint_next = zeros(N_w,1); % next indoor temp states (stochastic)

% Prob of the temp indoor next state
P_Tint_next = zeros(N_int,1);  % vector 66x1

% All possible next indoor temp states 
for l=1:N_w

    [Tint_next_plus] = RC_prediction_func(vector_Tout(l),Tint,u,c1,c2); 
    Tint_next(l) = round(Tint_next_plus,1); 

    % Corresponding probabilities
    P_Tint_next_aus = zeros(N_int,1);

    P_next_int_index = int64((Tint_next(l)-TAint(1))*10+1);
    P_Tint_next_aus(P_next_int_index,1) =  pW(l);
    P_Tint_next = P_Tint_next + P_Tint_next_aus; % Prob vector next temp out
 
end

% Prob of the next state 
P_next = zeros(N_w, N_int);  % 16x66

for i=1:N_w % outdoor   
    for j=1:N_int % indoor
        P_next(i,j) = pW(i)*P_Tint_next(j);
    end
end

% Compute expected value 
ev=0;
for i=1:N_w    
    for j=1:N_int
        ev = ev+P_next(i,j)*V_next(i,j);
    end
end


%% Expected value of stage cost + cost-to-go

% Expected cost is stage cost + expected cost-to-go
ec = esc + ev;


