# MRH_net_submit
training a neuro-network from MRI to histology in mouse brain voxel-by-voxel. The unique of our work is that all training or testing based on voxel-wise rather than large patch or slice method which used spatial informatoin traditionally, leading to all information generated principlly attribute to MRI protocals.

Using code please refer our work: Inferring Maps of Cellular Structures from MRI Signals using Deep Learning
https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
# Requirements
- Windows 10
- Matlab version > 2019b 
- Deep learning toolbox.
https://www.mathworks.com/products/deep-learning.html
- Optional

  t-sne toolbox
  https://www.mathworks.com/help/stats/tsne.html
  ### Running verified on 
    CUDADevice with properties:
```
                      Name: 'TITAN RTX'
                     Index: 1
         ComputeCapability: '7.5'
            SupportsDouble: 1
             DriverVersion: 10.1000
            ToolkitVersion: 10.1000
        MaxThreadsPerBlock: 1024
          MaxShmemPerBlock: 49152
        MaxThreadBlockSize: [1024 1024 64]
               MaxGridSize: [2.1475e+09 65535 65535]
                 SIMDWidth: 32
               TotalMemory: 2.5770e+10
           AvailableMemory: 1.7937e+10
       MultiprocessorCount: 72
              ClockRateKHz: 1770000
               ComputeMode: 'Default'
      GPUOverlapsTransfers: 1
    KernelExecutionTimeout: 1
          CanMapHostMemory: 1
           DeviceSupported: 1
            DeviceSelected: 1
```
# Usage
- step1. generate training data---MRH_trainingG.m;
- step2. training a neuro-network from training data---MRH_training.mlx;
- step3. generate testing data---MRH_testingG.m;
- step4. generate virtual histology from testing data voxel-by-voxel using trained neruo-network in step2--- MRH_testing.mlx.
- step5. reconstruct the whole brain/one slice virual histology volume from voxel data---MRH_recon.m.
# Training
- prepare training data using code trainingXXX.m

    Please locate the data in one folder: named folder_dwi in the code.

# Testing

#### (In our work, the testing alreay conducted on shiever mouse brain, while training on healthy mouse brains. This verified the MRH_net could generalise to other than training data itself. Additionally, all test subjects in our work are not from training subjects). 
One example result as following: 
#### training on health, testing on both health(top) and shiever(bottom) strain.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Myelin.jpg)
# Prepare your own data(without training)
Please refer to our gradient table and data to prepare your data. Our pre-trained network in folder /network could be generalise to other data, using the identical MRI contrasts as our listed example data.
# Prepare your own data(with your own training)
## Specific steps to prepare yourself training and testing
### step1. In training data preparison(MRH_trainingG.m)
- In training data preparison(MRH_trainingG.m), please replace the training analyze images by your own dMRI data.
```
  from (default):
   %dwi2000 is the diffusion data scanned from b=2000
    dwi2000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi2000.img']);
   %dwi5000 is diffusion b=5000 data
    dwi5000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_lddm_t2MTONOFF.img']);
```
please replace the training analyze target image by your own dMRI data.
```
   from (default):
    fluo_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\Allen_fluorescence',...
        '\AllenPathology2TanzilP60.img']);
```        
training input and target should be corregistered.
## step2. In network training(MRH_training.mlx)

- In network training(MRH_training.mlx), please change the dMRI input channel according to your own data. Any MRI contrast could be incorporated and not limited to dRMI. Magnetic transfer image was tested in our work. load_mat is the location of your training .mat file. Depth is the length of Residual blocks used in the trained network.
```
   from (default):
     load_mat =['F:\Code\SRCNN\Fluorescence\traindata.mat'];
     input_channel = 67;
     % 30 is used in the paper for auto-fluorescence training task, 
     %as large amount data accessable from allen.
     % Shorter is preferable under the condition limited training data offered.
     %3 is tested and verified on MR to myelin network training
     depth = 30;
```
## step3. In testing data preparison(MRH_testingG.m)
- In testing data preparison(MRH_trainingG.m), please replace the training analyze images by your own dMRI data. and axon_img is the reference data for comparison.
```
from(default):
    dwi2000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi2000.img']);
    dwi5000 = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_dwi5000.img']);
    t2MTONOFF = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_lddm_t2MTONOFF.img']);
    fa_img = load_untouch_nii([folder_dwi,num2str(sample_img),'\rigidaffine_Lddm_fa.img']);
    fa_mask = load_untouch_nii([folder_dwi,num2str(sample_img),'\Masked_outline.img']);
    axon_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\',...
        'JesseGray\JesseGray20191223\Porcessed\Axon_to_C',num2str(sample_img),'.img']);
```
## step4. Vitual histology pixels generation from testing data using trained MRH_network(MRH_testing.m)
