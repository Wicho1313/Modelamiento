function epidemia 
beta=0.03;%tiempo de interaccion entre los infectados (tasa de contagio)
gamma=2;%cantidad o tiempo de infectados
x0=100;%Población inicial (No se cambia)
y0=20; % infectados
z0=10; % recobrados
tmax=6; % 6 semanas
[t,x]=ode45(@epi, [0 tmax], [x0,y0,z0]);
%paquetes para resolver sistemas de ecuaciones diferenciales ordinarios

subplot(3,1,1), plot(t,x(:,1)),title('Susceptibles');
subplot(3,1,2), plot(t,x(:,2)),title('Infectados');
subplot(3,1,3), plot(t,x(:,3)),title('Recobrados');

    function dx=epi(~,x)
        dx=zeros(3,1);
        dx(1)=-beta*x(1)*x(2);
        dx(2)=+beta*x(1)*x(2)-gamma*x(2);
        dx(3)=+gamma*x(2);
    end
end


