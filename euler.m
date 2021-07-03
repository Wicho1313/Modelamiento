function [t,x] = euler(f,t0,tf,x0,n)
    h = (tf-t0)/n;
    t = t0:h:tf;
    x(1) = x0;
    for i=1:n
        x(i+1) = x(i)+f(t(i),x(i))*h;
    end
end