function v = Vcycle(v,v0,v1,f,stencil)

n = length(f)+1;

%step 1 relax
v = gs_rb(v, stencil, v0, v1, f);

if ~(length(v)<= 4 || length(f) <= 4) 
    %step 2.1 residual restriction
    r = findResidue(stencil, f, v, v0, v1);
    r2 = restriction(r);

    %step 2.2 zeros
    v2 = zeros(floor(n/2-1),1);

    %step 2.3 vcycle
    v2 = Vcycle(v2, v0, v1, r2, stencil/4);
    
    %step 3
     v = v + interpolation(0,0,v2);
     
     v = gs_rb(v, stencil, v0, v1, f);
else   
    %step 4
    for i = 1:10
        v = gs_rb(v, stencil, v0, v1, f);
    end
end
end