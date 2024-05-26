# Radiator-Control-Project
Design a control system for turning on and off a radiator (both heuristic and optimal) that simultaneously considers the outdoor atmospheric temperature, the indoor room temperature, and the rate of change of the indoor temperature based on the outdoor temperature (stochastic with time-varying mean).

Implementation of the dynamic programming algorithm to identify the optimal policy. Running the script in "RC_MC" will display graphs,
the output of the Monte Carlo simulation. The model parameters are in "RC_setup", including the variable representing the simulation days. The initial state of the
external temperature is set to 21°C. To observe the graphs of a single simulation, access the "RC_heuristic_single_run" and "RC_OP_single_run" scripts and uncomment
the last lines of code; then, re-enter "RC_MC" and place a breakpoint at the end of the first iteration in the main loop (e.g., at line 98).

