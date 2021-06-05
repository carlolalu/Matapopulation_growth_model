clear all

global a b m1 m2
%Takefumi Nakazawa
%https://www.nature.com/articles/srep07871
% m1=input('probability of extinction of youngs = m1 = ');
% b=input('production of propagule for youngs = b = ');
% X1=input('initial portion of habitat of the territory populated by youngs = X(0) = ');
% m2=input('probability of extinction of adults = m2 =');
% a=input('production of propagule for adults = a = ');
% Y1=input('initial portion of habitat of the territory populated by adults = Y(0) = ');



%input data
m1=0.21;
b=0.11;
X1=input('initial portion of habitat of the territory populated by youngs = X(0) = ');
m2=0.11;
a=0.27;
Y1=input('initial portion of habitat of the territory populated by adults = Y(0) = ');

lastx=0
lasty=0
tmax=50

% loop
ans=1;
while ans==1

	clear t x y 
    n=1;
	t(1)=0;
	x(1)=X1;
	y(1)=Y1;
    
    
	%input data
	h=input('h step = ');
    
    %desirable quantity: 0<h<1
    
    
	% Explicit Runge Kutta Method with 4 levels
    % u(m+1) = u(m) + h*sum(from 1 to 4)(b(i)*K(i))
    % K(i) = f(t(m) + h*c(i) , u(n) + h*sum(from 1 to 4)(a(i,j)*K(j))

    
    
	while t(n)<tmax
		k1x=X(t(n),x(n),y(n));
		k1y=Y(t(n),x(n),y(n));
		k2x=X(t(n)+h/2,x(n)+h/2*k1x,y(n)+h/2*k1y);
		k2y=Y(t(n)+h/2,x(n)+h/2*k1x,y(n)+h/2*k1y);
		k3x=X(t(n)+h/2,x(n)+h/2*k2x,y(n)+h/2*k2y);
		k3y=Y(t(n)+h/2,x(n)+h/2*k2x,y(n)+h/2*k2y);
		k4x=X(t(n)+h,x(n)+h*k3x,y(n)+h*k3y);
		k4y=Y(t(n)+h,x(n)+h*k3x,y(n)+h*k3y);
		x(n+1)=x(n)+h/6*(k1x+2*k2x+2*k3x+k4x);
		y(n+1)=y(n)+h/6*(k1y+2*k2y+2*k3y+k4y);
		t(n+1)=t(n)+h;
        n=n+1;
    end
    
    errx=abs(lastx-x(n))
    erry=abs(lasty-y(n))
    
    lastx=x(n)
    lasty=y(n)
    
    equilibrium=[(a*b-m1*m2)/(b*m1+a*b) , (a*b-m1*m2)/(a*m2+a*b)]
    
    %output
    disp(['number N of steps = ', int2str(n-1)])
    disp(['[t(M), x(N) , y(N)] = ','[',num2str(t(n),5),', ',num2str(x(n),15),num2str(y(n),15),']'])
    disp(['non-trivial equilibrium:', num2str(equilibrium(1)),',',num2str(equilibrium(2))])
    disp(['err |last x(n)-x(n)| = ', num2str(errx,15)])
    disp(['err |last y(n)-y(n)| = ', num2str(erry,15)])
    
    % graphs
    f1= figure;
    
    nexttile
	plot([1:n], x)
    hold on
    plot([1:n], y)
    hold on
    plot([1:n], [0]*n)
    hold off
    title('Evolution in time')
    
    nexttile
    plot(x,y)
    title('xy graph')
    
% 	% calcolo di x(tt)
% 	xx=x(n-1)+th*h*xp(n-1)+h^2*th^2*((th^2/3-th+1)/2*k1x+(-th/2+1)*th/3*(k2x+k3x)+(th-1)*th/6*k4x);
% 
% 	% output
% 	disp(['numero N di passi effettuati = ', int2str(n-1)])
% 	disp(['[t(N-1), x(N-1), z(N-1)] = ','[',num2str(t(n-1),5),', ',num2str(x(n-1),15),', ',num2str(z(n-1),15),']'])
% 	disp(['[t(N), x(N), z(N)] = ','[',num2str(t(n),5),', ',num2str(x(n),15),', ',num2str(z(n),15),']'])
% 	disp(['[tt, x(tt)] = ','[',num2str(tt,15),', ',num2str(xx,15),']']) 
    
	%dialogue with the user
	ans=2;
	while (ans~=1 && ans~=0)
		ans=input('another h? (YES = 1 e NO = 0) ');
	end
end
close all