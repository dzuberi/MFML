function [x,iter] = cgsolve(H,b,tol,maxiter)
x = zeros(size(H,2),1);
iter = 0;
norm_b = sqrt(sum(b.^2));
r = b - H*x;
d = r;
B = 0;
while(true)
    a = r'*r / (d'*H*d); %a_k = r_k'r_k / r_k'Hr_k
    if((iter >= maxiter) && (maxiter ~= 0)) %pass in 0 for maxiter if don't want iteration limit
        break;
    end
    norm_r = sqrt(sum(r.^2));
    if((norm_r / norm_b) < tol)
        break;
    end
    x = x + a*d; %x_k+1 = x_k + a_k*r_k
    r_old = r;
    r = r - a*H*d;
    B = r'*r/(r_old'*r_old);
    d = r + B*d;
    iter = iter+1;
end
%using the data set the result is 40 iterations
end

