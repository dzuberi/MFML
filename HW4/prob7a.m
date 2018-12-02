%code to compute A; part a
load('hw4p7.mat')
A = zeros(size(udata,2),6);
for i = 1:size(udata,2)
    sm = udata(1,i);
    tm = udata(2,i);
    A(i,1) = sm.^2;
    A(i,2) = tm.^2;
    A(i,3) = sm.*tm;
    A(i,4) = sm;
    A(i,5) = tm;
    A(i,6) = 1;
end

%code to solve, part b
ATA = A'*A;
AAT = A*A';
[U,S,V] = svd(A);
U = U(:,1:6);
S = S(1:6,:);
als = V*inv(S)*U'*ydata;
als_correct = A\ydata;
%code to create contours
s = linspace(0,1,1000);
t = linspace(0,1,1000);
[x,y] = meshgrid(s,t);

f = als(1).*x.^2 + als(2).*y.^2 + als(3).*x.*y + als(4).*x + als(5).*y+als(6);
hold off
contour(s,t,f,25);
xlabel("s");
ylabel("t");
title("7 c: contours of f");