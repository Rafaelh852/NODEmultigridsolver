function [v] = NewtonsMethod(v,f)
   %f is a functional, v is the guessing vecotr, n is the number of
   %itterations to find a root
   % n = 3 or n = 4 is usualy enough to find the root for single guesses
    n = 1;
    m = length(v);
    h = 1/m;
    %v = mean(v);
    
    %makes sure not to hit a max or min. i.e fp(x) = 0
    eps = 0.001;
    
    for i = 1:n
        
        %aproximates the jacobian matrix
        fp = jaco(v,f,h);
         
%         if length(fp == 0)> 0
%             fp(fp == 0) = fp(fp==0) + eps;
%         end
        
        v = v - f(v)./fp;
    end
   
    % v length at this point is 1 but m retains the origional
    % reconstruct?
%     if m == 1
%         return 
%     else
      %v = min(v)*ones(m,1); 
%     end
end