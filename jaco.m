function [v] = jaco(v,f,h)
    %pass in main function not prime function
    v = (f(v + h)-f(v-h))/(2*h);
end