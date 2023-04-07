function X_out = X_subproblem(U, V, Theta_1, Theta_2, par, opts)

Nways = opts.Nways;
eta_1  = opts.eta_1;
eta_2  = opts.eta_2;

X_out = zeros(Nways);
for band=1:Nways(3)
    Temp_up = eta_1*fft2(U(:,:,band)).*par.fft_BT(:,:,band) - fft2(Theta_1(:,:,band)).*par.fft_BT(:,:,band)...
        + eta_2*fft2(V(:,:,band)) - fft2(Theta_2(:,:,band));
    
    Temp_down = eta_1*par.fft_B(:,:,band).*par.fft_BT(:,:,band) + eta_2;
    
    X_out(:,:,band) = real(ifft2(Temp_up./Temp_down));
end
X_out(X_out > 1) = 1;
X_out(X_out < 0) = 0;
end