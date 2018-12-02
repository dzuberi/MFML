%S(1,4) S(1,5) S(1,6) S(2,4) S(2,5) S(2,6) S(3,5) S(3,6) all 0
load('hw10p2data.mat');
N = size(X,2);
R = size(X,1);
sig = zeros(R,R);
for n = 1:N
    xn = X(:,n);
    sig = sig + xn*xn';
end
sig = sig/N;
max_S = inv(sig);
max_S(1,4:6) = [0 0 0];
max_S(2,4:6) = [0 0 0];
max_S(3,5:6) = [0 0];
max_S(4:6,1) = [0 0 0]';
max_S(4:6,2) = [0 0 0]';
max_S(5:6,3) = [0 0]';
mle_R = inv(max_S);