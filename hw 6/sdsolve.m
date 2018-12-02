function [x,iter] = sdsolve(H,b,tol,maxiter)
x = zeros(size(H,2),1);
iter = 0;
norm_b = sqrt(sum(b.^2));
r = b - H*x;
while(true)
    alpha = r'*r / (d'*H*d); %a_k = r_k'r_k / r_k'Hr_k
    if((iter >= maxiter) && (maxiter ~= 0)) %pass in 0 for maxiter if don't want iteration limit
        break;
    end
    norm_r = sqrt(sum(r.^2));
    if((norm_r / norm_b) < tol)
        break;
    end
    x = x + alpha*r; %x_k+1 = x_k + a_k*r_k
    r = b - H*x; %r = b - H*x_k+1
    iter = iter+1;
end

end

