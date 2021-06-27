% Training the neural network by calling the function MRH_training.
% After training, the network will be saved in current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
clc;clear; close all;
% please replace by the prepared training patches producted from last step.
% Our exmple training patches from autofluorescence in .mat format 
% can be downloaded from https://osf.io/fk58t/; Please revise the file
% name.
load_mat =['.\traindata.mat'];
% please refine the channel according to USER selected MRI contrasts
% numbers from last step.
input_channel = 67;
%depth: 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
depth = 30;
% call training funciton.
net = MRH_training(load_mat, input_channel, depth);