clear all;
close all;
%% Read frontal image
frontal = imread("exfront.jpg");
front = rgb2gray(frontal);
frontW = front(1:344, 1:344);
% imtool(front);

warp = imread("exwarp.jpg");
warped = rgb2gray(warp);
warpW = warped(1:344, 1:344);
% imtool(warped);
Nf = size(frontW);   % size of frontal texel image
%imshow(front);



%% Take fourier transform
f = fft2(frontW);
f = fftshift(f);
% ^ do we need to normalize by size of matrix?
impf=abs(f).^2;
%imtool(f, [0 50]);
% figure
% % imagesc(Nf(1),Nf(2),log10(impf)), axis xy
% imagesc(abs(log2(f)));
% axis image
% % https://www.mathworks.com/help/matlab/ref/fft2.html?s_tid=doc_ta


f2 = fft2(warpW);
f2 = fftshift(f2);
impf2=abs(f2).^2;
%imtool(f, [0 50]);
% figure
% % imagesc(Nw(1),Nw(2),log10(impf2)), axis xy
% imagesc(abs(log2(f2)));
% axis image
%% Calculate spectral inertia
% a = Eu Ev u^2.F(u,v)
af = 0;
aw = 0;
add = Nf(1)/2;
urange = -(Nf(1)-1)/2:(Nf(1)-1)/2;
vrange = -(Nf(2)-1)/2:(Nf(2)-1)/2;
for x = 1:Nf(1)
    for y = 1:Nf(1) 
        sumf = (urange(x)*urange(x)) * abs(f(x,y));
        af = af + sumf;  
        
        sumw = (urange(x)*urange(x)) * abs(f2(x,y));
        aw = aw + sumw;  
    end
end

% b = 2*( Eu Ev u*v . F(u,v) )
bf = 0;
bw = 0;
for x = 1:Nf(1)
    for y = 1:Nf(1)
        sumf = (urange(x)*vrange(y)) * abs(f(x,y));
        bf = bf + sumf;
        
        sumw = (urange(x)*vrange(y)) * abs(f2(x,y));
        bw = bw + sumw;
    end
end
bf = 2*bf;
bw = 2*bw;

% a = Eu Ev v^2 F(u,v)
cf = 0;
cw = 0;
for x = 1:Nf(1)
    for y = 1:Nf(1)
        sumf = (vrange(y)*vrange(y)) * abs(f(x,y));   % or real() instead of abs?
        cf = cf + sumf; 
        
        sumw = (vrange(y)*vrange(y)) * abs(f2(x,y));   % or real() instead of abs?
        cw = cw + sumw; 
    end
end

If = 0;
Iw = 0;
tilts = [];
ti = 1;

InertiaF = [];
InertiaW = [];
angleZ = [];
for angle = 1:360
    If = 0.5*(cf+af) - 0.5*(af-cf)*(cosd(2*angle)) - 0.5*(bf*sind(2*angle));
    InertiaF(angle) = If;
      
    Iw = 0.5*(cw+aw) - 0.5*(aw-cw)*(cosd(2*angle)) - 0.5*(bw*sind(2*angle));
    InertiaW(angle) = Iw;
    
%     if ( abs(If - Iw) < (10^7) )
%         tilts(ti) = angle;
%         ti = ti + 1;      
%     end  
    
    angleZ(angle) = angle;
end
%%


%%

plot(angleZ, InertiaF, 'color', 'green');
hold on;
plot(angleZ, 1.2*InertiaW, 'color', 'red'); %compressed 