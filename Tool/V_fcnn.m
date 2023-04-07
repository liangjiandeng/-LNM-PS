function V = V_fcnn(PAN, U, V, X, par, opts, Theta_1, Theta_2)

maxit_fista    = opts.maxit_fista;
% Nways          = opts.Nways;

tkp1 = 1;
T_old1 = zeros(size(X));
% T_old2 = zeros(size(X));

i=0;
while (i < maxit_fista)
    i = i+1;
    tk = tkp1;
    V_old1 = V;
    % update T
    model_path1 = './function_self/pansharpening_single/IPNN_MS2PAN_wv3.mat';
    wv3_rs = IPNN_single(model_path1, PAN, V, 'MS2PAN');
    res = wv3_rs-PAN;
    model_path2 = './function_self/pansharpening_single/IPNN_PAN2MS_wv3.mat';
    T = T_old1 - IPNN_single(model_path2, res, V, 'PAN2MS');
    % update V
    V = V_subproblem(X, U, T, Theta_1, Theta_2, par, opts);
    % update t and T
    tkp1=(1+sqrt(1+4*tk^2))/2;
    step=(tk-1)/tkp1;
%     T_old2 = T_old1;
    T_old1 = V + step*(V - V_old1);
end
end