function [U, V] = RC_optimal_policy(T,MeanTemperature,pW)

%% Compute optimal policy U (over t=1,...,T) 
%  and value function V (for t=1,...,T,T+1)
% 
% U(i,j,t) is optimal input at time t, if state is (i,j):
%            i-th outdoor temperature, j-th indoor temperature
%
% V(i,j,t) is optimal value function at time t, if state is (i,j):
%            i-th outdoor temperature, j-th indoor temperature
%



%% Parameters and Initialization

% Load setup data
[num_days,DaySamplingNum,temp_anomalies, ...
    ~,~,~,~,TAout,TAint]=RC_setup();

% Number of different inputs 
N_u=2;

% Number of indoor and aoutdoor temp states at time t 
Nout = length(temp_anomalies);
Nint = length(TAint); 

% Initialization of useful data structures
% U(i,j,t) = optimal input at time t when in state (i,j)
U=zeros(Nout,Nint,T); 

% Optimal value function (cost-to-go function)
V = zeros(Nout,Nint,T+1);

% Aux cost vector
C=zeros(1,N_u);

% Outdoor mean temp (length: T+1)
avg_temp_sim = repmat(MeanTemperature',1, num_days);



%% Computing all the possible temp values at time t, including the uncertainty
% Simulation of the outdoor states at time t
matrix_avg_temp_sim = repmat(avg_temp_sim, Nout, 1);

% Matrix representing 
matrix_temp_anomalies = repmat(temp_anomalies',1, length(avg_temp_sim));

% Outdoor possible temp values at time t
total_out_state_temp = matrix_avg_temp_sim + matrix_temp_anomalies;
%--------------------------------------------------------------------------



%% DP algorithm

% 1. Initialization
V(:,:,T+1) = zeros(Nout,Nint); % final

% Day index
k = num_days-1;

% 2. Main loop
for t=T:-1:1 % time index
    
    if mod(t, 96*k) == 0 && t<T+1  % It selects the day
        k = k-1; 
    end
        
    % Current outdoor mean temp state
    s1 = avg_temp_sim(t);

        for k2=1:Nint % Indoor temp state index

            % Current indoor temp state
            s2 = TAint(k2);

            if s2 == TAint(1)
            
                % Reached the indoor baseline temperature
                u_star = 1; % turn on the heating system
           
                % Optimal value function at time t, in state (s1,TAint(1))
                V_star = DP_RC_expected_cost(s2,u_star,V(:,:,t+1),t,k, ...
                        total_out_state_temp(:,t),pW);
                
         
            elseif s2 == TAint(Nint)
          
                % Reached the indoor baseline temperature
                u_star = 0; % turn off the heating system
           
                % Optimal value function at time t, in state (s1,Tint(Nint))
                V_star = DP_RC_expected_cost(s2,u_star,V(:,:,t+1),t,k, ...
                        total_out_state_temp(:,t),pW);
                
            else 
                 
                
                for u=0:N_u-1  % input index
                    
                    C(u+1) = DP_RC_expected_cost(s2,u,V(:,:,t+1),t,k, ...
                        total_out_state_temp(:,t),pW);
                    

                end % u loop

            % Find best input, and new cost-to-go value
            [V_star, u_star] = min(C);
            u_star = u_star-1;

            end %if
            
            for k1=1:Nout
                % Optimal input at time t, in state x
                U(k1,k2,t) = u_star;
              
                % Optimal value function at time t, in state x
                V(k1,k2,t) = V_star;
            end

        end % s2 loop
       
end % t loop






