%  Testing data generation
%  The data is prepared from inital analyzed format dMRI data and saved in .mat file.

% Input:
%
% foder_dwi: the location of dmri analyzed image.
% ---default=work_folder = ['.\Test_Data'];
%halfsize_input : the patchsize preparison paramter.
%--- default=1 means the pathsize is 2*1+1 = 3
% stride: the sample location of the training coordinates within a 3D brain
% grids. --- default =1 means sample each specific pixels among the entire
% brain.
% slice_num_start, slice_num_end: start and end slices to be tested.
% By default, only one slice is tested.
%
% Output(saved file):
%
% data: is a 3x3xMxN matrix that for nerual network input.
% label: is a 3x3xN matrix that for neurual network training target.
%
% Usage: [data,label] = MRH_trainingG(['R:\zhangj18lab\zhangj18labspace\'...
%'Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\C'],...
%3,20)

%  - Zifei Liang (zifei.liang@nyumc.org)

% Using code please refer our work:
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

function [data,fa] = MRH_testingPrep(folder_dwi, halfsize_input, stride,sample_num,slice_num_start, slice_num_end)
folder_list=dir(folder_dwi); folder_list(1:2) = [];
% count the test samples amount. 
count=0;
for sample_img =sample_num:sample_num%length(file_list)
    % load all MRI images.
    dwi2000 = load_untouch_nii([folder_dwi,folder_list(sample_num).name,'\rigidaffine_Lddm_dwi2000.img']);
    dwi5000 = load_untouch_nii([folder_dwi,folder_list(sample_num).name,'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,folder_list(sample_num).name,'\rigidaffine_lddm_t2MTONOFF.img']);
    fa_img = load_untouch_nii([folder_dwi,folder_list(sample_num).name,'\rigidaffine_Lddm_fa.img']);
    fa_mask = load_untouch_nii([folder_dwi,folder_list(sample_num).name,'\Masked_outline.img']);
    %     axon_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\',...
    %         'JesseGray\JesseGray20191223\Porcessed\Axon_to_C',num2str(sample_img),'.img']);
    
    %% data pre-process %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dwi_data = cat(4,dwi2000.img,dwi5000.img,t2MTONOFF.img);
    fa_data=fa_img.img; fa_data(isnan(fa_data))=0; dwi_data(isnan(dwi_data))=0;
    mask_data = fa_mask.img; mask_data(isnan(mask_data))=0;
    %     ns_data = axon_img.img; ns_data(isnan(ns_data))=0;
    
    dwi_data=permute(dwi_data,[1,3,2,4]); fa_data=permute(fa_data,[1,3,2]);
    mask_data = 1- permute(mask_data,[1,3,2]); %ns_data = permute(ns_data,[1,3,2]);
    
    dwi_data=double(dwi_data);%./double(max(max(max(max(max(dwi_data))))));
    fa_data=double(fa_data);%./double(max(max(max(max(max(fa_data))))));
    
    [A,B,C,D]=size(dwi_data);
    %     figure;subplot(1,2,1);imshow(ns_data(:,:,124),[]); subplot(1,2,2);imshow(fa_data(:,:,124),[]);
    %clear dwi_img fa_img;
    [hei,wid,C,channel]=size(dwi_data);
    %% loop count samples %%%%%%%%%%%%%%%%%%%%%%%%%
    %     for slice=1:228
    for slice=slice_num_start:slice_num_end
        %         seg_slice=seg_P60data(:,:,slice);
        for x = 1+halfsize_input : stride : hei-halfsize_input
            for y = 1+halfsize_input :stride : wid-halfsize_input
                subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,[1:end]);
                %                 subim_label = ns_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice);
                subim_fa = fa_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice);
                count=count+1
                data(:, :, :, count) = permute(subim_input,[1,2,4,3]);
                fa(:, :, :, count) = subim_fa;
            end
        end
    end
end
% save testing patches in mat file.
save  testdataPatch_mouse.mat data fa -v7.3;
