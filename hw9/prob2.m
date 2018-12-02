Ds = [5 6 7 8 9 10];
avg_se = zeros(3,size(Ds,2));
for d = 1:length(Ds)
    D = Ds(d);
    N = 1e4;
    avg_se_mle = 0;
    avg_se_js = 0;
    avg_se_jsp = 0;
    for n = 1:N
        theta_0 = 2/sqrt(D)*ones(D,1);
        I = eye(D,D);
        ttl = 0;
        x = I*randn(D,1)+theta_0;
        theta_js = (1 - (D-2)/norm(x).^2).*x;
        theta_jsplus = max((1 - (D-2)/norm(x).^2),0).*x;
        %theta_jsplus = abs(1 - (D-2)/norm(x).^2).*x;
        theta_mle = x;
        avg_se_mle = avg_se_mle +norm(theta_mle - theta_0).^2;
        avg_se_js = avg_se_js + norm(theta_js - theta_0).^2;
        avg_se_jsp = avg_se_jsp + norm(theta_jsplus - theta_0).^2;
    end
    avg_se(1,d) = avg_se_mle/N;
    avg_se(2,d) = avg_se_js/N;
    avg_se(3,d) = avg_se_jsp/N;
end



%Results
%D         5         6         7         8         9         10
%MLE:    4.9578    5.9990    7.0163    8.0263    8.9624   10.0010
%Notes:  5         6         7         8         9        10
%JS:     3.4428    3.7152    3.9266    4.1632    4.2582    4.3381 
%taking 2e6 draws of X, E[1/||X||^2] = 0.1701, 0.1420, 0.1224, 0.1082, 
%                                      0.0969, 0.0879 for each value of D
%Notes:  3.4691    3.7280    3.9400    4.1048    4.2519    4.3744    
%JS+:    3.2184    3.4520    3.6366    3.7812    3.8805    3.9661

%the values from the experiment closely match the expectations from the
%notes