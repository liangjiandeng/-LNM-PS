function X_out  =  LNM_PS_ADMM(I_LRMS, opts, Phi_inv_P)
%% Initiation
omaxit  = opts.omaxit;
tol     = opts.tol;
Nways   = opts.Nways;
ratio   = opts.ratio;
eta_1   = opts.eta_1;
eta_2   = opts.eta_2;
sensor  = opts.sensor;
Theta_1 = zeros(Nways);
Theta_2 = zeros(Nways);
X_init  = interp23tap(I_LRMS, ratio);
X       = X_init;
% U       = zeros(Nways);
V       = zeros(Nways);
par     = FFT_kernel(ratio, sensor, Nways);
X_k = X;

%% ADMM
for it = 1:omaxit
    % update U
    U = U_subproblem(I_LRMS, X, Theta_1, par, opts);
    
    % update V by FISTA framework
    V = V_subproblem(X, V, Theta_2, opts, Phi_inv_P);
    
    % update X
    X = X_subproblem(U, V, Theta_1, Theta_2, par, opts);
    
    % update Theta
    Theta_1 = Theta_1 + eta_1*(par.B(X) - U);
    Theta_2 = Theta_2 + eta_2*(X - V);
    
    % stopping criterion
    Rel_Err = norm(Unfold(X - X_k,Nways,3) ,'fro')/norm(Unfold(X_k,Nways,3),'fro');
    X_k = X;
    if Rel_Err < tol
        break;
    end
    
    fprintf('The num of iter:%d/%d\n',it,omaxit);
end

%% Output
X_out=X;
end