Ns = [10,20,50,100,200];
t = 1/3;
g = @(z) exp(-200 .* z.^2);
for n = 1:length(Ns)
    N = Ns(n);
    psit = @(z) g(t - z/N);
    PSI = zeros(1,N);
    for k = 1:N
        PSI(k) = psit(k);
    end
    subplot(3,2,n)
    plot((1:N)/N, PSI,'o');
    xlabel('i/N')
    ylabel('coefficients')
    title(sprintf('feature map for N = %d',N))
end
s = linspace(0,1,1000);
subplot(3,2,6)
phis = exp(-100 * abs(s - t).^2);
plot(s,phis);
title('Radial Basis Kernel Map')
xlabel('s')
ylabel('k(s,t)')