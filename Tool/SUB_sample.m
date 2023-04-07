function HR = SUB_sample(LRMS, sf)
if sf==4
    HR = imresize(LRMS,sf);
    [rows,cols,band] = size(HR);
    s0 = 3;              
    for i=1:band
        temp=HR(:,:,i);
        temp(s0:sf:rows,s0:sf:cols)=LRMS(:,:,i);
        HR(:,:,i)=temp;
    end
else
    error('The upsampling method is not defined !')
end
end