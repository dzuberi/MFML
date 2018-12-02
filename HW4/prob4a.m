phi  =  @(z)  exp(-z.^2);
x = @(z) (z<1/4).*(4*z) + (z>=1/4).*(z<1/2).*(-4*z+2)-(z>=1/2).*sin(20*pi*z);
t  =  linspace(0,  1,  1000);
hold off
figure(1);  
clf

N=32;
t  =  linspace(0,1,1000);
G = zeros(N,N);
for ii = 1:N %calculate gram matrix
    for jj = 1:N
        x_phik = @(z) phi(N*z - ii + 1/2) .* phi(N*z - jj +1/2);
        G(jj,ii) = integral(x_phik,0,1);
    end
end
H = inv(G);
duals = zeros(N,size(t,2));
for n = 1:N
    for L=1:N
        duals(n,:) = duals(n,:) + H(n,L).* phi(N.*t - L + 1/2);
    end
end
plot(t,duals(13,:))
tau = 0.3242234;
k = zeros(size(t));
for n = 1:N
    k = k + phi(N.*tau - n + 1/2) .* duals(n,:);
end
%plot(t,k)
alpha = randn(N,1); %random xA 
xtau = 0;
for n = 1:N %calculate x(tau)
    xtau = xtau + alpha(n).*phi(N.*tau - n + 1/2);
end
beta = zeros(N,1);
for l = 1:N %calculate coefficients of ktau function
    for n = 1:N
        beta(l) = beta(l) + H(n,l) .* phi(N.*tau - n + 1/2);
    end
end
xtau1 = alpha'*G*beta; %<x,ktau>
xtau
xtau1
%
tau = linspace(0,1,1000);
coeffs = zeros(N,size(tau,2));
for l = 1:N %calculate coefficients of ktau function
    for n = 1:N
        coeffs(l,:) = coeffs(l,:) + H(n,l) .* phi(N.*tau - n + 1/2);
    end
end
%sweep over tau
ktau = zeros(size(tau,2),size(t,2));
for i = 1:length(tau)
    for n = 1:N
        ktau(i,:) = ktau(i,:) + coeffs(n,i).*phi(N.*t - n + 1/2);
    end
end
%hold off
%plot(t,k)
%plot(t,k)
%hold on

%plot(t,ktau(1,:))
%imagesc(t,tau,ktau)
%colorbar
%title("image of kernel")
xlabel("t");
%ylabel("tau");
ylabel("psi");
title("4 a: dual basis vector 13")