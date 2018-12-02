load('hwp8p5b.mat')
f = @(x,v) 1 ./ (pi * (1 + (x-v).^2));
%part b
med = zeros(1,size(X,2));
men = zeros(1,size(X,2));
mle = zeros(1,size(X,2));
v = linspace(-10,10,1e4);
for i = 1:size(X,2)
    med(i) = median(X(:,i));
    men(i) = mean(X(:,i));
    l = 0;
    for n = 1:size(X,1)
        l = l + log(f(X(n,i),v));
    end
    [val ind] = max(l);
    mle(i) = v(ind);
end
mse = [sum(med.^2)/size(med,2) sum(men.^2)/size(men,2) sum(mle.^2)/size(mle,2)];
%median:0.0518 mean:906.2220 mle:0.0415
%part c
clf
hold on
v = linspace(-1,1,1e4);
for col = 1:10
    l = 0;
    for n = 1:size(X,1)
        l = l + log(f(X(n,col),v));
    end
    plot(v,l)
end
%hold off
loglike = zeros(size(X,2),size(v,2));
for col = 1:size(X,2)
    for n = 1:size(X,1)
        loglike(col,:) = loglike(col,:) + log(f(X(n,col),v));
    end
end
average = zeros(size(v));
for i = 1:length(average)
    average(i) = mean(loglike(:,i));
end
plot(v,average,'--')
hold off
xlabel('v')
ylabel('log likelihood')
title('first 10 trials and average over all 1000')