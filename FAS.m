function [v] = FAS(v,f, A)
    
    r = f-A(v);
    
    r2 = restriction(r);
    v2 = restriction(v);
    
    f2 = A(v2);
    
    u2 = NewtonsMethod(f2 + r2, A);
    
    e2 = u2 - v2;
    i = interpolate(e2);
    v = v + i;

    
%     def FAS(v,fnc,fnc_prime):
%     # **outline, not final form**
%     # A(u) = f and A(v) ~ f
%     
%     r2 = restriction(r)
%     v2 = restriction(v)
%     
%     #f2 = A2(v2)
%     #f2 = A(v2)
%     u2 = NM(fu(v2) + r2,fu,fup)
%     
%     e2 = u2 - v2
%     v = v + interpolation(e2)
%     
%     return v
%     
%     def NM(v,fn,fnp):
%         v =  v - fn(v)/fnp(v) 
%     return v
    
end