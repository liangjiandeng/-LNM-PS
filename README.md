# A Novel Spatial Fidelity with Learnable Nonlinear Mapping for Panchromatic Sharpening [Matlab Code]

**Homepage:** https://liangjiandeng.github.io/

# How to use?
- Choose the sensor is ``none``,  then run: ``demo_fusion.m`` for a GF2 example；
- Choose the sensor is ``QB``,  then run: ``demo_fusion.m`` for a QB example；
- Choose the sensor is ``WV3``,  then run: ``demo_fusion.m`` for a WV3 example；
- ``In the toolbox, we only give three examples from three different sensor, i.e., GF2, QB, and WV3, and correspondingly including three pre-trained results, i.e., Phi_inv_P in the given data, respectively. If you need more test more examples for other sensors, please train and get the pre-trained network, and then obtain the pre-trained result by yourself according to Fig. 5.``

 
# Citation
```bibtex
@ARTICLE{wen2023tgrs,
author={Wen, Rui, and Wu, Zhong-Cheng and Deng, Liang-Jian and Wu, Xiao and Vivone, Gemine},
booktitle={IEEE Trans. Geosci. Remote Sens.},
title={A Novel Spatial Fidelity with Learnable Nonlinear Mapping for Panchromatic Sharpening},
year={2023},
doi={10.1109/TGRS.2023.3265404},
}
```

# Method

***Motivation:*** A widely used hypothesis in some existing works is that the known PAN and latent HRMS images have the common spatial structure. According to this consideration, many methodologies extract the spatial details from the existing PAN image to reconstruct the desired HRMS image. Specifically, many VO-based methods assume that the PAN image is (globally or locally) linearly related to the HRMS image. However, the relationship between the above two images (i.e., the known PAN and latent HRMS images) is often nonlinear, as demonstrated in Sect. III-B and shown in Fig. 3. Unfortunately, VO-based methods cannot effectively solve this nonlinear relationship. Thus, describing the nonlinear relationship between the above two images can represent the key to success for VO-based approaches.

Many researchers proposed CNN-based regularization terms to improve the performance of VO-based sharpening methods. In both cases, the superiority (in terms of accuracy) of using CNNs in the fusion framework is demonstrated. However, the simple use of CNNs in the regularization term is insufficient since it fails to make the best of the strong ability of CNNs in the nonlinear mapping. Hence, how to exploit CNNs to map nonlinearities in data fidelity terms for VO-based pansharpening is a relevant problem. This paper is devoted to making the first attempts toward addressing this question.

Based on the above two considerations, a novel hybrid model is proposed, which improves traditional variational models by plugging a learnable nonlinear mapping into the spatial fidelity term (the LNM-SF), just including two data fidelity terms, i.e., the traditional spectral fidelity term and the proposed LNM-SF. This model breaks away from the classical linear constraints getting competitive results on different datasets against state-of-the-art techniques.

<img src="figures/Fig. 3.png" width = "50%" />

***Overall Framework:*** The framework of our model. The details of our framework can be found in Sect. III.

<img src="figures/Fig. 2.png" width = "100%" />



***Fidelity:*** Many existing variational models extract the spatial information from the known PAN image by an inaccurate assumption, i.e., the linear relationship between the existing PAN and latent HRMS images, thus causing some spatial distortion.

It is easy to see that both of them make the same assumption of a linear combination between the PAN image and the HRMS spectral bands. To further explore the relationship both in spectral and spatial between the PAN and HRMS images, the spectral responses of two extensively used sensors for pansharpening are shown in Fig. 3. From the selected area, we can see that the spectral response between the existing PAN and latent HRMS images is nonlinear, because the spectral response of PAN (the black curve) can not be a linear representation by other spectral response of channels of HRMS. It is worth noting that the linear assumption widely used in many existing VO-based methods still obtains good performance, but surely represents an approximation. On the contrary, the nonlinear relationship is more coherent with a real environment driving the development of new approaches towards considering this feature to improve fusion performance.

Thanks to the rapid development of CNNs for pansharpening, the nonlinear mapping can be obtained by exploiting CNNs. Thus, we design a pre-trained CNN to learn the nonlinear relationship between the existing PAN and latent HRMS images. Then, we use this CNN structure as the embed operator to replace the traditional theory of linear algebra, making a substantial step toward constructing a nonlinear relationship in the data fidelity of VO-based methods. More details about how to train CNN can be found in Sect. V-B and Fig. 5.

<img src="figures/Fig. 3.png" width = "50%" />

<img src="figures/Fig. 5.png" width = "50%" />



***Handling the decimation operation:*** Fig. 4. The diagrammatic representation of (13) when r=4. 

<img src="figures/Fig. 4.png" width = "50%" />

***Final Model:*** 

<img src="figures/Eqn. 8.png" width = "50%" />

***Visual Results:*** Fig. 10. Visual results on the reduced-resolution Rio dataset (source: WorldView-3). The PAN size of this image is 256 x 256. First row: the fused images from different frameworks. Second row: the homologous residual maps when we used the GT image as the reference image. The NIR (7th), Green (3rd), and Blue (2nd) channels are selected to generate these Pseudo color images.

<img src="figures/Fig. 10.png" width = "90%" />


***Quantitative Results:*** The quantitative results of Tab. V.

<img src="figures/Tab. V.png" width = "90%" />
