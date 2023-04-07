function V_out = V_subproblem(X, V, Theta_2, opts, Phi_inv_P)
%%
imaxit       = opts.imaxit;
T = V;
t            = 1;
lambda       = opts.lambda;
eta_2        = opts.eta_2;

%% FISTA
for i = 1:imaxit
    t_last = t;
    V_last = V;
    
    % update E
    temp = V - Phi_inv_P;
    E    = T - temp;  
    
    % update V
    V = (lambda*E + eta_2*X + Theta_2)/(lambda + eta_2);
    
    % update t and T
    t = (1 + sqrt(1 + 4*t_last^2)) / 2;
    T = V + ((t_last-1)/t)*(V - V_last);
end
V_out = V;
end