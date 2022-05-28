function v = restriction(u)
m = (length(u))/2;
for j = 1:m
if j < m
v(j,1) = 0.25*(u(2*j-1) + 2*u(2*j) + u(2*j+1));
else
v(j,1) = 0.25*(u(2*j-1) + 2*u(2*j));
end
end
end