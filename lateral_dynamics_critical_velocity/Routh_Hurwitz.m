%Stability determined by Routh Hurwitz criterion:

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

% Define a range of V values to analyze
V_values = linspace(20, 150, 100);

% Loop over all V values and compute the maximum real part of eigenvalues
for V = V_values
    
    p4 = a1*b1;
    p3 = (a1*b2 + a2*b1);
    p2 = (a1*b5 + a2*b2 + a5*b1 + a3*b3);
    p1 = (a2*b5 + a5*b2 - a3*b4 - a4*b3);
    p0 = (a5*b5 + a4*b4);

    coeffVector = [p4,p3,p2,p1,p0];
    stability = routh_hurwitz(coeffVector);

    if stability == 0
        disp(V)
        break;
    end

end

function [stability] = routh_hurwitz(coeffVector)
    ceoffLength = length(coeffVector);
    rhTableColumn = round(ceoffLength/2);
    
    rhTable = zeros(ceoffLength,rhTableColumn);
    
    rhTable(1,:) = coeffVector(1,1:2:ceoffLength);
    
    if (rem(ceoffLength,2) ~= 0)
        rhTable(2,1:rhTableColumn - 1) = coeffVector(1,2:2:ceoffLength);
    else
        rhTable(2,:) = coeffVector(1,2:2:ceoffLength);
    end

    epss = 0.01;
    %  Calculate other elements of the table
    for i = 3:ceoffLength
   
        %  special case: row of all zeros
        if rhTable(i-1,:) == 0
            order = (ceoffLength - i);
            cnt1 = 0;
            cnt2 = 1;
            for j = 1:rhTableColumn - 1
                rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
                cnt2 = cnt2 + 1;
                cnt1 = cnt1 + 2;
            end
        end
    
        for j = 1:rhTableColumn - 1
            %  first element of upper row
            firstElemUpperRow = rhTable(i-1,1);
            
            %  compute each element of the table
            rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - ....
                (rhTable(i-2,1) * rhTable(i-1,j+1))) / firstElemUpperRow;
        end
    
    
        %  special case: zero in the first column
        if rhTable(i,1) == 0
            rhTable(i,1) = epss;
        end
    end

    unstablePoles = 0;

    %   Check change in signs
    for i = 1:ceoffLength - 1
        if sign(rhTable(i,1)) * sign(rhTable(i+1,1)) == -1
            unstablePoles = unstablePoles + 1;
        end
    end
    
    if unstablePoles == 0
        stability = 1;
    else
        stability = 0;
    end

end
