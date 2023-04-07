function U_out = U_subproblem(I_LRMS, X, Theta_1, par, opts)

eta_1 = opts.eta_1;
sz    = opts.sz;
ratio = opts.ratio;
Nways = opts.Nways;

temp_up = par.ST(I_LRMS) + eta_1*par.B(X) + Theta_1;
SST      =  zeros(sz);
s0       =  3;
SST(s0:ratio:end,s0:ratio:end) = ones(sz/ratio);
temp_down =  SST+eta_1;
temp_down =  repmat(temp_down, [1 1 Nways(3)]);

U_out    = temp_up./temp_down;
end