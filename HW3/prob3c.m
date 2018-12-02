phi  =  @(z)  exp(-z.^2);
x = @(z) (z<1/4).*(4*z) + (z>=1/4).*(z<1/2).*(-4*z+2)-(z>=1/2).*sin(20*pi*z);
t  =  linspace(0,  1,  1000);
hold off
figure(1);  
clf

N=50;
t  =  linspace(0,1,1000);
y  =  zeros(size(t));
b = [];
for  jj  =  1:N %calculate b vector
    x_phik = @(z) x(z).*phi(N*z - jj + 1/2);
    b = [b integral(x_phik,0,1)];
end
b=b';
G = zeros(N,N);
for ii = 1:N %calculate gram matrix
    for jj = 1:N
        x_phik = @(z) phi(N*z - ii + 1/2) .* phi(N*z - jj +1/2);
        G(jj,ii) = integral(x_phik,0,1);
    end
end
alphas = G\b; %find coefficients

plot(t,x(t))
hold on
t  =  linspace(0,1,1000);
y  =  zeros(size(t));
for  jj  =  1:N %construct approximation with bases
    y  =  y  +  alphas(jj)*phi(N*t  -  jj  +  1/2);
end
plot(t,y)
title(sprintf('3c approximation for x, N=%d',N))
xlabel('t')
ylabel('x(t)')