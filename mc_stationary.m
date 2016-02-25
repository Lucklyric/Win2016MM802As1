function [ steadArray ] = mc_stationary( P )
%MC_STATIONARY Summary of this function goes here
%   Detailed explanation goes here
steadArray = P(1,:);
while isequal( steadArray,steadArray*P) == 0
    steadArray = steadArray*P;
end

