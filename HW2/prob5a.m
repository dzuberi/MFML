x1 = -1.014:0.01:1.014;
hold on
grid on
plot(x1,1/37.*(-35.*x1 + 2.*sqrt(37 - 36.*x1.^2)),'k-')
plot(x1,1/37.*(-35.*x1 - 2.*sqrt(37 - 36.*x1.^2)),'k-')
hold off
title("Problem 5a Unit Ball")
xlabel("x1")
ylabel("x2")
xlim([-1.5 1.5]);
ylim([-1.2 1.2]);