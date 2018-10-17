close all, clear all
outlierIdx = [47,48,49,100,20];
x = -2*pi:0.1:2*pi;
A = sin(x);
A(outlierIdx) = 10*floor(rand(size(outlierIdx)));

figure(1);
plot(x,A); hold on;
plot(x(outlierIdx),A(outlierIdx),'rx');
title('Data with an outlier');

A = hampelfilter(A,3,1);
plot(x,A,'-k'); hold on;

legend('Data','Outlier','Hampel-filtered')
