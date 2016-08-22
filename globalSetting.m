function G = globalSetting( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

G.hours = 24;
G.timespan = 30; %in minutes
G.horizon = G.hours * 60 / G.timespan ;

G.t1_MG = 30;
G.t2_MG = 0;
G.t3_MG = 0;

G.numofMG = G.t1_MG + G.t2_MG + G.t3_MG ;


G.belta = 0; %percetage of profit shared by DSO;

load('price.mat');
G.price = price;
clear price;







end

