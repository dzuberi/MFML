load('hw5p2_clusterdata.mat');
lpoly = @(z,p) sqrt(2).*sqrt((2*p+1)/2).*legendreP(p,2.*z-1);
P = 3;
resolution = 5000;
t = linspace(0,1,resolution);
ps = [3 5 10 15 20 25];
%ps = 2:5;
fs = zeros(length(ps),length(t));
gen_errors = zeros(length(ps),1);
sample_errors = zeros(length(ps),1);
ws = zeros(length(ps), ps(end)+1);
sv_mins = zeros(length(ps),1);
sv_maxs = zeros(length(ps),1);
for d = 1:length(ps)
    P = ps(d);
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
    
    w = inv(A'*A)*A'*y;
    f = t.*0;
    for i = 1:length(w)
        f = f + w(i).*lpoly(t, i-1);
    end
    fz = @(z) 0;
    for i = 1:length(w)
        fz = @(z) fz(z) + w(i).*lpoly(z,i-1);
    end
    ftrue = @(z) sin(12*(z+0.2))./(z+0.2);
    gen_error = sqrt(integral(@(z) (fz(z) - ftrue(z)).^2,0,1));
    sample_error = sqrt(sum((y - fz(T)).^2));
    fs(d,:) = fz(t);
    gen_errors(d) = gen_error;
    sample_errors(d) = sample_error;
    ws(d,1:length(w)) = w;
    sv_mins(d) = svals(end);
    sv_maxs(d) = svals(1);
    figure
    hold on
    plot(t,fz(t))
    if P==3
        scatter(T,y)
    else
        scatter(T,y)
        plot(t,ftrue(t))
    end
    hold off
    title(sprintf("P=%0.3f, gen=%0.3f, samp=%0.3f, SV range [%0.3f,%0.3f]",ps(d),gen_errors(d),sample_errors(d),sv_mins(d),sv_maxs(d)));
    xlabel("t")
    ylabel("y,f")
end
figure
plot(ps+1,gen_errors)
title("Generalization error vs N")
xlabel("N")
ylabel("gen_error")
figure
plot(ps+1,sample_errors)
title("Sample Error vs N")
xlabel("N")
ylabel("gen_error")