# Transfer learning 
## Transfer from general auto-fluorescence MRH network to specific histology contrast, such as myelin/axon. 
(The trained network from transferlearning is the same structure and format from MRH_training.mlx. Therefore, same use in testing steps)

### The general idea of transfer learning is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/transfer_learning_general.png)

### The transfer learning applied in our work is the following:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Network.jpg)

## Example of training curve from transfer learning:

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/TrainingCurve.jpg)

## Example of generated virtual myelin from transfer learning:
![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/Transfer_fromAutofluo.jpg)

Compare to one previous example without transfer learning(3 Residual blocks used here):

![](https://github.com/liangzifei/MRH_net_submit/blob/main/image/No_transfer_3Resblock.jpg)

# Runing please refer to Usage:Step1-5
