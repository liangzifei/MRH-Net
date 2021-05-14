% Training the neural network by calling the function MRH_training.
% After training the network saved in current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
clc;clear; close all;
% please replace the location by your saved folder last step.
load_mat =['F:\Code\SRCNN\Submit_elife\traindata.mat'];
% please refine the channel according to USER selected MRI contrasts
% numbers from last step.
input_channel = 67;
%depth: 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
depth = 15;
net = MRH_training(load_mat, input_channel, depth);