dxstar = 0.01;
xstar = 0:dxstar:20;

%D1star = logspace(-2,0,4);
D1star = 0.015625;

Wtstar = linspace(8.8,10,5);
%Wtstar = 10;
Lcstar = 10.5;
Ltstar = 1;

Hstar = zeros(size(xstar))';
% Hstar(xstar < Wtstar) = 1;
% Hstar = Hstar ./ sum(Hstar);

figure

for j = 1:length(Wtstar)
    Hstar(xstar < Wtstar(j)) = 1;
    for i = 1:length(D1star)
        Dstar = computeDstar(xstar,D1star(i),Lcstar,Ltstar);
        %Dstar = D1star(i).*ones(size(xstar))';
        wstar = - solveW(dxstar,Dstar,Hstar);
        tmp = zeros(2001,1);
        rangePos = (Wtstar(j))*100 + 1;
        restPos = 2002 - rangePos;
        tmp(1:restPos) = wstar(rangePos:end);
        plot(xstar,tmp, 'LineWidth', 2);
        hold on
    end
end

axis([-0.5,2.5,-1,0.1]);
%axis([Wtstar-0.5,Wtstar+2.5,-1.1,0.2]);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)
