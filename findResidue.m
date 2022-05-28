function r = findResidue(stencil, f, v, v0, v1)
% This function is implemented by Paul Sun on 9/28/2021
% The header is 
%                        function r = findResidue(stencil, f, v, v0, v1)

r = f - stencil(1)*[v0;v(1:end-1)] - stencil(2)*v - stencil(3)*[v(2:end);v1];

% n = length(f);
% r(1,1) = f(1) - stencil(1)*v0-stencil(2)*v(1)-stencil(3)*v(2);
% for i = 2:n-1
%     r(i,1) = f(i) - stencil(1)*v(i-1)-stencil(2)*v(i)-stencil(3)*v(i+1);
% end
% r(n,1) = f(n) - stencil(1)*v(n-1)-stencil(2)*v(n)-stencil(3)*v1;