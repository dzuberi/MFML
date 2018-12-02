load('hw5p3_scatterdata.mat');
k = @(s,t,sigma) exp(-(abs(t-s).^2/(2.*sigma.^2)));
ftrue = @(z) sin(12.*(z+0.2))./(z+0.2);
t = linspace(0,1,5000);
%sigs = 1/50;
%sigs = [1/2 1/5 1/10 1/20 1/50 1/100 1/200];
sigs = 1/10;
gen_errors = zeros(1,length(sigs));
sample_errors = zeros(1,length(sigs));
del = 0.004;
for s = 1:length(sigs)
    sig = sigs(s);
    K = zeros(length(T),length(T));
    for l = 1:length(T)
        for m = 1:length(T)
            K(l,m) = k(T(m),T(l),sig);
        end
    end
    I = eye(length(T),length(T));
    alphas = inv(K + del*I)*y;
    fhat = @(z) 0;
    for m = 1:length(T)
        fhat = @(z) fhat(z) + alphas(m).*k(z,T(m),sig);
    end
    gen_errors(s) = sqrt(integral(@(z) (fhat(z) - ftrue(z)).^2,0,1));
    sample_errors(s) = sqrt(sum((y - fhat(T)).^2));
    figure
    hold on
    scatter(T,y);
    plot(t,ftrue(t));
    plot(t,fhat(t));
    title(sprintf("sig=%0.3f, gen=%0.3f, samp=%0.3f",sigs(s),gen_errors(s),sample_errors(s)));
    xlabel("t")
    ylabel("y")
    hold off
end