function q=newton(fun,q0,L1,y1,L2,y2)
f0=feval(fun,q0,L1,y1,L2,y2);
count=0;
h= 1e-6;
n=length(q0);
e=eye(n)*h;
D=e;

while((norm(f0)>1e-6)*(count<6000))
    for k=1:n
        D(:,k)=(feval(fun,q0+e(:,k),L1,y1,L2,y2)-f0)/h;
    end
    q0=q0-D\f0;
    f0=feval(fun,q0,L1,y1,L2,y2);
    count=count+1;
end

if count==6000
    q=q0/0;
else
    q=q0;
end 