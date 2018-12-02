H = [2 1; 1 2];
b = [-1 -3]';
x_opt = H\b;
delta = 3;
f = @(x_1,x_2) x_1.^2 + x_2.^2 + x_1.*x_2 + x_1 + 3.*x_2;
x1 = linspace(x_opt(1)-delta,x_opt(1)+delta,1000);
x2 = linspace(x_opt(2)-delta,x_opt(2)+delta,1000);
[X1, X2] = meshgrid(x1,x2);
plot(x_opt(1),x_opt(2),'o')
hold on
contour(X1,X2,f(X1,X2),30)
plot(x1,x1-2) %eigenvector 1 going out from the optimal point
plot(x1,-x1-4/3) %eigenvector 2 going out from the optimal point
plot(0,0,'ko');
%plot(X(1,:),X(2,:))
title('contour and steepest descent problem 4')
xlabel('x1')
ylabel('x2')
X = zeros(2,3);
x = [0;0];
X(:,1) = x;
r = b - H*x;
d = r;
B = 0;
for k = 1:2 %assuming 4 iterations means until x_4
    a = r'*r/(d'*H*d);
    x = x + a*d;
    r_old = r;
    r = r - a*H*d;
    B = r'*r/(r_old'*r_old);
    d = r + B*d;
    X(:,k+1) = x;
end
plot(X(1,:),X(2,:))
hold off