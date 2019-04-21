frontal = imread('check.jpg');
front = rgb2gray(frontal);
Nf = size(front);   % size of frontal texel image
%imshow(front);

a = 45;
R = [cosd(a) -sind(a) 0; sind(a) cosd(a) 0; 0 0 1];

b = 0.5;
S = [b 0 0; 0 1 0; 0 0 1]
tR =  affine2d(R);
tS =  affine2d(S);
warp = front;
warp = imwarp(warp,tR);
warp = imwarp(warp,tS);

rotback = affine2d([cosd(-45) -sind(-45) 0; sind(-45) cosd(-45) 0; 0 0 1]);

warp = imwarp(warp,rotback);

% warp = warp( 1:Nf(1), 1:Nf(2) );
imtool(warp);