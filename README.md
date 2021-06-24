# What is MRH-Net?

MRH-Net (for magnetic resonance histology-Net) is a tool developed to transform mouse brain magnetic resonance imaging (MRI) data into maps of specific cellular structures (e.g. axon and myelin). 

Modern MRI provides unparalleled tissue contrasts for visualizing brain structures and functions non-invasively. To this date, people are still actively developing new MRI contrasts, or markers, for detecting pathological changes in the brain. However, the sensitivity and specificity of MRI markers to cellular structures, especially under pathological conditions, are largely unknown due to lack of direct links between MRI signals and cellular structures. This is quite different from histology, which, over the past few decades, has developed multiple stainings that tag cellular structures with high specificity. For example, people can use antibodies specifically bind to neurofilament (NF) and myelin basic protein (MBP) to stain axon and myelin, respectively. These stainings are common tools for neurobiologists to study disease mechanisms and potential treatments using mouse models, but the procedures to acquire histological images are invasive and time-consuming. We hope that MRH-Net will assist neurobiologists to take the advantage of modern MRI techniques by providing them easy-to-understand maps of key cellular structures with the highest possible sensitivity and specificity.

MRH-Net are deep convolutional neural networks (CNNs) trained using co-registered histology and MRI data to infer target cellular structures from multi-contrast MRI signals. It was designed for the following tasks:

1) To transform MRI data to images of cellular structures with contrasts that mimic target histology.
2) To enhance the sensitivity and specificity of MRI to specific cellular structures.

Here, you will find our trained MRH-Nets, their source codes, our mouse brain MRI datasets used for the training and testing and the acquisition parameters. The datasets have been carefully registered to mouse brain images from the Allen Mouse Brain Atlas (https://mouse.brain-map.org).


MRH-Net was designed based on three assumptions:

1) The relationship between MRI signals and target cellular structures is local, so that the signals at each pixel is a realization/instance of the relationship between cellular structures and MRI signals. The millions of pixels in each MRI dataset thus provide sufficient data to train MRH-Nets. 
2) The multi-contrast MRI signals are sensitive to the presence of taget cellular structures. Different MRI contrasts are sensitive to distinct aspects of a particular structure (e.g. diffusion MRI is sensitive to restrictive effects of cell membrane and myelin sheath), multi-contrast MRI signals can potentially help MRH-Net and improve the sensitivity and specificity.
3) Deep CNNs can accurately infer the distribution of target cellular structure from multi-contrast MRI signals.

While the first assumption is true for most MRI data, it is often difficult to know whether the last two assumptions are met. In our experiments, the MRI protocol includes T2, magnetization transfer, and diffusion MRI, which have been shown to be sensitive to axon and myelin. The results generated by MRH-Net based on multi-contrast MRI data demonstrated remarkable similarities with NF and MBP stained reference histology, and the sensitivity and specificity of the results were higher than any single MRI marker.

## MRH-Net workflow

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/MRH_flow.png)

Fig. 1: The workflow of MRH-Net. The basic network was trained using co-registered 3D MRI and autofluorescence (AF) data of adult C57BL mouse brains. The AF dataset contains data from 100 subjects from the Allen Brain Connectivity Project (https://connectivity.brain-map.org/). The MRI data contains multi-contrast MRI data (T2, magnetization transfer, and diffusion-weighted) from 6 post-mortem mouse brains. The network, MRH-AF, trained using the data, can then take new MRI data acquired using the same protocol to generate 3D pseudo-AF data. For neurofilament (NF) and myelin basic protein (MBP) data, the Allen reference dataset only contains single subject data (http://connectivity.brain-map.org/static/referencedata). We registered these histological images to MRI data and used transfer learning methods to generate new networks based on the existing MRH-AF network. The resulting MRH-NF and MRH-MBP networks are intended to translate multi-contrast MRI data to pseudo-NF and MBP images.   

# How to use MRH-Net?

Below are several scenarios that MRH-Net and associated resources may be used.

1) Use our deep learning networks to transform mouse brain MRI data (acquired using same acquisition parameters) to histology-like images. Right now, our networks have been trained to generate auto-fluorescence, NF/MBP-stained images.
2) Register your own mouse brain MRI data to the MRI dataset provided here and use the source codes to train your own networks.
3) Register your own histological data to the MRI dataset provided here and use the source codes to train your own network. Note: co-register histological and MRI data is time consuming. 
4) Register data acquired using new MRI methods to the MRI dataset provided here and test its sensitivity and specificity using the histological data as the ground truth. 

##  MRH-Net files layout
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Github_Folder_treeNew.jpg)

Fig. 2: An overview of file organization. 

# What are the limitations of MRH-Net?

1) The current MRH-Nets were trained limited MRI and histological data from normal adult C57BL6 mouse brains (2 month old). Its performance for brains with pathology has not been evaluated. Additional training data (from different strains, ages, and pathology) will likely further improve the performance of MRH-Nets. 
2) MRH-Nets may not work for MRI data acquired using different MRI scanners or with different acquisition parameters. However, it is relatively easy to co-registered MRI data acquired from different MRI scanners and retrain the network. 
3) MRH-Nets can not be extended to clinical use. This is due to differences between mouse and human brain tissues and lack of histology ground truth from the human brain.  

### For more details on the project, please check out our paper : 
"Inferring Maps of Cellular Structures from MRI Signals using Deep Learning"
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
- **step1.** generate training samples---demo_trainingG (call MRH_trainingG.m);
- **step2.** training a neural-network from training samples---demo_training (call MRH_training.mlx);
- **step3.** generate testing data---demo_testingG (call MRH_testingG.m);
- **step4.** generate virtual histology from testing data voxel-by-voxel using trained neruo-network from step2--- demo_testing (call MRH_testing.mlx).
- **step5.** reconstruct the whole brain/one slice virual histology from voxel data---MRH_recon.m.
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
work_folder = ['.\Train_Data\Subj\'];
```
>All MRI data upload online, specifically, please refer to /Train_Data

>Histology(can replace by USER defined histology) location in code is:
```
fluo_img = load_untouch_nii(['.\Train_Data\Allen_Autofluo\AllenPathology2P60.img']);
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
>One example of voxel-wise MRH_net using 5 ResBlocks is the following (USER can revise ResBlock length by depth in Code/demo_training.m/ depth = 30):

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Network_5layers.jpg)

>One exmple smoothed training curve from MR_AF is the following:

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
/Code/MRH_recon.m
```
>After running, the virtual histology will show up dierctly.(The tool offered slice based generation only, 3D volume generation, USER need loop slices as recommended in code)

>Our exampled virtual histology data are located in folder /Output.

## Fast demo test (auto-fluorescence) please run:
>>(Put data files as refered in the code)
```
/Code/demo_testing.m 
/Code/MRH_recon.m
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
- Detail transfer learning execution can also refer to Usage: step1-5. Except that the network training needs one pre-trained network as a generic network:
```
net = MRH_training_Transfer(load_mat, networkDepth, pre_network);

default pre_network is trained from autofluorescence in our paper.

pre_network = ['.\network\net_30layerV3Res_HRJG_allMRIs_Fluo.mat'];
```
- Our prepared training .mat for transfer learning is uploaded online, please refer to /Train_data.

## Fast demo test(myelin) please run:

```
/Code/Transfer_Learning/demo_fastTest_Trans.m
```
## Exmple results from our work are shown as the following:

#### (In our work, the testing has been conducted on many healthy and sheiever mouse brains, while training on healthy mouse brains only. This verified the MRH_net could generalise to other than training data itself. Additionally, no test subject, in our work, is from training subjects). 
>Some example virtual histology results as following: 
#### Training on health, testing on both health(top) and shiever(bottom) strain. The right is real histology obtained from real staining.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Demyelin.jpg)


#### Training on health mouse subjects, testing on Sas4 mouse strain. Results from MRH_nissl.

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Sas4_MRH_nissl.jpg)


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
        fluo_img = load_untouch_nii(['.\Train_Data\Allen_Autofluo\AllenPathology2P60.img']);
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
- In virtual histology generation(demo_testing.m), please revise the file in the code. load_data is the testing data, while load_net is the pre-trained network.
```
from(default):
     load_data = '.\Test_Data\testdataPatch_mouse.mat';
     load_net = '.\network\net_30layerV3Res_HRJG_allMRIs_Fluo.mat';
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
