function [warp2] = contract(sa, ra, image)
    
%      Rin = imref2d(size(image));
%      Rin.XWorldLimits = Rin.XWorldLimits-mean(Rin.XWorldLimits);
%      Rin.YWorldLimits = Rin.YWorldLimits-mean(Rin.YWorldLimits);
% 
%     R = [cosd(ra) -sind(ra) 0; sind(ra) cosd(ra) 0; 0 0 1];
%     RR = [cosd(-ra) -sind(-ra) 0; sind(-ra) cosd(-ra) 0; 0 0 1];
%     S = [sa 0 0; 0 1 0; 0 0 1];
%     
%     tform = R;
%     
%     trans =  affine2d(R);
%     transB =  affine2d(RR);
%     
%     warp = image;
%     warp1 = imwarp(warp,trans);
%      figure;
%     imshow(warp1)
%     
%     warp2 = imresize(warp1, [M, sa*N]);
%      figure;
%     imshow(warp2)
%     [M1,N1] = size(warp2);
%      Rin = imref2d(size(warp2));
%      Rin.XWorldLimits = Rin.XWorldLimits-mean(Rin.XWorldLimits);
%      Rin.YWorldLimits = Rin.YWorldLimits-mean(Rin.YWorldLimits);
%     
%     warp3 = imwarp(warp2, transB);
%     figure; imshow(warp3);
%     
%     
%     warp4 = [zeros(M1,floor((N-N1)/2)), warp3, zeros(M1,ceil((N-N1)/2))];
%     figure;
%     imshow(warp4)
warp = imrotate(image,ra);
 [M,N] = size(warp);
warp1 = imresize(warp, [M, sa*N]);
warp2 = imrotate(warp1,-ra);


end

