phi  =  @(z)  exp(-z.^2);
x = @(z) (z<1/4).*(4*z) + (z>=1/4).*(z<1/2).*(-4*z+2)-(z>=1/2).*sin(20*pi*z);
t  =  linspace(0,  1,  1000);
%figure(1);  
%clf
hold  on
N=4;
a=[-1 1 2 -1/2];
for  kk  =  1:N
    plot(t,  phi(N*t  -  kk  +  1/2))
end
hold off
t  =  linspace(0,1,1000);
y  =  zeros(size(t));
for  jj  =  1:N
    y  =  y  +  a(jj)*phi(N*t  -  jj  +  1/2);
end
plot(t,y)
xlabel('t')
ylabel('y')
title('3b. N=4, alphas = -1,1,2,-1/2')