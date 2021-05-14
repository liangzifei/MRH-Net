% Training data preparison by calling MRH_trainingG.
%After running the demo, the data and label file
% in .mat form like traindataJG_allMRIs_fluo.mat data label -v7.3; should be saved in
% your current folder.

%  - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
% Please replace by the training data location by USER
work_folder = ['R:\zhangj18lab\zhangj18labspace\',...
    'Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\train\'];
halfpatch_size = 1;
stride0 = 20;
% location of the target histology .img. Please replace the location by
% USER. data location under /Train_data
myelin_img = load_untouch_nii(['K:\SRCNN_deltADC\Reg_landmark\myelin\Myelin42_to_P60.img']);
[data,label] = MRH_trainingG_Trans(work_folder,halfpatch_size,stride0, myelin_img);