function [u] = interpolate(v)
    
    u = zeros(2*length(v)+2,1);
    n = 1;
    
    for val = v'
       u(2*n-1,1) =  u(2*n-1,1) + 0.5*val;
       u(2*n,1) =  u(2*n,1) + val;
       u(2*n+1,1) =  u(2*n+1,1) + 0.5*val;
       n = n + 1;
    end
    u = u(1:end-2,1);
end
