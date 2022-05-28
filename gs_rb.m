function v = gs_rb(v, stencil, v0, v1, f)

n = length(f)-1;
for i = 2:2:n-1
    v(i) = (f(i)-stencil(1)*v(i-1)-stencil(3)*v(i+1))/stencil(2);
end

v(1) = (f(1)-stencil(1)*v0-stencil(3)*v(2))/stencil(2);
for i = 3:2:n-1
v(i) = (f(i)-stencil(1)*v(i-1)-stencil(3)*v(i+1))/stencil(2);
end
v(n) = (f(n)-stencil(1)*v(n-1)-stencil(3)*v1)/stencil(2);
