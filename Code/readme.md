# Running code please refer Usage and the main readme file.
# Usage
- **step1.** generate training samples <---demo_trainingPrep (call MRH_trainingPrep.m);
- **step2.** training a neural-network from training samples <---demo_training (call MRH_training.mlx);
- **step3.** generate testing data <---demo_testingPrep (call MRH_testingPrep.m);
- **step4.** generate virtual histology from testing data voxel-by-voxel using trained nerural network from step2 <--- demo_testing (call MRH_testing.mlx).
- **step5.** reconstruct the whole brain/one slice virual histology from voxel data <---MRH_recon.m.
## Fast demo test (auto-fluorescence) please run:
>(Please put data files as refered)
```
/Code/demo_testing.m 
/Code/MRH_recon.m
```
# Transfer Learning
 Detail transfer learning execution can also refer to Usage: step1-5. 
- Except that the network training needs one pre-trained network as generic network:
```
net = MRH_training_Transfer(load_mat, networkDepth, pre_network);

default pre_network is trained from autofluorescence in our paper.
pre_network = ['./network/net_30layerV3Res_HRJG_allMRIs_ave2000fluo.mat'];
```
- Our prepared training .mat for MBP transfer learning is saved under /Train_data.

## Fast transfer learning demo test (myelin) please run:
>(Please put data files as refered)
```
/Code/Transfer_Learning/demo_fastTest_Trans.m
