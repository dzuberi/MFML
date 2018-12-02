%problem 4 part b, uses second order B spline to fit all points exactly.
load('nonuniform_samples.mat');
ts = 0:0.01:10;
f = ts .* 0;
A = [];
%populate matrix to reduce to find alphas
for m = 1:10
    a = [1:10]*0;
    for i = 1:10
        a(i) = b2t(t(m) - (i - 1));
    end
    A = [A; a];
end
%solve for alphas
alphas = inv(A) * y;
%create splines
for k = 0:9
    b2 = 0.*ts;
    for i=1:length(b2)
         if (ts(i)-k) < -1.5
             b2(i) = 0;
         elseif (ts(i)-k) < -0.5
             b2(i) = (ts(i) - k +1.5)^2 / 2;
         elseif (ts(i)-k) < 0.5
             b2(i) = -(ts(i) - k)^2 + 0.75;
         elseif (ts(i)-k) < 1.5
             b2(i) = (ts(i) - k - 1.5)^2 / 2;
         else
             b2(i) = 0;
         end
    end 
    f = f + b2 .* alphas(k+1);
end
plot(ts,f)
hold on
scatter(t,y)
hold off