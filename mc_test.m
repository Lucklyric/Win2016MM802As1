function [ output ] = mc_test(P,p0,n)
%MC_TEST Summary of this function goes here
%   Detailed explanation goes here
lastStateVector = zeros(1,n);
for i = 1:n
    simvector = mc_sim(P,p0,1000);
    lastStateVector(i) = simvector(end);
end

output = zeros(1,length(p0));
for i=1:length(p0)
    output(i) = length(find(lastStateVector==i)) / length(lastStateVector);
end
