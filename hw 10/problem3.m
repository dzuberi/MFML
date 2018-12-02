N = 1e4;
for i = 1:N
    X = randn(1e6,1);
    [val ind] = max(X);
end