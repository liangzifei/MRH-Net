% Fast test Transfer Learning trained network. 
%After running the demo, the network output shows Myelin contrast

%  - Zifei Liang (zifei.liang@nyumc.org)

% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1

clc;clear; close all;
% Please replace the location of USERS folder.  testdata location refer
% under /Test_Data. pretrained network refer under /network.
load([ 'F:\Code\SRCNN\Submit_elife\Pre_trained_Network\testdataPatch_mouse.mat']);
load(['F:\Code\SRCNN\Submit_elife\Pre_trained_Network\',...
    'net_30layerV3Res_HRJG_allmri_myelin_TransferLearn.mat'], 'net');
XTest = double(data./max(data(:)));
YPred = predict(net, XTest);
%end network prediction

halfsize_input = 1;
stride = 1;
count=0;
[A,B,C,length]=size(data);
% Please replace by the size of USERS data, where hei and wid represent the size of one
% data slice. 
hei = 200; wid = 128;
ns_data=zeros(hei,wid);fa_data = ns_data; 
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
figure;subplot(1,2,1); imshow(ns_data,[]);subplot(1,2,2); imshow(fa_data,[]);