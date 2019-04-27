function [I2, c] = normalizeInertia(I1, I2)
%     scaleFactor = sqrt((M1*m1)/(M2*m2));
% %     scaleFactor = (M1*m1)/(M2*m2);
%     I2 = scaleFactor .* I2;
%     
    
    c = 4;
    x = 100;
    while x > 0
        c = c - 0.01;   
        x = min((c.*I2) - I1);           
    end
    I2 = c.* I2;
    
end

