x = -1:0.01:1;
y = [1 1];
x1 = [x; 1-abs(x)];
x2 = [x; abs(x)-1];
max = 0;
maxx = 0;
maxy = 0;
for i = 1:length(x1)
    temp = y(1)*x1(1,i) + y(2)*x1(2,i);
    if temp >= max
        max = temp;
        maxx = x1(1,i);
        maxy = x1(2,i);
    end
    temp = y(1)*x2(1,i) + y(2)*x2(2,i);
    if temp >= max
        max = temp;
        maxx = x2(1,i);
        maxy = x2(2,i);
    end
end