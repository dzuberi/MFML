%problem 5 g verification
A = [1.01 0.99; 0.99 0.98];
e = randn(2,1e5);
y = e + 1;
x = inv(A) * [1;1];
xhat = inv(A) * y;
norm = zeros(1,size(e,2));
for n = 1:size(e,2)
    norm(n) = sum((x(:) - xhat(:,n)).^2);
end
mean(norm)