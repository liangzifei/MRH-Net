% Testing data preparison by calling MRH_testingG.
%After running the demo, the data and label file
% in .mat form like testdata.mat data label -v7.3; should be saved in
% your current folder.

%  - Zifei Liang (zifei.liang@nyumc.org)

% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
%please save test data as the following recommended folder.And USER need to
%replace by their own workspace: under \Test_data
work_folder = ['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\',...
    'DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\test\'];
halfpatch_size = 1;
stride = 1;
%Only one subject put in the test folder. sample_num is ready to be modified by
%USER to process more subjects using batching
sample_num = 1;
%only one slice 140 generated here. More slices generation, please specific slice start and end number.
slice_num_start= 140; slice_num_end=140;
[data,label] = MRH_testingG(work_folder,halfpatch_size,stride,sample_num,slice_num_start, slice_num_end);