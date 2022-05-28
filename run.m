clear
%v = [0:.1:1];
%v0 = v*0;
%c =1;
%f = @(x)((x.^2+3*x).*exp(x) + c*(x.^4 - 2*x.^2 + x).*exp(2*x));
%fp = @(x)(exp(x).*(x.^2+5*x+3)+c*exp(2*x).*(2*x.^4+4*x.^3-4*x.^2-2*x+1));
%u = @(x)(exp(x).*(x-x.^2));

%k = FAS(v0,f(v),fp(v),A);
 
n = 128;
h = 1/n; 
x = linspace(0,1,n)';


f = @(y)(y.*(1-y));
%fp = @(y)(2*y);
c = (exp(1) - 1)/(exp(2)-1);

g=@(y)((1-c)*exp(-y) + c*exp(y)-y.*y + y - 1);

v = 0*x;

% need A, for function acting on v
% need Aprime for newtons method
% f values 

%u = jaco(x,f,1/n);
A = @(y)(governing(y));
G = @(y)(G1(y));

v2 = FAS(v,f(x),G);


plot(x,v2)


function [v] = G1(v)
    n = length(v);
    h = 1/n;
    k = 1;
    s1 =  [-1, 2, -1];
    s2 = [0, 1 , 0];
    
    for i = 2:n-1
       u = v(i-1:i+1,1);
       v(i) = -((1/h)^2)*s1*u/k;
    end
end
