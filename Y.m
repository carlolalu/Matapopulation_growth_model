function y = Y(t, x, y)
global a b m1 m2
%Pa Growth of the living fraction of the territory
y=b*x*(1-y)-m2*y;