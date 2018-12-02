Na = 30; Nb = 18; Nc = 4; N=Na+Nb+Nc;
const = gamma(N+3)/(gamma(Na+1)*gamma(Nb+1)*gamma(N-Na-Nb+1));
theta_a = linspace(0,1,1e2);
theta_b = linspace(0,1,1e2);
[THETA_A,THETA_B] = meshgrid(theta_a,theta_b);
f_theta = const.*THETA_A.^Na.*THETA_B.^Nb.*(1-THETA_A-THETA_B).^(N-Na-Nb);
%contour(THETA_A,THETA_B,f_theta)
mask = 1-THETA_A < THETA_B;
f_theta(mask) = 0;
colormap winter
surf(THETA_A,THETA_B,f_theta);
shading flat
%view(30,0)
colormap summer
title('posterior density 3b')
xlabel('theta_a')
ylabel('theta_b')
zlabel('density')