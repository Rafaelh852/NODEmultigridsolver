function v = FMG(v,v0,v1,f,stencil)

n = length(f)+1;

if n <= 4 
     %step 4
    v = zeros(floor(n/2+1),1);
    for i = 1:1
        v = Vcycle(v,v0,v1,f,stencil);
    end
     
else   
      %step 1.1 residual restriction
     f2 = restriction(f);
     
     %step 1.2 recursive call
     v2 = FMG(v, v0, v1, f2, stencil/4);
    
     %step 2 correction 
     v = interpolation(0,0,v2);
     
     v = Vcycle(v,v0,v1,f,stencil);
   
end

end