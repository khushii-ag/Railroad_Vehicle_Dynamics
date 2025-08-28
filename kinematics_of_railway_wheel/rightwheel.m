function [ywr] = rightwheel(xwr, L, y_shift)

%Length till the outer portion of wheel
%origin taken at centre of wheel hence shift of -420 in y direction


xa = L; ya = y_shift - 14;
xb = L + 27.96; yb = y_shift - 19.39;
xc = L + 30.98; yc = y_shift - 11.84;
xd = L + 40.48; yd = y_shift - 3.48;
xe = L + 52.17; ye = y_shift - 1.19;
xf = L + 74.52; yf = y_shift + 0.69;
xg = L + 127; yg = y_shift + 3.31;

if xwr<xb && xwr>=xa
    [c1, c2, c3, c4] = findCircleCenters(xa, ya, xb, yb, 14.5); %will have to find out which center
    ywr = c2 - sqrt((14.5^2)-(xwr-c1)^2); 


elseif xwr<xc && xwr>=xb
    ywr = yb + (yc-yb)*(xwr-xb)/(xc-xb);

elseif xwr<xd && xwr>=xc
    [c1, c2, c3, c4] = findCircleCenters(xc, yc, xd, yd, 14);
    ywr = c4 + sqrt((14^2)-(xwr-c3)^2); 

elseif xwr<xe && xwr>=xd
    [c1, c2, c3, c4] = findCircleCenters(xd, yd, xe, ye, 100);
    ywr = c4 + sqrt((100^2)-(xwr-c3)^2);


elseif xwr<xf && xwr>=xe
    [c1, c2, c3, c4] = findCircleCenters(xe, ye, xf, yf, 330);
    ywr = c4 + sqrt((330^2)-(xwr-c3)^2); 

elseif xwr<=xg && xwr>=xf
    ywr = yf + (yg-yf)*(xwr-xf)/(xg-xf);

else
    ywr=0;
    disp('wheel derailed');
end

end