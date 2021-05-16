plot(X,T,'+');
xlabel('Giris');
 
X = -1:.01:1;
Y = net(X);
 
hold on;
plot(X,Y);
hold off;
legend({'Hedef','Cikis'})
