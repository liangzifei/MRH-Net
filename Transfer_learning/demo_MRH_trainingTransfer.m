% after running the demo, the data and label file
% in .mat form like traindataJG_allMRIs_fluo.mat data label -v7.3; should be saved in
% your current folder.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
load_mat =['F:\Code\SRCNN\Fluorescence\traindata.mat'];
pre_network = ['net_30layerV3Res_HRJG_allMRIs_ave2000fluo.mat'];
% 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
networkDepth = 30;
net = MRH_training_Transfer(load_mat, networkDepth, pre_network);
save net.mat net;