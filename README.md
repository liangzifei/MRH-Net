# MRH_net_submit
Training a neuro-network from MRI to histology in mouse brain voxel-by-voxel. 
The unique of our work is that all training or testing based on voxel-wise rather than large patch or slice method that using spatial informatoin traditionally, suggesting all information generated using our MRH_net principlly attribute to current voxel-wise MRI protocols. 

Different from imaging principle of camera or microscopy, our imaging method is more like a real MRI scanner, decoding histology voxel-by-voxel from MRI space voxels.


### Using code/data reasources please refer our work: 

Inferring Maps of Cellular Structures from MRI Signals using Deep Learning

https://www.biorxiv.org/content/10.1101/2020.05.01.072561v1
# Requirements
- Windows 10
- Matlab version > 2019b 
- Deep learning toolbox.
https://www.mathworks.com/products/deep-learning.html
- nifti toolbox
https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
- CUDA
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
- step1. generate training samples---demo_trainingG (call MRH_trainingG.m);
- step2. training a neural-network from training samples---demo_training (call MRH_training.mlx);
- step3. generate testing data---demo_testingG (call MRH_testingG.m);
- step4. generate virtual histology from testing data voxel-by-voxel using trained neruo-network from step2--- demo_testing (call MRH_testing.mlx).
- step5. reconstruct the whole brain/one slice virual histology from voxel data---MRH_recon.m.
# Training 
> (Our prepared training resources under /Train_data)
- prepare training data, use code 
```
demo_trainingG.m (call function MRH_trainingG.m)
> (please put the data and files as recommedded in the code)
```
>The training preparison require two parts: MRI data and target histology.

>Taken Auto-fluorescence as an example:
>MRI location in code is:
```
work_folder = ['R:\zhangj18lab\zhangj18labspace\',...
    'Zifei_Data\HCP\DeepNetIdea\JesseGray\JesseGray20191223\Porcessed\train\'];;
```
>All MRI data upload online, specifically, please refer to /Train_Data

>Histology(can replace by USER defined histology) location in code is:
```
 fluo_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\Allen_fluorescence',...
        '\AllenPathology2TanzilP60.img']);
 ```
> Auto-fluorescence data uploaded online, specifically, please refer to /Train_Data

>After running, the prepared training data will be saved in .mat that consists: data as input MRI and label as target histology.

>One example .mat file located in folder /Train_Data

- training the network using code

```
demo_training.m (call function MRH_training.mlx)
```
>After running, the network will be saved in .mat format.

>Our trained networks located in folder /network.
>One example of voxel-wise MRH_net using 10 ResBlocks is the following(USER can revise ResBlock length by depth in code):

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Example_Net.jpg)

>One exmple smoothed training curve from MR_auto-fluorescence is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Training_CurveFluorescence.jpg)

# Testing
- prepare testing data using code
```
demo_testingG.m (call function MRH_testingG.m)
```
>After running, the prepared testing data will be saved in .mat that consists: data as input MRI and label as target histology.

>One example .mat file located in folder /Test_Data

- generate vitual histology voxel by voxel using code
```
demo_testing.m (call function MRH_testing.m)
```
>After running, the voxel-wised histoloty will be saved in .mat format.

>Our exampled voxel-wised histology located in folder /Output.

- Reconstruct slice/volume histology from voxel-wised data using code
```
MRH_recon.m
```
>After running, the virtual histology will show up dierctly.(The tool offered slice based generation only, 3D volume generation, USER need loop slices as recommended in code)

>Our exampled virtual histology data are located in folder /Output.

## Fast demo test (auto-fluorescence) please run:
>>(Put data files as refered in the code)
```
demo_testing.m 
MRH_recon.m
```
# Transfer Learning
- Transfer Learning is prepared under the situation that no much histology are avaliable. For example, we have many auto-fluorescence, however, myelin/axon are in shortage. The idea here is Transfer learning from pre-trained MRH-autofluorescence network. It is peformed principally with the same training and testing protocol, except the training layers and hyperparameters setting in /TransferLearning/MRH_training_transfer.mlx. 

>Refering to online resource: https://www.mathworks.com/help/deeplearning/ug/transfer-learning-using-pretrained-network.html
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
- Detail transfer learning execution can also refer to Usage: step1-5. Except that the network training needs one pre-trained network as generic network:
```
net = MRH_training_Transfer(load_mat, networkDepth, pre_network);

default pre_network is trained from autofluorescence in our paper.
pre_network = ['net_30layerV3Res_HRJG_allMRIs_ave2000fluo.mat'];
```
- Our prepared training .mat for transfer learning is uploaded online, please refer to /Train_data.

## Fast demo test(myelin) please run:

```
/Transfer_Learning/demo_fastTest_Trans.m
```
## Exmple results from our work are shown as the following:

#### (In our work, the testing has been conducted on many healthy and sheiever mouse brains, while training on healthy mouse brains only. This verified the MRH_net could generalise to other than training data itself. Additionally, no test subject, in our work, is from training subjects). 
>Some example virtual histology results as following: 
#### Training on health, testing on both health(top) and shiever(bottom) strain. The right is real histology obtained from real staining.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Demyelin.jpg)

#### More virtual myelin exmples: top one healthy and bottom 3 different shiever subjects
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Shiever_3Subj.jpg)

#### Training on health mouse subjects, testing on Sas4 mouse strain. Results from MRH_nissl.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Sas4_MRH_nissl.jpg)

> Results of MRH_nissl using diferent sequence

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/MRH_nissl_diffSequence.jpg)

#### Combine axon/myelin/nissl(rgb) in colored virual histology.
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Axon_myelin_nissl3Channel120.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Axon_myelin_nissl3Channel140.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Axon_myelin_nissl3Channel160.jpg)

### `####################################################
# Prepare your own data(without training)

Please refer to our gradient table(under /Grad_table) and data prepared online(refer /Test_Data) to prepare your own data. Our pre-trained network in folder /network could generalise to other data with the same scan protocals as our Test_Data. USERS need use the identical MRI contrasts as our listed example data online(under /Train_data and /Test_data MRI subject resources)

# Prepare your own data(with your own training)
## Specific steps to prepare yourself training and testing
Before training the MR and histology data needs to be cooregistered. The tools used to accomplish MRI_histology corregistration is the following list: 

```
1. MRIStudio https://cmrm.med.jhmi.edu/
2. Diffeomap https://www.mristudio.org/installation.html
3. Mrtrix https://www.mrtrix.org/
4. ImageJ https://imagej.net/Registration

Optional:
1. ANTs 
```

>And JHU_P60 atlas could work as an Intermediary to assistent registration. 

>JHU_P60 atlas is generated from averaging 10 mouse subjects and uploaded online: https://osf.io/rnsjv/

> Our example corregistered MRI_histology is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/CorregisteredMRI_histology.jpg)

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
>please replace the training analyze target image by your own matched histology data.
```
   from (default):
      fluo_img = load_untouch_nii(['R:\zhangj18lab\zhangj18labspace\Zifei_Data\HCP\DeepNetIdea\Allen_fluorescence',...
        '\AllenPathology2TanzilP60.img']);
```        
training input and target should be corregistered.
## step2. In network training(MRH_training.mlx)

- In network training(MRH_training.mlx), please revise the dMRI input channel according to your own data. Any MRI contrast could be incorporated while not limited to dRMI. Magnetic transfer image was tested in our work. load_mat is the location of your training .mat file. Depth is the length of Residual blocks used in the trained network.
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
- In testing data preparison(MRH_trainingG.m), please revise the training analyze images by your own dMRI data. and axon_img is the reference data for comparison.
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
- In virtual histology generation(MRH_testing.m), please revise the file in the code. load_data is the testing data, while load_net is the pre-trained network.
```
from(default):
    load_data = 'testdataPatch_mouse.mat';
    load_net = 'net_30layerV3Res_HRJG_allMRIs_onesample2fluo5000d.mat';
```
## step5. Vitual histology reconstruction from pixels
- In virtual histology contrast reconstruction (MRH_recon.m), please redefine the slice parameters by USERS.
```
from(default):
    hei = 200; wid = 128;
```
# License
```
MIT License

Copyright (c) 2021 liangzifei

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
