% File name: RC_prediction_func.m

function [Tint_plus] = RC_prediction_func(Text,Tint,u,c1,c2)  

Tint_plus = Tint + c1*(Text-Tint)+c2*u;

