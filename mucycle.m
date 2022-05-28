function v = mucycle(v,v0,v1,f,stencil)

M = 6;

n = length(f)+1;

%step 1 relax
v = gs_rb(v, stencil, v0, v1, f);

if ~(length(v)<= 4 || length(f) <= 4) 
    %step 2.1 residual restriction
    r = findResidue(stencil, f, v, v0, v1);
    r2 = restriction(r);

    %step 2.2 zeros
    v2 = zeros(floor(n/2-1),1);
    
   
    for i= 1:M
       %step 2.3 vcycle
       v2 = mucycle(v2, v0, v1, r2, stencil/4);
        
    end
    
    %step 3
     v = v + interpolation(0,0,v2);
     
     v = gs_rb(v, stencil, v0, v1, f);
else   
    %step 4
    for i = 1:100
        v = gs_rb(v, stencil, v0, v1, f);
    end
end




end