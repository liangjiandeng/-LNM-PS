function Index = Quality_assess(HR_ref, HR_fusion, ratio)
%================
% This is a demo to compute pansharpening indexes
% Z.-C.Wu (UESTC)
% 2019-10-5
% ratio : GSD ratio between HRMS and LRMS images
%================
[Index.PSNR, Index.SSIM]  = Quality_ass(HR_ref * 255, HR_fusion  * 255);
[rows,cols,~] = size(HR_ref);
%Remove border from the analysis
HR_ref    = HR_ref(ratio+1:rows-ratio,ratio+1:cols-ratio,:);
HR_fusion = HR_fusion(ratio+1:rows-ratio,ratio+1:cols-ratio,:);
HR_ref(HR_ref > 1) = 1;
HR_ref(HR_ref < 0) = 0;
% maxval1 = max(Computed(:));  minval1= min(Computed(:));
% maxval2 = max(HRMS(:));  minval2= min(HRMS(:));
[Index.PSNR, Index.SSIM]  = Quality_ass(HR_ref * 255, HR_fusion  * 255);

 [angle_SAM,~]  = SAM( HR_ref, HR_fusion);
 Index.SAM      = angle_SAM;
 Index.SCC      = CC(HR_ref,HR_fusion);
 
 Index.ERGAS    = ERGAS( HR_ref, HR_fusion, ratio);
 Index.Q8       = Q(HR_ref,HR_fusion );
 
%  Index.QAVE     = QAVE( HRMS, Computed);
%  Index.RASE     = RASE( HRMS, Computed);
%  Index.RMSE     = RMSE( HR_ref, HR_fusion );
%  index.QAVE     = q2n( HRMS,Computed,32,32);
%  index.CC          = CC( HRMS, Computed);
%  index.PSNR      = psnr(Computed, HRMS);
%  index.SSIM      = ssim(255*Computed, 255*HRMS);
end
 
