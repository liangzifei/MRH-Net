# MRH_net_submit
training a neuro-network from MRI to histology in mouse brain voxel-by-voxel. The unique of our work is that all training or testing based on voxel-wise rather than large patch or slice method which used spatial informatoin traditionally, suggesting all information generated using our MRH_net principlly attribute to current voxel-wise MRI protocals.

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
- prepare training data, use code 
```
demo_trainingG.m call function MRH_trainingG.m
(please put the data and files as recommedded in the code)
```
After running, the prepared training data will be saved in .mat that consists: data as input MRI and label as target histology.

One example .mat file located in folder /Train_Data

- training the network using code

```
demo_training.m call function MRH_training.mlx
```
After running, the network will be saved in .mat format.

Our exampled trained networks located in folder /network.

One exmple smoothed training curve from auto-fluorescence is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Training_CurveFluorescence.jpg)

# Testing
- prepare testing data using code
```
demo_testingG.m call function MRH_testingG.m
```
After running, the prepared testing data will be saved in .mat that consists: data as input MRI and label as target histology.

One example .mat file located in folder /Test_Data

- generate vitual histology voxel by voxel using code
```
demo_testing.m call function MRH_testing.m
```
After running, the voxel-wised histoloty will be saved in .mat format.

Our exampled voxel-wised histology located in folder /Output.

- Reconstruct slice/volume histology from voxel-wised data using code
```
MRH_recon.m
```
After running, the virtual histology will show up dierctly.(The code offered is based on slice generation, 3D volume need loop running slice code by USER)

Our exampled virtual histology data are located in folder /Output.
## Sampled exmples of our output are shown as the following:
#### (In our work, the testing alreay conducted on many healthy and shiever mouse brain, while training on healthy mouse brains only. This verified the MRH_net could generalise to other than training data itself. Additionally, all test subjects in our work are not from training subjects). 
One example shiever mouse virtual myelin result as following: 
#### training on health, testing on both health(top LEFT) and shiever(bottom LEFT) strain. The right is real histology obtained from staining.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Myelin.jpg)

#### More virtual myelin exmple: top health and bottom 3 different shiever subjects
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Shiever_3Subj.jpg)

# Transfer Learning
- Transfer Learning peformed principally with the same training and testing protocol, except the training layers and hyperparameters setting in /TransferLearning/MRH_training_transfer.mlx. 

Refering online resource: https://www.mathworks.com/help/deeplearning/ug/transfer-learning-using-pretrained-network.html
```
newLearnableLayer4 = convolution2dLayer(3,64,'Padding','same', ...
    'Name','new_Conv4', ...
    'WeightLearnRateFactor',10, ...
    'BiasLearnRateFactor',10);
newLearnableLayer5 = convolution2dLayer(3,1,'Padding','same', ...
    'Name','new_Conv5', ...
    'WeightLearnRateFactor',10, ...
    'BiasLearnRateFactor',10);
newfinallayer = regressionLayer('Name','FinalRegressionLayer')

lgraph = replaceLayer(lgraph,'Conv4',newLearnableLayer4);
lgraph = replaceLayer(lgraph,'Conv5',newLearnableLayer5);
lgraph = replaceLayer(lgraph,'FinalRegressionLayer',newfinallayer)

initLearningRate = 1e-4;
learningRateFactor = 0.1;
```
- Detail transfer learning conduction can also refer Usage: step1-5. Except that the code running needs one pre-trained network as input:
```
net = MRH_training_Transfer(load_mat, networkDepth, pre_network);

default pre_network is trained from autofluorescence in our paper.
pre_network = ['net_30layerV3Res_HRJG_allMRIs_ave2000fluo.mat'];
```
## Fast demo test running please run:

```
demo_testing.m
MRH_recon.m
```

# Prepare your own data(without training)

Please refer to our gradient table and data to prepare your own data. Our pre-trained network in folder /network could be generalise to other data, as long as USERS using the identical MRI contrasts as our listed example data online().

# Prepare your own data(with your own training)
## Specific steps to prepare yourself training and testing
Before training the MR and histology data needs to be cooregistered. Any tool achieving accurate voxel-wise registration is a good candidate. 
In our work, the following tools are used:
```
1. MRIStudio https://cmrm.med.jhmi.edu/
2. Diffeomap https://www.mristudio.org/installation.html
3. Mrtrix https://www.mrtrix.org/
4. ImageJ https://imagej.net/Registration

Optional:
1. ANTs 
```
And JHU_P60 atlas could work as an Intermediary to assistent registration. 

JHU_P60 atlas is generated from averaging 10 mouse subjects and uploaded online: https://osf.io/rnsjv/


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
- In virtual histology generation(MRH_testing.m), please replace the file in the code. load_data is the testing data, while load_net is the pre-trained network.
```
from(default):
load_data = 'testdataPatch_mouse.mat';
load_net = 'net_30layerV3Res_HRJG_allMRIs_onesample2fluo5000d.mat';
```
## step5. Vitual histology reconstruction from pixels
- In virtual histology contrast reconstruction(MRH_recon.m), please replace the slice parameters with the USERS.
```
from(default):
hei = 200; wid = 128;
```
