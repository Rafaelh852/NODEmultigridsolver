function u = interpolation(v0,v1,v)
%course to fine grid i.e 2h to h
m = length(v);
u(1,1) = .5*(v(1) + v0);
for j = 1:m
if j < m
u(2*j,1) = v(j);
u(2*j+1,1) = .5*(v(j)+v(j+1));
else
u(2*j,1) = v(j);
u(2*j+1,1) = .5*(v(j)+v1);
end
end

% def interpolation(v):
%     ''' takes vector from 2h to h 
%         from a coarse to a finer grid
%     
%     '''
%     u = np.zeros(2*len(v)+2)
%     
%     n = 1
%     
%     for val in v:
%         u[2*n-2] += 0.5*val
%         u[2*n-1] += val
%         u[2*n] += 0.5*val
%         n += 1
%     return u[:-1]

end