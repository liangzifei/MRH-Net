# Training Data 

Here you will find the training MRI and histology data used in our manuscript (doi: https://doi.org/10.1101/2020.05.01.072561)

The file list under Train_Data is following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/TrainFoder_tree.jpg)


## Input subjects for MRH_trainingG.m
### Training input
- 1. The multi-contrast 3D MRI data used for MRH-AF/NF/MBP (4 out of a total of 6 mouse brains) can be downloaded from https://osf.io/jnvg5/. We only uploaded data from 4 mouse brains due to file size limit. Please contact us if you need additional data. 

- 2. The multi-contrast 3D MRI data used for MRH-Nissl (from 4 out of a total of 6 mouse brains) can be downloaded from https://osf.io/eqzbp/.

### Training target
The following target histology data resource were obtained from the Allen mouse brain reference and connectivity atlases. 

- 1. Auto-fluorescence (AF) data (10 from 100 mouse brains used in our manuscript) can be downloaded from https://osf.io/r5xwm/. Additional AF data can be downloaded from the Allen website (http://help.brain-map.org/display/api/Allen%2BBrain%2BAtlas%2BAPI).

- 2. Neurofilament (NF) data can be downloaded from https://osf.io/z7s5n/

- 3. Myelin basic protein (MBP) data can be downloaded from https://osf.io/x3qne/

- 4. Nissl data can be downloaded from https://osf.io/td4nu/


## Output training.mat from MRH_trainingG.m
The output of MRH_trainingG.m is the prepared data and label, and saved in .mat format (Matlab). 

An example .mat file (containing 40,000 patches generated from matched MRI and auto-fluorescence data) can be downloaded from https://osf.io/fk58t/

## Output training .mat from MRH_trainingG.m for Transfer Learning
For transfer learning of MBP data, an example .mat file containing about 40,000 patches generated from matched MRI and MBP histology can be downloaded from https://osf.io/rw42b/


# Supplementary 


> (The original histology data used to generate the above data resources is dowloaded from allen database)
>> https://connectivity.brain-map.org/static/referencedata

Additional example of some super-high resolution images coregistration is the following(The original high quality images can be downloaded from https://osf.io/bvf3t/):

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Image_Supp.jpg)

The overlapped FA and Nissl is the following:

![](https://github.com/liangzifei/MRH-Net/blob/main/image/BlueNissl-FA-GrayNissl_small.jpg)

