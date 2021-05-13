% Using code please refer our work: 
% Inferring Maps of Cellular Structures from MRI Signals using Deep Learning 
% https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
halfsize_input = 1;
stride = 1;
count=0;
loop
[A,B,C,length]=size(data);
%     hei = 280; wid = 128;
hei = 200; wid = 128;
ns_data=zeros(hei,wid);fa_data = ns_data; md_data=ns_data; %ref_data = ns_data;
%     label_data=ns_data;
for x = 1+halfsize_input : stride : hei-halfsize_input
    for y = 1+halfsize_input :stride : wid-halfsize_input
        count=count+1;
        if count< length
            ns_data(x,y)=YPred(halfsize_input+1,halfsize_input+1,:,count);
        else
        end
    end
end
ns_data=uint8(ns_data*255);
figure; imshow(ns_data,[]);
%     fa_img=load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\',...
%         'DeepNetIdea\JesseGray\C4\Fitted\fitted_rigidaffine.img']);
fa_img=load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\test\C1\rigidaffine_Lddm_fa.img']);

fa_data=fa_img.img(:,:,:); fa_data(isnan(fa_data))=0;
fa_data=permute(fa_data,[1,3,2]); fa_slice = fa_data(:,:,120);
figure; imshow(fa_slice,[]);
I = ns_data;
I=double(I)./255; I=imadjust(I,[min(I(:)) max(I(:))],[]);
imwrite(uint8(I.*255.*double(logical(fa_slice))),'K:\SRCNN_deltADC\paper_fig\mat_file\fluorescence\test.jpg');
imwrite(uint8(fa_slice.*256),'K:\SRCNN_deltADC\paper_fig\mat_file\fluorescence\testfa.jpg');
fa_img=load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\',...
    'HCP\DeepNetIdea\Allen_fluorescence\AllenPathology2TanzilP60.img']);
fa_data=fa_img.img(:,:,:); fa_data(isnan(fa_data))=0;
fa_data=permute(fa_data,[1,3,2]); fa_slice = fa_data(:,:,114);
imwrite(uint8(fa_slice),'K:\SRCNN_deltADC\paper_fig\mat_file\fluorescence\testfa.jpg');