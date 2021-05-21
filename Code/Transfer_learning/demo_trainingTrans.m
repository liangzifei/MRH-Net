% Training the neural network by calling the function MRH_training_Trans.
% After training the network saved in current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
% Please replace the file location by USER. load_mat refer under
% /Train_data. pre_network refer under /network.
load_mat =['F:\Code\SRCNN\myelin\traindataJG_allMRIs.mat'];
pre_network = ['F:\Code\SRCNN\Submit_elife\Pre_trained_Network\net_30layerV3Res_HRJG_allMRIs_Fluo.mat'];
% 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
networkDepth = 30;
net = MRH_training_Trans(load_mat, networkDepth, pre_network);