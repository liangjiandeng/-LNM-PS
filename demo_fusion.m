%% =================================================================
% This script runs the LNM_PS code.
%
% Please make sure your data is in range [0,1].
%
% Reference: Rui Wen, Liang-Jian Deng*, Zhong-Cheng Wu, Xiao Wu,  Gemine Vivone
%            "A Novel Spatial Fidelity with Learnable Nonlinear Mapping for Panchromatic Sharpening"
%             IEEE Transactions on Geoscience and Remote Sensing, 2023.
%
% Created by Rui Wen (wenrui202102@163.com)
% May 30, 2022
% Updated by 
% Mar. 30, 2023

%% Clean up workspace
clear;clc;
close all;
addpath(genpath(pwd))

%% load data and Initialization
sensor = 'QB';        % 'none' (i.e., GF2), 'QB', and 'WV3'.
opts = parasetting(sensor);
I_EXP  = interp23tap(opts.I_LRMS, opts.ratio);

%% The fusing framwwork
disp('-------------Begin the Fusion algorithm------------------')
t0    = tic;
X_fin = LNM_PS_ADMM(opts);
time  = toc(t0);
disp('-------------End of the Fusion algorithm-----------------')

%% Quality_assess
Eva_Xfin = Quality_assess(opts.Ori_HRMS, X_fin, opts.ratio);
fprintf('Best ADMM Points:\nPSNR_value  = %.3f\nSSIM_value  = %.4f\nSAM_value   = %.4f\nSCC_value   = %.4f\nERGAS_value = %.4f\nQ8_value    = %.4f\nRuntime     = %.4f\n', ...
    Eva_Xfin.PSNR,Eva_Xfin.SSIM,Eva_Xfin.SAM,Eva_Xfin.SCC,Eva_Xfin.ERGAS,Eva_Xfin.Q8,time)

%% plotting
warning off;
D_PAN = zeros(opts.Nways);
for it = 1:size(opts.Ori_HRMS,3)
    D_PAN(:,:,it) = opts.I_PAN;
end
close all
location = opts.location;
figure
subplot(2,2,1),showRGB4(D_PAN, D_PAN, location);title('PAN');
subplot(2,2,2),showRGB4(opts.Ori_HRMS, I_EXP, location);title('EXP');
subplot(2,2,3),showRGB4(opts.Ori_HRMS, X_fin, location);title('LNM\_PS');
subplot(2,2,4),showRGB4(opts.Ori_HRMS, opts.Ori_HRMS, location);title('GT');