clearvars;
fid = fopen('input.txt', 'r');
temp = textscan(fid, '%d %f %f');
fclose(fid);
x = double(temp{1});     %size
my = double(temp{2});    %mTime
iy = double(temp{3});    %iTime

figure;

n = 20;
p = polyfit(x, my, n);
x1 = linspace(min(x), max(x));
y1 = polyval(p, x1);

p = polyfit(x, iy, n);
x2 = linspace(min(x), max(x));
y2 = polyval(p, x2);

plot(x1, y1, x2, y2);

title("Merge and Insertion Sort Runtimes on Sorted Lists");
xlabel("Array Size");
ylabel("Runtime");
legend('Merge Sort', 'Insertion Sort', 'location', 'northwest');