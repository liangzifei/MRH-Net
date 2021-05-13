% after running the demo, the data and label file
% in .mat form like traindataJG_allMRIs_fluo.mat data label -v7.3; should be saved in
% your current folder.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
work_folder = ['R:\zhangj18lab\zhangj18labspace\Zifei_Data\',...
    'HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\Train_Subjs\C'];
patch_size = 3;
stride = 1;
sample_img = 6;
%%only one slice 140 generated here. Whole brain volume generate, please run a
%%loop by user.
slice_num = 140;
[data,label] = MRH_testingG(work_folder,patch_size,stride,sample_img,slice_num);