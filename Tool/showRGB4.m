%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           Visualize and print an eight-band multispectral image.
% 
% Interface:
%           showImage8(I_MS,print,id,flag_cut_bounds,dim_cut,th_values,L)
%
% Inputs:
%           I_MS:               Eight band multispectral image;
%           print:              Flag. If print == 1, print EPS image;
%           id:                 Identifier (name) of the printed EPS image;
%           flag_cut_bounds:    Cut the boundaries of the viewed Panchromatic image;
%           dim_cut:            Define the dimension of the boundary cut;
%           th_values:          Flag. If th_values == 1, apply an hard threshold to the dynamic range;
%           L:                  Radiomatric resolution of the input image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function showImage8(I_MS,print,id,flag_cut_bounds,dim_cut,th_values,L,location)
function showRGB4(Ori_HRMS,fusion,location)

th_MSrgb = image_quantile(Ori_HRMS(:,:,[3,2,1]), [0.01 0.99]);
I_fuse = image_stretch(fusion(:,:,[3,2,1]),th_MSrgb);
ent=rectangleonimage(I_fuse,location, 0.5, 3, 1, 2, 1);
figure,imshow(ent,[])

end