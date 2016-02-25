function [ output ] = mc_sim( P,p0,n )
%MC_SIM Summary of this function goes here
%   Detailed explanation goes here
output = zeros(1,n);
stateArray = (1:1:length(p0));
currentState = 1;
output(currentState) = rv_sample(stateArray,p0,1);
for currentState=2:n
    output(currentState) = rv_sample(stateArray,P(output(currentState-1),:),1);
end

