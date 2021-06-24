% Training the neural network by calling the function MRH_training_Trans.
% After training the network saved in current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
% Please replace by the training patches generated from demo_trainingG_Trans.m 
% One example can be downloaded from https://osf.io/rw42b/
load_mat =['.\traindataJG_allMRIs.mat'];
% Pretrained network from autofluorescence, worked as a generic network for transfer learning, 
% can be found under \network
pre_network = ['.\network\net_30layerV3Res_HRJG_allMRIs_Fluo.mat'];
% 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
networkDepth = 30;
net = MRH_training_Trans(load_mat, networkDepth, pre_network);