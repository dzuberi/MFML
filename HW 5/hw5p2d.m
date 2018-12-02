load('hw5p2_clusterdata.mat');
lpoly = @(z,p) sqrt(2).*sqrt((2*p+1)/2).*legendreP(p,2.*z-1);
rprimes = 5:1:26;
gen_errors = zeros(1,length(rprimes));
sample_errors = zeros(1,length(rprimes));
P = 25;
resolution = 5000;
t = linspace(0,1,resolution);
A = zeros(length(T), P+1);
for ii = 1:length(T)
    for jj = 1:P+1
        A(ii,jj) = lpoly(T(ii),jj-1);
    end
end

[U,S,V] = svd(A);
svals = zeros(1,size(A,2));
S = S(1:26,:);
U = U(:,1:26);
for i = 1:size(A,2)
    svals(i) = sum(S(:,i));
end
stem(svals) %1-22 are good

%w = inv(A'*A)*A'*y;
for R = 1:length(rprimes)
    rprime = rprimes(R);
    w = 0;
    for r = 1:rprime
        w = w + 1/svals(r)*(y'*U(:,r))*V(:,r);
    end
    f = t.*0;
    for i = 1:length(w)
        f = f + w(i).*lpoly(t, i-1);
    end
    fz = @(z) 0;
    for i = 1:length(w) 
        fz = @(z) fz(z) + w(i).*lpoly(z,i-1);
    end
    ftrue = @(z) sin(12*(z+0.2))./(z+0.2);
    gen_errors(R) = sqrt(integral(@(z) (fz(z) - ftrue(z)).^2,0,1));
    sample_errors(R) = sqrt(sum((y - fz(T)).^2));
end
