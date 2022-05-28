function [v] = governing(v)

    n = length(v);
    h = 1/n;
    
    %chosen constant
    k = 1;
    m = 1;
    c0 = 1;
    
    %constants for calc
    c = 1/(c0^2);
    s1 = [1,-2,1];
    s2 = [0,1,-1];
    s3 = [0,1,0];
    

    for i = 2:n-1
        u = v(i-1:i+1);
        v(i) = -h*c*s1*u -k*h*h*c*s2*u - m*c*((s2*u)^3)- s3*u; 
    end
    
    
end