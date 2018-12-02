%problem 4 and 5
load('hw09p5data.mat')
sigma = [3 -6 16 -6; 
         -6 18 -6 8];
sigma_1 = sigma(:,1:2); sigma_2 = sigma(:,3:4);
mu = [0 1; 
      1 0];
mu_1 = mu(:,1); mu_2 = mu(:,2);
%Problem 4
fx = @(x1,x2,y) 1/(2*pi*sqrt(det(sigma(:,2*(y-1)+1:2*y)))) .*exp(-1/2*...
    ([x1;x2] - mu(:,y))'*inv(sigma(:,2*(y-1)+1:2*y))*([x1;x2]-mu(:,y)));
x_1 = linspace(-20,20,100);
x_2 = linspace(-20,20,100);
[X_1,X_2] = meshgrid(x_1,x_2);
fx_1 = zeros(size(X_1));
fx_2 = zeros(size(X_1));
for i = 1:size(X_1,1)
    for j = 1:size(X_1,2)
        fx_1(i,j)=fx(X_1(i,j),X_2(i,j),1);
        fx_2(i,j)=fx(X_1(i,j),X_2(i,j),2);
    end
end
regions = double(fx_1 - fx_2 > 0);
surf(X_1,X_2,regions)
shading interp
colormap summer
view(0,90)
title('bayes classifier (yellow is X1)')
xlabel('x1')
ylabel('x2')
%problem 5a
knn = zeros(size(X_1));
for i = 1:size(X_1,1)
    for j = 1:size(X_1,2)
        x = [X_1(i,j);X_2(i,j)];
        min_1 = -1;
        min_2 = -1;
        for k = 1:size(X1,2)
            x1_s = X1(:,k);
            x2_s = X2(:,k);
            if norm(x1_s - x) < min_1 || min_1 < 0
                min_1 = norm(x1_s - x);
            end
            if norm(x2_s - x) < min_2 || min_2 < 0
                min_2 = norm(x2_s - x);
            end
        end
        if min_1 < min_2
            knn(i,j) = 1;
        end
    end
end
figure
surf(X_1,X_2,knn)
view(0,90)
shading interp
colormap summer
title('KNN classifier (yellow is X1)')
xlabel('x1')
ylabel('x2')
%problem 5b
Q_1 = chol(sigma_1,'lower');
Q_2 = chol(sigma_2,'lower');
class = 0;
prediction_b = 0;
prediction_k = 0;
rv = [0;0];
right_bayes = 0;
right_knn = 0;
num_rv = 5e3;
for i = 1:num_rv
    if mod(i,2)
        rv = mu_1 + Q_1*randn(2,1);
        class = 1;
    else
        rv = mu_2 + Q_2*randn(2,1);
        class = 2;
    end
    %bayes
    if fx(rv(1),rv(2),1) > fx(rv(1),rv(2),2)
        prediction_b = 1;
    else
        prediction_b = 2;
    end
    %knn
    min_1 = -1;
    min_2 = -1;
    for k = 1:size(X1,2)
        x1_s = X1(:,k);
        x2_s = X2(:,k);
        if norm(x1_s - rv) < min_1 || min_1 < 0
            min_1 = norm(x1_s - rv);
        end
        if norm(x2_s - rv) < min_2 || min_2 < 0
            min_2 = norm(x2_s - rv);
        end
    end
    if min_1 < min_2
        prediction_k = 1;
    else
        prediction_k = 2;
    end
    if prediction_k == class
        right_knn = right_knn+1;
    end
    if prediction_b == class
        right_bayes = right_bayes+1;
    end
end
R_k = (num_rv - right_knn) / num_rv;
R_b = (num_rv - right_bayes) / num_rv;
fprintf("R(bayes) = %0.2f,R(knn) = %0.2f\n",R_b,R_k)
%Output:
%R(bayes) = 0.21,R(knn) = 0.28
%
%Risk of KNN is obviously greater, but only by 33%, which is good for 100
%pts