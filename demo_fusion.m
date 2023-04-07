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

%% load data which type is double precision and the range is [0,1]
load 'test_data_wv3.mat';
Ori_HRMS    = gt;
I_LRMS      = lrms;
I_PAN       = pan;
opts        = [];
opts.sensor = 'WV3';          % 'WV3'and 'GF2'etc.

%%  Initialization
opts.lambda   = 0.002 ;
opts.eta_1    = 0.102 ;
opts.eta_2    = 0.005 ;
opts.ratio    = 4;
sz            = size(I_PAN);
[~,~,L]       = size(I_LRMS);
opts.sz       = sz;
opts.Nways    = [sz, L];
opts.tol      = 2*1e-4;
opts.omaxit   = 30 ;
opts.imaxit   = 2   ;
I_EXP  = interp23tap(I_LRMS, opts.ratio);

%% The fusing framwwork
disp('-------------Begin the Fusion algorithm------------------')
t0    = tic;
X_fin = LNM_PS_ADMM(I_LRMS, opts, Phi_inv_P);
time  = toc(t0);
disp('-------------End of the Fusion algorithm-----------------')

%% Quality_assess
Eva_Xfin = Quality_assess(Ori_HRMS, X_fin, opts.ratio);
fprintf('Best ADMM Points:\nPSNR_value  = %.3f\nSSIM_value  = %.4f\nSAM_value   = %.4f\nSCC_value   = %.4f\nERGAS_value = %.4f\nQ8_value    = %.4f\nRuntime     = %.4f\n', ...
    Eva_Xfin.PSNR,Eva_Xfin.SSIM,Eva_Xfin.SAM,Eva_Xfin.SCC,Eva_Xfin.ERGAS,Eva_Xfin.Q8,time)

%% plotting
warning off;
close all
location = [165 185 125 165];
showRGB4(Ori_HRMS, I_EXP, location);title('EXP');
showRGB4(Ori_HRMS, Ori_HRMS, location);title('GT');
showRGB4(Ori_HRMS, X_fin, location);title('Fusion by LNM-PS');