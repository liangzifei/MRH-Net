# MRH_net_submit
training a neuro-network from MRI to histology in mouse brain. The unique of our work is that all training or testing based on voxel-wise rather than large patch or slice method which used spatial informatoin basically.
# Requirements
- Windows 10
- Matlab version > 2019b 
- Deep learning toolbox.
https://www.mathworks.com/products/deep-learning.html
- Optional

  t-sne toolbox
  https://www.mathworks.com/help/stats/tsne.html

# Usage
- step1. generate training data;
- step2. training a neuro-network from training data;
- step3. generate testing data;
- step4. generate virtual histology from testing data voxel-by-voxel using trained neruo-network in step2.
- step5. reconstruct the whole brain virual histology volume from voxel data.
# Training
- prepare training data using code trainingXXX.m

    Please locate the data in one folder: named folder_dwi in the code.

# Testing
# Prepare your own data

- in training data preparison, please replace the training analyze images by your own dMRI data.
···from (default):
   %dwi2000 is the diffusion data scanned from b=2000
    dwi2000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi2000.img']);
   %dwi5000 is diffusion b=5000 data
    dwi5000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_lddm_t2MTONOFF.img']);···
please replace the training analyze target image by your own dMRI data.

    from (default):
    fluo_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\Allen_fluorescence',...
        '\AllenPathology2TanzilP60.img']);
        
training input and target should be corregistered.
