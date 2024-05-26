% File name: RC_stage_cost.m

function [cost, cost1, cost2] = RC_stage_cost(Tint, u, t, k, comfort1, comfort2) 

SamplingNum = 15;  % sampling period in minutes
Day_SamplingNum = 60/SamplingNum*24; % to return to the same hour adding 97 to the actual one
methane = 0.1155;  % price in euro of the methane consumption after 15 minutes of activation

if u == 0
	if t>=1+Day_SamplingNum*k && t<=Day_SamplingNum*k+4
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = 0;       
        end
	elseif t>=Day_SamplingNum*k+5 && t<=Day_SamplingNum*k+28
        if Tint>=16.5
		    cost1 = abs(16.5-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(16.5-Tint)*comfort2;
            cost2 = 0;               
        end
    elseif t>=Day_SamplingNum*k+29 && t<=Day_SamplingNum*k+48
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = 0;               
        end
    elseif t>=Day_SamplingNum*k+49 && t<=Day_SamplingNum*k+72
        if Tint>=18.0
		    cost1 = abs(18.0-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(18.0-Tint)*comfort2;
            cost2 = 0;               
        end    
	elseif t>=Day_SamplingNum*k+73 && t<=Day_SamplingNum*k+92
        if Tint>=19.5
		    cost1 = abs(19.5-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(19.5-Tint)*comfort2;
            cost2 = 0;               
        end   
    elseif t>=Day_SamplingNum*k+93 && t<=Day_SamplingNum*k+96
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = 0;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = 0;               
        end  
    end
end

if u == 1
	if t>=1+Day_SamplingNum*k && t<=Day_SamplingNum*k+4
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = methane;       
        end
	elseif t>=Day_SamplingNum*k+5 && t<=Day_SamplingNum*k+28
        if Tint>=16.5
		    cost1 = abs(16.5-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(16.5-Tint)*comfort2;
            cost2 = methane;               
        end
    elseif t>=Day_SamplingNum*k+29 && t<=Day_SamplingNum*k+48
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = methane;               
        end
    elseif t>=Day_SamplingNum*k+49 && t<=Day_SamplingNum*k+72
        if Tint>=18.0
		    cost1 = abs(18.0-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(18.0-Tint)*comfort2;
            cost2 = methane;               
        end    
	elseif t>=Day_SamplingNum*k+73 && t<=Day_SamplingNum*k+92
        if Tint>=19.5
		    cost1 = abs(19.5-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(19.5-Tint)*comfort2;
            cost2 = methane;               
        end   
    elseif t>=Day_SamplingNum*k+93 && t<=Day_SamplingNum*k+96
        if Tint>=17.5
		    cost1 = abs(17.5-Tint)*comfort1;
            cost2 = methane;
        else 
            cost1 = abs(17.5-Tint)*comfort2;
            cost2 = methane;               
        end  
    end
end
% disp(cost1)
cost = cost1+cost2;  % total cost

