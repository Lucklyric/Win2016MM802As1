function [] = main()
%MAIN Summary of this function goes here
%   Detailed explanation goes here
% main function for calling sub functions here
clear all;
% set seed
rng('shuffle');
% set P matrix
P = [0.5 0.25 0.25;0.5 0.25 0.25;0.75 0 0.25];
% set P0
p0 = [0.2 0.2 0.6];
% get stationary probabilities
steadyP = mc_stationary(P);
% apply mc_test with n times of calling of mc_sim and get the P
% distribution at setp 1000
% compare resluts with stationary probabilities
out = mc_test(P,p0,10000);
disp('mc_test_output:');
disp(out);
disp('mc_stationary_output:')
disp(steadyP);
end

function [ output ] = rv_sample( sx,p,m )
%rv_sample Summary of this function goes here
%   Detailed explanation goes here
% calculate the comulative probability array 
p = cumsum(p);
% random a number betwen 0 and 1
random = rand(m,1);
output = zeros(1,length(m));
% if the number is any interval of above comulative probability array then
%choose the sample number on the left of the interval.
for i = 1 : m
    number_idx = 0;
    if 0 < random(i)
        if random(i)<= p(1)
            number_idx = 1;
        end
    end
    for j = 2:length(sx)
        if p(j-1)< random(i)
            if random(i) <=p(j)
                number_idx = j;
                break;
            end
        end
    end
    output(i) = sx(number_idx);
end
end

function [ output ] = mc_sim( P,p0,n )
%MC_SIM Summary of this function goes here
%   Detailed explanation goes here
output = zeros(1,n);
% init state array
stateArray = (1:1:length(p0));
currentState = 1;
% based on the p0 to generage the current state with length 1 for rv_sample
output(currentState) = rv_sample(stateArray,p0,1);
for currentState=2:n
    % based on the previous state and the corresponding row in P to
    % generate the next random state 
    output(currentState) = rv_sample(stateArray,P(output(currentState-1),:),1);
end
end

function [ steadArray ] = mc_stationary( P )
%MC_STATIONARY Summary of this function goes here
%   Detailed explanation goes here
% inite an array randomly (I choose the first row from P matrix)
steadArray = P(1,:);
% if some array a*P = a then it is the stationary probabilities
while isequal( steadArray,steadArray*P) == 0
    % update the steadArray
    steadArray = steadArray*P;
end
end

function [ output ] = mc_test(P,p0,n)
%MC_TEST Summary of this function goes here
%   Detailed explanation goes here
lastStateVector = zeros(1,n);
for i = 1:n
    % genearte one sim sequence with 1000 steps
    simvector = mc_sim(P,p0,1000);
    % store the last state into the array
    lastStateVector(i) = simvector(end);
end

% calculate the prob distribution for each state at 1000th step among all
% sim sequence
output = zeros(1,length(p0));
for i=1:length(p0)
    output(i) = length(find(lastStateVector==i)) / length(lastStateVector);
end
end

