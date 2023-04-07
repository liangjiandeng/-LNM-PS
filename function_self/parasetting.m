function [paras] = parasetting(sensor)
%
addpath(genpath(pwd))
paras        = [];
paras.ratio  = 4;
paras.tol    = 2*1e-4;
paras.omaxit = 30 ;
paras.imaxit = 2  ;
% Such parameter configuration can be further fine-tuned
% on your data, if need.
%% =====Paras setting========
switch sensor
    case 'none'   % Guangzhou dataset (GF-2)
        load 'test_data_gf2.mat';
        paras.lambda   = 0.001 ;
        paras.eta_1    = 0.092 ;
        paras.eta_2    = 0.018 ;
        paras.location = [140 160 150 190];
    case 'QB'   % Indianapolis dataset (QB)
        load 'test_data_qb.mat';
        paras.lambda   = 0.002 ;
        paras.eta_1    = 0.174 ;
        paras.eta_2    = 0.019 ;
        paras.location = [220 240 25 65];
    case 'WV3'   % Rio dataset (WV-3)
        load 'test_data_wv3.mat';
        paras.lambda   = 0.002 ;
        paras.eta_1    = 0.102 ;
        paras.eta_2    = 0.005 ;
        paras.location = [165 185 125 165];
end
paras.I_LRMS      = I_lrms;
paras.I_PAN       = I_pan;
paras.Phi_inv_P   = Phi_inv_P;
paras.Ori_HRMS    = I_hrms;

[~, ~, l]         = size(paras.I_LRMS);
sz                = size(paras.I_PAN);
Nways             = [sz, l];
paras.sz          = sz;
paras.Nways       = Nways;
paras.sensor      = sensor;
%
end