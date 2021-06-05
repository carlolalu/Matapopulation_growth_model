function x = X(t, x, y)
global a b m1 m2
%Pj Growth of the living fraction of the territory
x=a*y*(1-x)-m1*x;