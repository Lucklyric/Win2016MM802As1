function [ output ] = rv_sample( sx,p,m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
rng('shuffle');
p = cumsum(p);
random = rand(m,1);
output = zeros(1,length(m));
for i = 1 : m
    number_idx = 0;
    if 0 < random(i) && random(i)<= p(1)
        number_idx = 1;
    end
    for j = 2:length(sx)
        if p(j-1)< random(i) && random(i) <=p(j)
            number_idx = j;
            break;
        end
    end
    output(i) = sx(number_idx);
end

