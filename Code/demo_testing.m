% After running this demo, the data and label file
% in .mat form like Ypred.mat -v7.3; will be saved in
% current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
% Please relocate your test data and pretrained network locations.
% load_data under \Test_Data
%load_net under  \network
load_data = '.\Test_Data\testdataPatch_mouse.mat';
load_net = '.\network\net_30layerV3Res_HRJG_allMRIs_Fluo.mat';
% load_mat =['F:\Code\SRCNN\Fluorescence\traindata.mat'];
% input_channel = 67;
% 30 is used in the paper for auto-fluorescence training task, 
%as large amount data accessable from allen.
% Shorter is more resaonable under the condition limited training data offered.
%3 is tested and verified on MR to myelin network training
% depth = 30;
% call testing function.
YPred =  MRH_testing(load_data, load_net);
% load FA as a reference
load(load_data,'fa');
save YPred.mat YPred fa;