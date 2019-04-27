close all; clc; clear all;
Im1 = imread('bricks3.jpg');
Im1 = double(rgb2gray(Im1));
 Im2 = contract(Im1,2/3, -50);
 Im1 = Im1.*fspecial('Gaussian',size(Im1),150)*500;
 Im2 = Im2.*fspecial('Gaussian',size(Im2),150)*500;
figure; imshow(Im1); figure; imshow(Im2);
M = 1025; N=1025;
Im1fft = fft2(Im1,M,N);
Im2fft = fft2(Im2,M,N);
Im1fft= fftshift(Im1fft);
Im2fft= fftshift(Im2fft);
figure; imagesc(abs(Im1fft)/max(max(abs(Im1fft)))); figure; imagesc(abs(Im2fft)/max(max(abs(Im2fft))))

a1= 0; b1 = 0; c1=0;
theta = -90:3:90;
I1 = 0;
for u1 = -(M-1)/2:(M-1)/2
    for v1 =-(M-1)/2:(M-1)/2
        x=u1+1+(M-1)/2; y = v1+1+(M-1)/2;
        a1 = a1+ (u1)^2*(abs(Im1fft(x,y)))^2;
        b1 = b1+ 2* u1*v1*(abs(Im1fft(x,y)))^2;
        c1 = a1+ (v1)^2*(abs(Im1fft(x,y)))^2;
        %I1= I1+(-u1*tand(theta)+v1).^2./(1+(tand(theta)).^2) * (abs(Im1fft(x,y)))^2;
    end
end
I1 = @(theta) 0.5*(a1+c1) + 0.5*(a1-c1)*cosd(2*theta) + 0.5*b1*sind(2*theta);


a2= 0; b2 = 0; c2=0;
I2 = 0;
for u2 = -(M-1)/2:(M-1)/2
    for v2 = -(M-1)/2:(M-1)/2
        x=u2+1+(M-1)/2; y = v2+1+(M-1)/2;
        a2 = a2+ (u2)^2*(abs(Im2fft(x,y)))^2;
        b2 = b2+ 2* u2*v2*(abs(Im2fft(x,y)))^2;
        c2 = a1+ (v2)^2*(abs(Im2fft(x,y)))^2;
        %I2= I2+(-u2*tand(theta)+v2).^2./(1+(tand(theta)).^2) * (abs(Im2fft(x,y)))^2;
    end
end

I2 = @(theta) 0.5*(a2+c2) + 0.5*(a2-c2)*cosd(2*theta) +0.5*b2*sind(2*theta);

M1 = max(I1(theta)); m1 = min(I1(theta));
M2 = max(I2(theta)); m2 = min(I2(theta));
k = sqrt(M1*m1/(M2*m2));
%%


figure

plot(theta,I1(theta),'g',theta,1.33*I2(theta),'r');
