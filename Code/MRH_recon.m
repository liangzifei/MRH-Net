% Reconstuct slice/volume data from histology patches generated from MRH_testing.mlx.
%After running this demo, the result vitual histology will show up.

% -   - Zifei Liang (zifei.liang@nyumc.org)
% Using code please refer our work:
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
clc; clear; close all;
%Load the predicted histology patches, one example from our work is saved under /Output
load YPred_auto.mat;
halfsize_input = 1;
stride = 1;
count=0;
[A,B,C,length]=size(YPred);
% The following hei and wid need to be modified by USERS according to their own data.
% In our work, the data matrix size is 200x128x280. We process slice by
% slice. Then one single slice hei = 200, wid = 128; 
hei = 200; wid = 128;
ns_data=zeros(hei,wid);fa_data = ns_data; %md_data=ns_data; %ref_data = ns_data;
%     label_data=ns_data;
% loop over the entire slices. x is row and y is column. fill pixel by
% pixel.
for x = 1+halfsize_input : stride : hei-halfsize_input
    for y = 1+halfsize_input :stride : wid-halfsize_input
        count=count+1;
        if count< length
            ns_data(x,y)=YPred(halfsize_input+1,halfsize_input+1,:,count);
            fa_data(x,y) = fa(halfsize_input+1,halfsize_input+1,:,count);
        else
        end
    end
end
% Mask out non-brain regions.
ns_data = ns_data.*double(logical(fa_data));
figure; subplot(1,2,1);imshow(ns_data,[]);subplot(1,2,2); imshow(fa_data,[]);