# MRH_net_submit
training a neuro-network from MRI to histology in mouse brain voxel-by-voxel. The unique of our work is that all training or testing based on voxel-wise rather than large patch or slice method which used spatial informatoin traditionally, leading to all information generated principlly attribute to MRI protocals.
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

# Usage
- step1. generate training data---MRH_trainingG.m;
- step2. training a neuro-network from training data---MRH_training.mlx;
- step3. generate testing data---MRH_testingG.m;
- step4. generate virtual histology from testing data voxel-by-voxel using trained neruo-network in step2--- MRH_testing.mlx.
- step5. reconstruct the whole brain virual histology volume from voxel data---MRH_recon.m.
# Training
- prepare training data using code trainingXXX.m

    Please locate the data in one folder: named folder_dwi in the code.

# Testing
# Prepare your own data
### (In our work, the testing alreay conducted on shiever mouse brain, while training on healthy mouse brains. This verified the MRH_net generalise to other data. Additionally, all test subjects in our work is not from training group). 
One example result as following:
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Myelin.jpg)

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
## Train your own MRH_network

- In network training(MRH_training.mlx), please change the dMRI input channel according to your own data.
```
   from (default):
   
