% after running the demo, the data and label file
% in .mat form like Ypred.mat -v7.3; should be saved in
% your current folder.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
load_data = 'testdataPatch_mouse.mat';
load_net = 'net_30layerV3Res_HRJG_allMRIs_onesample2fluo5000d.mat';
% load_mat =['F:\Code\SRCNN\Fluorescence\traindata.mat'];
% input_channel = 67;
% 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
depth = 30;
YPred =  MRH_testing(load_data, load_net);
save YPred.mat YPred;