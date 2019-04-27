function [I1, max1, min1] = spectral_Inertia(Im1fft, theta, M)

    % Im1fft = shifted fourier transform 
    a1= 0; b1 = 0; c1=0;
    I1 = 0;
    for u1 = -(M-1)/2:(M-1)/2
        for v1 =-(M-1)/2:(M-1)/2
            x=u1+1+(M-1)/2; y = v1+1+(M-1)/2;
            a1 = a1+ (u1)^2*(abs(Im1fft(x,y)))^2;
            b1 = b1+ 2* u1*v1*(abs(Im1fft(x,y)))^2;
            c1 = c1+ (v1)^2*(abs(Im1fft(x,y)))^2;
            %I1= I1+(-u1*tand(theta)+v1).^2./(1+(tand(theta)).^2) * (abs(Im1fft(x,y)))^2;
        end
    end
    % [I1, max1, min1] = spectral_Inertia(Im1fft);
    I1 = 0.5*(a1+c1) + 0.5*(a1-c1)*cosd(2*theta) + 0.5*b1*sind(2*theta);
    max1 = max(I1);
    min1 = min(I1);
end

