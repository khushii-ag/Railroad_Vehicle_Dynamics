function data=plot_profile(L1,L2,y1,y2)

%rail profile plot
data = [];
for i = (L1 - 37.18):0.1: (L1 + 37.18)
    y = rightrail(i, L1, y1);
    data = [data ; i, y]; 
end
plot(data(:,1),data(:,2),'-')

hold on

%wheel profile plot
data = [];
for i = L2 : 0.1 : L2 + 127
    y = rightwheel(i, L2, y2);
    data = [data ; i, y]; 
end
plot(data(:,1),data(:,2),'-')

end
