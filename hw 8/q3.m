N=100;
X = rand(1,N).*10;
norm = @(x,u,sig) exp(-(x-u).^2./(2.*sig.^2));
a = linspace(0,2,10000);
L = norm(X(1),0,1);;
for n = 2:N
    L = L .* norm(X(n),a.*X(n-1),1);
end
[num ind] = max(L);
max_a = a(ind)
calc_a = sum(X(1:end-1) .* X(2:end)) / sum(X(1:end-1).^2)