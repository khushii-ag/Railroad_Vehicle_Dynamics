function z = contact_pt(x_c, L1, y1, L2, y2)
z = diffr(@rightwheel,x_c, L1, y1)-diffr(@rightrail,x_c, L2, y2);
z= norm(z);
%we want to find the point where this norm is 0 
end