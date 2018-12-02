%Problem 4 part a. Finds a lagrange polynomial to fit all 9 points.
load('nonuniform_samples.mat');
ts = 0:0.01:10;
f = ts .* 0;
%solve for pm functions and multiply by coefficients
for m = 1:10
    pm = ts .* 0 + 1;
    for k = 1:10
        if (k ~= m)
            pm = pm .* (ts - t(k)) ./ (t(m) - t(k));
        end
    end
    f = f + pm .* y(m);
end
plot(ts,f);
hold on;
scatter(t,y);
hold off;