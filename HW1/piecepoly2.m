function [f] = piecepoly2(t,alpha)
%PIECEPOLY2 plots 4th order b splines given t and alphas
f = 0.*t;
for k=0:4
    b2 = 0.*t;
    for i=1:length(b2)
         if (t(i)-k) < -1.5
             b2(i) = 0;
         elseif (t(i)-k) < -0.5
             b2(i) = (t(i) - k +1.5)^2 / 2;
         elseif (t(i)-k) < 0.5
             b2(i) = -(t(i) - k)^2 + 0.75;
         elseif (t(i)-k) < 1.5
             b2(i) = (t(i) - k - 1.5)^2 / 2;
         else
             b2(i) = 0;
         end
    end
    
    f = f + b2 .* alpha(k+1);
end
plot(t,f);
end

