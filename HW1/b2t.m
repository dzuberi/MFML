function [b2] = b2t(t)
%B2T Simply solves for the value of b2 at a given t to make code cleaner.
     if t < -1.5
         b2 = 0;
     elseif t < -0.5
         b2 = (t +1.5)^2 / 2;
     elseif t < 0.5
         b2 = -(t)^2 + 0.75;
     elseif (t) < 1.5
         b2 = (t-1.5)^2 / 2;
     else
         b2 = 0;
     end
end

