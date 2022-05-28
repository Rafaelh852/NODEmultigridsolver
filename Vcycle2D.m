function Vcycle2D
    n = 128;
    h = 1/n;
    stencil = [0, -1/h^2, 0; -1/h^2, 4/h^2, -1/h^2; 0, -1/h^2, 0];
%     stencil = [-1/3/h^2, -1/3/h^2, -1/3/h^2; -1/3/h^2, 8/3/h^2, -1/3/h^2; -1/3/h^2, -1/3/h^2, -1/3/h^2];
    [x,y]=meshgrid(linspace(h,1-h,n-1),linspace(h,1-h,n-1));
    u = sin(x*pi).*sin(y*pi);%x.*(1-x).*y.*(1-y);
    f = rand(n-1,n-1)*pi^2*2.*sin(3*x*pi).*sin(5*y*pi);%2*y.*(1-y)+2*x.*(1-x);
    v = f*0;
    for i = 1:20
        v = vcycle2D(v,f);
        res = findResidue2D(stencil, f, v);
        res_norm(i) = norm(res(:),'inf');
        fprintf('step %d, residue: %g, error: %g\n', i, res_norm(i), norm(v(:)-u(:),'inf'));
    end
    semilogy(1:20,res_norm);
    a = polyfit(1:12,log(res_norm(1:12))/log(10),1);
    rho = 10^a(1);
    fprintf('the amplification factor is %g\n',rho);
    figure;mesh(x,y,findResidue2D(stencil, f, v));
    figure;mesh(x,y,v);
%     figure;mesh(x,y,u-v);
end

function v = vcycle2D(v, f)

n = size(v,1);
h = 1/(n+1);
stencil = [0, -1/h^2, 0; -1/h^2, 4/h^2, -1/h^2; 0, -1/h^2, 0];
% stencil = [-1/3/h^2, -1/3/h^2, -1/3/h^2; -1/3/h^2, 8/3/h^2, -1/3/h^2; -1/3/h^2, -1/3/h^2, -1/3/h^2];

for i = 1:1
    v = gs_dir2D(v, stencil, f);
end

if (n<=4)
    for i = 1:1000 
        v = gs_dir2D(v, stencil, f);
    end
else
    f2 = restriction2D(findResidue2D(stencil, f, v));
    v2 = 0*f2;
    for i = 1:1
        v2 = vcycle2D(v2, f2);  
    end
    v  = v+interpolation2D(v2);
    for i = 1:1
        v = gs_dir2D(v, stencil, f);
    end
end
end

function v = gs_dir2D(v, stencil, f)
    n = size(v);
    v = [zeros(1, n(2)+2);zeros(n(1),1), v, zeros(n(1),1);zeros(1, n(2)+2)];
    for i = 1:n(1)
        for j = 1:n(2)
            v(i+1, j+1) = stencil(2,2)\(f(i,j)-sum(sum(stencil.*v(i:i+2,j:j+2))))+v(i+1, j+1);
        end
    end
    v = v(2:end-1,2:end-1);
end

function r = findResidue2D(stencil, f, v)
    n = size(v);
    v = [zeros(1, n(2)+2);zeros(n(1),1), v, zeros(n(1),1);zeros(1, n(2)+2)];
    r = zeros(n);
    for i = 1:n(1)
        for j = 1:n(2)
            r(i,j) = f(i,j)-sum(sum(stencil.*v(i:i+2,j:j+2)));
        end
    end
end

function R = restriction2D(r)
    n = size(r,1);
    N = (n+1)/2-1;
    stencil = [1/16, 1/8, 1/16; 1/8, 1/4, 1/8; 1/16, 1/8, 1/16];
    for i = 1:N
        for j = 1:N
            R(i,j) = sum(sum(stencil.*r((2*i-1):(2*i+1),(2*j-1):(2*j+1))));
%             R(i,j) = r(2*i,2*j);
        end
    end
end

function r = interpolation2D(R)
    N = size(R,1);
    n = (N+1)*2-1;
    r = zeros(n,n);
    for i = 1:N
        for j = 1:N
            r(i*2,j*2) = R(i,j);
            r(i*2-1,j*2-1) = r(i*2-1,j*2-1)+R(i,j)/4;
            r(i*2+1,j*2-1) = r(i*2+1,j*2-1)+R(i,j)/4;
            r(i*2-1,j*2+1) = r(i*2-1,j*2+1)+R(i,j)/4;
            r(i*2+1,j*2+1) = r(i*2+1,j*2+1)+R(i,j)/4;
            r(i*2-1,j*2) = r(i*2-1,j*2)+R(i,j)/2;
            r(i*2+1,j*2) = r(i*2+1,j*2)+R(i,j)/2;
            r(i*2,j*2-1) = r(i*2,j*2-1)+R(i,j)/2;
            r(i*2,j*2+1) = r(i*2,j*2+1)+R(i,j)/2;
        end
    end
end
