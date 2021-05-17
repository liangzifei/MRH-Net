# Training data resources
## Input subjects for MRH_trainingG.m
### Training input
- 1. The MRI subjects resource, used for MR_autofluorescence, MR_axon and MR_myelin, is uploaded online(limited by datasize, 4 subjects offered. 6 subjects used in our online published work):

>> https://osf.io/8jh7b/
- 2. The MRI subjects resource, used for MR_nissl, is uploaded online(4 subjects offered):

>> https://osf.io/asjyh/

### Training target
The subjects Histology target data resource, is uploaded online:
- 1. Auto-fluorescence:

>> https://osf.io/nax8y/

> Only part of examples uploaded, more than 2,000 auto-fluorescence data offered by allen group. Please acquire online from: http://help.brain-map.org/display/api/Allen%2BBrain%2BAtlas%2BAPI

- 2. Axon:

>> https://osf.io/n3vwf/


- 3. Myelin:

>> https://osf.io/u53cg/

- 4. Nissl(in P60 space, to achiever better performance, further accurate registratoion is helpful):

>> https://osf.io/hk2pv/


## Output training .mat from MRH_trainingG.m
The output of MRH_trainingG.m is the prepared data and label, and saved in .mat form. 
One example .mat is saved online(about 40,000 patches are generated from matched MRI and auto-fluorescence):

>> https://osf.io/fk58t/

## Output training .mat from MRH_trainingG.m for Transfer Learning

(about 40,000 patches are generated from matched MRI and myelin):

>> https://osf.io/rw42b/



# Supplementary 
> (The original histology data used to generate the above data resources is dowloaded from allen database)
>> https://connectivity.brain-map.org/static/referencedata

> Example allen hisology images form the original is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/100140665_130.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/100142290_133.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/100142355_131.jpg)

### Some of corregistered histology in High resolution JHU P60 space is the following:
> 
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/nissl2P60_132.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Resized56times_Allen132.jpg)
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Resized_cropedAllen141.jpg)

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/nissl2P60_141.jpg)
