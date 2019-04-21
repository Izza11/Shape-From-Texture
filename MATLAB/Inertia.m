%% Calculate spectral inertia
% a = Eu Ev u^2.F(u,v)
af = 0;
aw = 0;
add = Nf(1)/2;
for u = -Nf(1)/2 + 1:Nf(1)/2 
    for v = -Nf(1)/2 + 1:Nf(1)/2 
        sumf = (u*u) * abs(f(u+add,v+add));
        af = af + sumf;  
        
        sumw = (u*u) * abs(f2(u+add,v+add));
        aw = aw + sumw;  
    end
end

% b = 2*( Eu Ev u*v . F(u,v) )
bf = 0;
bw = 0;
for u = -Nf(1)/2 + 1:Nf(1)/2 
    for v = -Nf(1)/2 + 1:Nf(1)/2 
        sumf = (u*v) * abs(f(u+add,v+add));
        bf = bf + sumf;
        
        sumw = (u*v) * abs(f2(u+add,v+add));
        bw = bw + sumw;
    end
end
bf = 2*bf;
bw = 2*bw;

% a = Eu Ev v^2 F(u,v)
cf = 0;
cw = 0;
for u = -Nf(1)/2 + 1:Nf(1)/2 
    for v = -Nf(1)/2 + 1:Nf(1)/2 
        sumf = (v*v) * abs(f(u+add,v+add));   % or real() instead of abs?
        cf = cf + sumf; 
        
        sumw = (v*v) * abs(f2(u+add,v+add));   % or real() instead of abs?
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
    
    if ( abs(If - Iw) < (10^7) )
        tilts(ti) = angle;
        ti = ti + 1;      
    end  
    
    angleZ(angle) = angle;
end


plot(angleZ, InertiaF, 'color', 'green');
hold on;
plot(angleZ, InertiaW, 'color', 'red');