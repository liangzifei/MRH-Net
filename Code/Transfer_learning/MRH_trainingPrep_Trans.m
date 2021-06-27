%  Training data generation
%  The data is prepared from inital analyzed format dMRI data and saved in .mat file.

% Input:
%
% location: the location of dmri analyzed image.
% ---default=R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\
%halfsize_input : the patchsize preparison paramter.
%--- default=1 means the pathsize is 2*1+1 = 3
% stride: the sample location of the training coordinates within a 3D brain
% grids. --- default =20 means sample on point every 20 pixels
% (User, by self, can exclude pixels that are cracked or missed in Histology, espcially void ventrical pixels,
% to mitigate these noisy pixels influence to succeeding network training). 
% Output(saved):
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

function [data,label] = MRH_trainingPrep_Trans(folder_dwi, halfsize_input, stride0,fluo_img)
% folder_dwi =['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\C'];
%% start loop %%%%%%%%%%%%%%%%
% halfsize_input = 1;
% size_label = 1;
% scale = 3;
% stride = 20;
file_list = dir(folder_dwi); file_list(1:2) = [];
count=0;
% sample_num=[1,2,4,5];
%% here sample subject 2-6 is used for training
for sample_img = 1:length(file_list)
    %dwi2000 is the diffusion data scanned from b=2000
    dwi2000 = load_untouch_nii([folder_dwi,file_list(sample_img).name,'\rigidaffine_Lddm_dwi2000.img']);
    % dwi5000 is diffusion b=5000 data
    dwi5000 = load_untouch_nii([folder_dwi,file_list(sample_img).name,'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,file_list(sample_img).name,'\rigidaffine_lddm_t2MTONOFF.img']);
    fa_img = load_untouch_nii([folder_dwi,file_list(sample_img).name,'\rigidaffine_Lddm_fa.img']);
    fa_mask = load_untouch_nii([folder_dwi,file_list(sample_img).name,'\Masked_outline.img']);
    
    % all MRI and AllenPathology registered in P60 here one target is used
    % as example. Please replace by self defined histology, for any other
    % data. voxel-wise data preparison dose not change pixel-wise
    % information by warping from subject to P60 template space.
    
    % data locate under /Train_data
%     fluo_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\Allen_fluorescence',...
%         '\AllenPathology2TanzilP60.img']);
    %'\mean10_data',num2str(sample_img),'.img']);
    
    % data pre-process %%%%%%%%%%%%%%%%%
    dwi_data = cat(4,dwi2000.img,dwi5000.img,t2MTONOFF.img);
    fa_data=fa_img.img; fa_data(isnan(fa_data))=0; dwi_data(isnan(dwi_data))=0;
    mask_data = fa_mask.img; mask_data(isnan(mask_data))=0;
    fluo_data = fluo_img.img; fluo_data(isnan(fluo_data))=0;
    
    dwi_data=permute(dwi_data,[1,3,2,4]); fa_data=permute(fa_data,[1,3,2]);
    mask_data = 1- permute(mask_data,[1,3,2]); fluo_data = permute(fluo_data,[1,3,2]);
    
    dwi_data=double(dwi_data);%./double(max(max(max(max(max(dwi_data))))));
    fa_data=double(fa_data);%./double(max(max(max(max(max(fa_data))))));
    
    [A,B,C,D]=size(dwi_data);
    figure;subplot(1,2,1);imshow(fluo_data(:,:,124),[]); subplot(1,2,2);imshow(fa_data(:,:,124),[]);
    %clear dwi_img fa_img;
    [hei,wid,C,channel]=size(dwi_data);
    %% loop count samples %%%%%%%%%%%%%%%%%%%%%%%%%
    % 118:159---please change to coregistered MRI and histology slices,
    % default is our MBP coregistered slices.
    for slice=118:159
        % sample locations that are rational locations, we use fa data as a
        % reference, USER can define by self.
        tempt = fa_data(:,:,slice);
        temp=tempt(tempt>102);
        sum_temp=sum(logical(temp));
        if sum_temp>1000
            stride = 6;
        elseif sum_temp<40000
            stride = 8;
        else 
            stride = stride0;
        end
        for x = 1+halfsize_input : stride : hei-halfsize_input
            for y = 1+halfsize_input :stride : wid-halfsize_input
                % include all MRI contrasts [1:end], USER can select input
                % channels want to use here
                subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,[1:end]);
                %% only diffusion MRI %%%%%%%%%%%%%%%%%%%%%%%%%
                subim_label = fluo_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice);
                flag = sum(sum(sum(subim_label))); sum_fa=sum(sum(sum(sum(logical(subim_label)))));
                if (flag<30||isnan(flag)||sum_fa<4||mask_data(x,y,slice))
                    continue;
                else
                    count=count+1
                    data(:, :, :, count) = permute(subim_input,[1,2,4,3]);
                    label(:, :, :, count) = subim_label;
                end
            end
        end
    end
end
% rearrage the training samples in random order.
order = randperm(count);
data = data(:, :, :,order);
label = label(:, :,:,  order);
save traindata.mat data label -v7.3;