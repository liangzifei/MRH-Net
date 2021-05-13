%  Testing data generation
%  The data is prepared from inital analyzed format dMRI data and saved in .mat file.

% Input:
%
% location: the location of dmri analyzed image.
% ---default=R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\
%halfsize_input : the patchsize preparison paramter.
%--- default=1 means the pathsize is 2*1+1 = 3
% stride: the sample location of the training coordinates within a 3D brain
% grids. --- default =1 means sample each specific pixels among the entire
% brain.
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
function [data,fa] = MRH_testingG(folder_dwi, halfsize_input, stride,sample_num,slice_num)
% file_list=dir('K:\SRCNN_deltADC\raw_data\Aftlddmw*_dwi_biasCor.img');
%% use the file with 30 direction for comparison %%%%%%%%%%%%%%%%%%%%%
% folder_dwi =['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\Train_Subjs\C'];
%% start loop %%%%%%%%%%%%%%%%
% halfsize_input = 1;
% size_label = 1;
% scale = 3;
% stride = 1;
count=0;
% select_num25 = [66 67];
% select_num50 = [67,66,34,1,33,65];
% select_num75 = [67	66	34	1	33	65	3	5	2	4	24	21	11	30	6	9	8	15	31	26];
% select_num85 = [67	66	34	1	33	65	3	5	2	4	24	21	11	30	6	9	8	15	31	26	28	25	7	27	13	17	20	29	16	23];

% sample_num=[1,2,3,4];
for sample_img =sample_num:sample_num%length(file_list)
    dwi2000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi2000.img']);
    dwi5000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_lddm_t2MTONOFF.img']);
    fa_img = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_fa.img']);
    fa_mask = load_untouch_nii([folder_dwi,num2str(sample_img),'\Masked_outline.img']);
    axon_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\',...
        'JesseGray\JesseGray20191223\Porcessed\Axon_to_C',num2str(sample_img),'.img']);
    
    %% data process %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     tempt1 = load_untouch_nii([folder_dwi,file_list(sample_img).name]);
    %     tempt2 = load_untouch_nii([folder_dwi,'rigid_affine_t2m0mtt2star.img']);
    %     fa_img=load_untouch_nii([folder_famd,'fitted_rigidaffine.img']);
    %     ns_img=load_untouch_nii([folder_famd,'Axon_toFA.img']);
    %
    %     dwi_data=cat(4,tempt1.img,tempt2.img); fa_data=fa_img.img(:,:,:,1); fa_data(isnan(fa_data))=0;
    %     dwi_data=permute(dwi_data,[1,3,2,4]); fa_data=permute(fa_data,[1,3,2]);
    % %     md_data = fa_img.img(:,:,:,2);  md_data(isnan(md_data))=0; md_data=permute(md_data,[1,3,2]);
    %     ns_data = ns_img.img; ns_data(isnan(ns_data))=0; ns_data = permute(ns_data,[1,3,2]);
    
    dwi_data = cat(4,dwi2000.img,dwi5000.img,t2MTONOFF.img);
    fa_data=fa_img.img; fa_data(isnan(fa_data))=0; dwi_data(isnan(dwi_data))=0;
    mask_data = fa_mask.img; mask_data(isnan(mask_data))=0;
    ns_data = axon_img.img; ns_data(isnan(ns_data))=0;
    
    dwi_data=permute(dwi_data,[1,3,2,4]); fa_data=permute(fa_data,[1,3,2]);
    mask_data = 1- permute(mask_data,[1,3,2]); ns_data = permute(ns_data,[1,3,2]);
    
    dwi_data=double(dwi_data);%./double(max(max(max(max(max(dwi_data))))));
    fa_data=double(fa_data);%./double(max(max(max(max(max(fa_data))))));
    
    [A,B,C,D]=size(dwi_data);
    figure;subplot(1,2,1);imshow(ns_data(:,:,124),[]); subplot(1,2,2);imshow(fa_data(:,:,124),[]);
    %clear dwi_img fa_img;
    [hei,wid,C,channel]=size(dwi_data);
    %% loop count samples %%%%%%%%%%%%%%%%%%%%%%%%%
    %     for slice=1:228
    for slice=slice_num:slice_num
        %         seg_slice=seg_P60data(:,:,slice);
        for x = 1+halfsize_input : stride : hei-halfsize_input
            for y = 1+halfsize_input :stride : wid-halfsize_input
                
                %                 subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,[33:34,66:67]);
                subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,:);
                %                                 subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,:);
                % below dwis8000-10000 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %                 subim_input = dwi_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,[1:5,10:6:365,11:6:365]);
                
                subim_label = ns_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice);
                subim_fa = fa_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice);
                %                 subim_md = md_data(x-halfsize_input : x+halfsize_input, y-halfsize_input : y+halfsize_input,slice,1);
                %                 flag = sum(sum(sum(subim_label))); sum_fa=sum(sum(sum(sum(logical(subim_label)))));
                %                 if (flag<0.01||isnan(flag)||sum_fa<7)
                %                     continue;
                %                 else
                count=count+1
                data(:, :, :, count) = permute(subim_input,[1,2,4,3]);
                fa(:, :, :, count) = subim_fa;
                %               md(:, :, :, count) = subim_md;
                %                end
            end
        end
    end
end
% save  testdataPatch_mouse_dwiandT2MT.mat data ns_data -v7.3;
% save  testdataPatch_mouse.mat data label fa md -v7.3;
save  testdataPatch_mouse.mat data fa -v7.3;
