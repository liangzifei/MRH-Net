% after running the demo, the data and label file
% in .mat form like traindataJG_allMRIs_fluo.mat data label -v7.3; should be saved in
% your current folder.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
load_mat =['F:\Code\SRCNN\Fluorescence\traindataJG_allMRIs_fluo49_histadj.mat'];
input_channel = 67;
% 30 is used in the paper for auto-fluorescence training job.
% 3 is also tested on MR to myelin network training
depth = 30;
net = MRH_training(load_mat, input_channel, depth);