close all; clc; clear all;
brightness = 50000;
winSize = 5000;
Im1 = imread('wall.jpg');
Im1 = double(Im1);
frontalPatch = imread('wallF.jpg');
frontalPatch = double(rgb2gray(frontalPatch));
[H,W] = size(Im1);   % W = X,   H = Y
patchSize = min(size(frontalPatch));
frontalPatch = frontalPatch(1:patchSize, 1:patchSize);
Wn = floor(W/patchSize);  % number of patches in x direction
Hn = floor(H/patchSize);  % number of patches in y direction
NumOfPatches = Wn * Hn;
tiltAngles = zeros(Hn, Wn);
slantAngles = zeros(Hn, Wn);
theta = -90:1:90;
%% Frontal Patch Extraction

H2 = Hn*patchSize;
W2 = Wn*patchSize;
% frontalPatch = Im1(H2-patchSize+1:H2, W2-patchSize+1:W2);  % bottom right corner piece
frontalPatch = frontalPatch.*fspecial('Gaussian',size(frontalPatch),winSize)*brightness;
figure;
imshow(uint8(frontalPatch));
% Frontal Patch fourier analysis
M = 1025; N=1025;
Im1fft = fft2(frontalPatch,M,N);
Im1fft= fftshift(Im1fft);

% Frontal Patch Spectral Inertia
[I1, max1, min1] = spectral_Inertia(Im1fft);
% figure;
% plot(theta, I1, 'g');

%% Local Patch Extraction 
croppedRangeX = floor(W/patchSize) * patchSize;
croppedRangeY = floor(H/patchSize) * patchSize;
anglesX = 1;  % tiltAngles array index
anglesY = 1;
for p = 1:patchSize:H2
    for q = 1:patchSize:W2       
        localPatch = Im1(p:p+patchSize-1, q:q+patchSize-1);  %extract local patch
        localPatch = localPatch.*fspecial('Gaussian',size(localPatch),winSize)*brightness; % apply gaussian window
        %Im1(p:p+patchSize-1, q:q+patchSize-1) = localPatch; %update that patch with gaussian window in original image
%         imshow(uint8(localPatch));
        
        % Local Patch fourier analysis
        Im2fft = fft2(localPatch,M,N);
        Im2fft= fftshift(Im2fft);
%         imshow(uint8(Im2fft));
        
%         % Local Patch Spectral Inertia
        [I2, max2, min2] = spectral_Inertia(Im2fft);
        I2 = normalizeInertia(I2, max1, min1, max2, min2);
%         plot(theta, I1, 'g', theta, I2, 'r');
%         pause(.1);
        
        [MinVal, index] = min(abs(I2-I1));
        tilt = theta(1,index);
        tiltAngles(anglesY, anglesX) = tilt;
        
        orthoA = mod(tilt + 90, -90);
        [minA, indexI] = min(abs(theta - orthoA));
        k = sqrt(I2(indexI)/I1(indexI));
        slant = acosd(1/k);
        slantAngles(anglesY, anglesX) = abs(slant);
        anglesX = anglesX + 1;
    end
    anglesX = 1;
    anglesY = anglesY + 1;
    
end
zsurf = shapeletsurf(slantAngles, tiltAngles, 6, 1, 1, 'tilt');

V=interp2(zsurf); 
W=interp2(V); 
surf(W);
% surf(slantAngles, tiltAngles, zsurf);

% needleplotst(slantAngles, tiltAngles, 1, 1);
