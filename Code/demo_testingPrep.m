% Testing data preparison by calling MRH_testingPrep.
%After running this demo, the data and label file
% in .mat form like testdata.mat data label -v7.3; will be saved in
% current workspace.
%  - Zifei Liang (zifei.liang@nyumc.org)

% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
%please save test data as the following recommended folder.And USER need to
%replace by their own workspace: under \Test_data
work_folder = ['.\Test_Data'];
halfpatch_size = 1;
% sample testing pathces without pixels skip. stride setting 1, sampling
% one-by-one covering entire brains.
stride = 1;
%Only one subject put in the test folder. sample_num is ready to be modified by
%USER to process more subjects using batching
sample_num = 1;
%Only one slice 140 generated here. More slices generation, please specific slice start and end number.
slice_num_start= 140; slice_num_end=140;
% Call testing patches generation function.
[data,label] = MRH_testingPrep(work_folder,halfpatch_size,stride,sample_num,slice_num_start, slice_num_end);