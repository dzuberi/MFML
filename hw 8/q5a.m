load('hw08p5a.mat');
f = @(x,v) 1 ./ (pi * (1 + (x-v).^2));
l = 0;
v = linspace(0,5,1e6);
for n = 1:length(x)
    l = l + log(f(x(n),v));
end
plot(v,l);
title('log likelihood over [0,5]')
xlabel('v')
ylabel('sum of l(v;xn)');
[val ind] = max(l);
max_v = v(ind);
%max_v = 3.3655 (this is nu)