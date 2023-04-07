function [psnr, ssim] = Quality_ass(imagery1, imagery2)
Nway = size(imagery1);
psnr = zeros(Nway(3),1);
ssim = zeros(Nway(3),1);
for i = 1:Nway(3)
    psnr(i) = psnr_index(imagery1(:, :, i), imagery2(:, :, i));
    ssim(i) = ssim_index(imagery1(:, :, i), imagery2(:, :, i));
end
psnr = mean(psnr);
ssim = mean(ssim);

