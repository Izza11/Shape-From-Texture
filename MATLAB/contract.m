function warIm= contract(Im, k,theta)
R = [ cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1];
RR = inv(R);
S = [k 0 0; 0 1 0; 0 0 1];
T = RR*S*R;
trans = affine2d(T);
Rin = imref2d(size(Im));
Rin.XWorldLimits = Rin.XWorldLimits-mean(Rin.XWorldLimits);
Rin.YWorldLimits = Rin.YWorldLimits-mean(Rin.YWorldLimits);
warIm = imwarp(Im,Rin,trans);


end