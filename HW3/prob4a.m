hold off
t = linspace(0,1,1000);
w = @(z) 16.*(z-1/2).^2;
x = @(z) exp(z);
plot(t,w(t));title('4a w(t) plot');xlabel('t');ylabel('w(t)');
N=3;
G = zeros(N,N);
b = zeros(N,1);
for i = 1:N %compute b vector
    ip = @(z) w(z) .* x(z) .* z.^(i-1);
    %ip = @(z) x(z) .* z.^(i-1);
    b(i) = integral(ip,0,1);
end
for i=1:N %compute gram matrix
    for j=1:N
        ip = @(z) w(z) .* z.^(i-1) .* z.^(j-1);
        %ip = @(z) z.^(i-1) .* z.^(j-1);
        G(i,j) = integral(ip,0,1);
    end
end
alpha = G\b;
hold off
%plot(t, alpha(1) + alpha(2) .* t + alpha(3) .* t.^2);
hold on
%plot(t, exp(t));
%final alpha values: 1.0095, 0.8547, 0.8436