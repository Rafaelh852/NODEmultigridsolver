clear

n = 128*2; 
x = linspace(0,1,n+1)';
x = x(2:end-1);
v = x;

%equation parameters
k = 1;
m = 1;
s = 1;

% end points
c =0;


%itterations
b= 5;

h = 1/n;
hh = 1/(h^2);

%j stencil 1
j1 = @(x,y)(hh);

%j stencil 2
j2 = @(x,y)(-2*hh - k/h -(3*m/(h^3))*((x-y)^2)+ s^2);

%j stencil 3
j3 = @(x,y)(hh + k/h + (3*m/(h^3))*((x-y)^2));

p = length(x);
 
 
 i = 1;
%for i = 1:p-1
    stencil(i,1:3) = [j1(v(i+1),v(i)),j2(v(i+1),v(i)),j3(v(i+1),v(i))];
%end
 %stencil(p,1:3) =   stencil(p-1,1:3);
% constructing A
 A = diag(stencil(1:end-1,1),-1)+ diag(stencil(:,2)) + diag(stencil(1:end-1,3),1);


%constructing f
for i  = 2:length(x)-1
    f(i,1) = hh*(v(i+1)-2*v(i) + v(i-1))...
        + (k/h)*(v(i+1)-v(i))...
        + (m/(h^3))*((v(i+1) - v(i))^3)...
        +  s*s*v(i);
end
f(n-1,1) = 0;

%initial guess
v = 0.00*f;


for j = 1:b
    %v = v +  mucycle(v,c,c,f,stencil);
    v = v - A\f;
    
     i = 1;
    for i = 1:p-1
        stencil(i,1:3) = [j1(v(i+1),v(i)),j2(v(i+1),v(i)),j3(v(i+1),v(i))];
    end
    stencil(p,1:3) =   stencil(p-1,1:3);
    % constructing A
    A = diag(stencil(1:end-1,1),-1)+ diag(stencil(:,2)) + diag(stencil(1:end-1,3),1);

    %constructing f
    for i  = 2:length(x)-1
        f(i,1) = hh*(v(i+1)-2*v(i) + v(i-1))...
            + (k/h)*(v(i+1)-v(i))...
            + (m/(h^3))*((v(i+1) - v(i))^3)...
            +  s*s*v(i);
    end
    f(n-1,1) = 0;
    
    residue(j,1) = norm(f,2)*sqrt(h);
    %error(j,1) = norm(trueSol-v,2)*sqrt(h);
end

step = (1:b)';
NetwonMGtable = table(step,residue)
plot(x,v)