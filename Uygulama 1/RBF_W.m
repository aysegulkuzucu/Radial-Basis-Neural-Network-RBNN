a2 = radbas(x-1.5);
a3 = radbas(x+2);
a4 = a + a2*1 + a3*0.5;
plot(x,a,'b-',x,a2,'b--',x,a3,'b--',x,a4,'m-')
title('Radyal Tabanlı Transfer Fonksiyonlarının Ağırlıklı Toplamı');
xlabel('Giris p');
ylabel('Cikis a');
