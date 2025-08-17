function yrr = rightrail(xrr, L, y_shift) 
% yrr = y coordinate of right rail
% xrr = x coordinate of right rail

% L = distance between centers of rail

xa = L - 37.18; ya = 172-37.48 + y_shift;
xb = L - 36.02; yb = 172-14.30+ y_shift;
xc = L - 26.05; yc = 172-2.3+ y_shift;
xd = L - 10.25; yd = 172-0.18 + y_shift;

xg = L + 37.18; yg = 172-37.48+ y_shift;
xi = L + 36.02; yi = 172-14.30+ y_shift;
xf = L + 26.05; yf = 172-2.3+ y_shift;
xe = L + 10.25; ye = 172-0.18 + y_shift;


if xrr<=xb && xrr>=xa
    yrr = ya + (yb-ya)*(xrr-xa)/(xb-xa);
elseif xrr<=xc && xrr>xb
    [c1,c2,c3,c4] = findCircleCenters(xb, yb,xc,yc,13);
    yrr = c4 + sqrt((13^2)-(xrr-c3)^2);
elseif xrr<=xd && xrr>xc
    [c5,c6,c7,c8] = findCircleCenters(xd, yd,xc,yc,80);
    yrr = c6 + sqrt((80^2)-(xrr-c5)^2);
elseif xrr<=xe && xrr>xd
    [c5,c6,c7,c8] = findCircleCenters(xd,yd,xe,ye,300);
    yrr=c8 + sqrt((300^2)-(xrr-c7)^2);

elseif xrr<=xg && xrr>=xi
    yrr = yg + (yg-yi)*(xrr-xg)/(xg-xi);
elseif xrr<=xi && xrr>xf
    [c1,c2,c3,c4] = findCircleCenters((xf), yf,xi,yi,13);
    yrr = c4 + sqrt((13^2)-(xrr-c3)^2);
elseif xrr<=xf && xrr>xe
    [c5,c6,c7,c8] = findCircleCenters(xf, yf,xe,ye,80);
    yrr = c6 + sqrt((80^2)-(xrr-c5)^2);

else
    yrr=0;
    disp('rail derailed');
end