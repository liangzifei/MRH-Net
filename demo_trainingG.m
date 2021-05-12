% after running the demo, the data and label file
% in .mat form like traindataJG_allMRIs_fluo.mat data label -v7.3; should be saved in
% your current folder.
%  - Zifei Liang (zifei.liang@nyumc.org)
clc;clear; close all;
work_folder = ['R:\zhangj18lab\zhangj18labspace\'...
'Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\C'];
patch_size = 3;
stride = 20;
[data,label] = MRH_trainingG(work_folder,patch_size,stride)