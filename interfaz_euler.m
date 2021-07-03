tf = input('tiempo final, tf: ');
n = input('numero de pasos, n: ');
f = @(t,x) cos(t);
%condiciones iniciales
t0 = 0;
x0 = 0;
[t,x] = euler(f,t0,tf,x0,n);

hold on
plot(t,x,'b');
y=sin(t);
plot(t,y,'r');
xlabel('t');
ylabel('x');
grid on
legend('aproximada','exacta');
title('dx/dt=cos(t)')
hold off