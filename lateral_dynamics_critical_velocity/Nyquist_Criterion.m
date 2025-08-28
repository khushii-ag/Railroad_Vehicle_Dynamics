%values
m=1486;
Iz=1034;
Iy=166;
W=25*1000;
ky=1.561*10^6;
k_sai = 2.12*10^6;
cy=0;
c_sai = 0;
r0=0.5;
l=0.835;
lambda0=0.1174;
eps0=6.423;
delta0=0.02754;
sigma=0.0508;
f11=7.44*10^6;
f22=6.79*10^6;
f23=13.7*10^3;
g=9.8;

N0= W*g/4;
kappa = delta0*(1-f23/(N0*r0));
Ky = ky + (2*N0*eps0/l)*(1-f23/(N0*r0));
K_sai = k_sai + (2*N0*l)*(-delta0+f23/(N0*l));

V_values = [70, 75, 80, 85, 90, 95];

for V = V_values

    term1_num = [(-2*f23/V + Iy*kappa*V/(r0*l)), 2*f22];
    term1_denum = [m, 2*f22/V, Ky];
    term2_num = [-2*f23/V + Iy*delta0*V/(r0*l) ,2*f11*lambda0*l/r0];
    term2_denum = [Iz, 2*f11*(l^2)/V, K_sai];
    
    term1 = tf(term1_num, term1_denum);
    term2 = tf(term2_num, term2_denum);
    transfer_function = term1*term2;

    poles = pole(transfer_function);
    poles_RHP = poles(real(poles)>0);
    n_poles_RHP = length(poles_RHP);
    
    if V>79
        color = 'r';
    else 
        color = 'b';
    end
    nyquist(transfer_function, color);
    grid on;
    hold on

end
