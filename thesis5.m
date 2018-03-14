dxstar = 0.01;
xstar = 0:dxstar:20;

D1star = 0.1;
Wtstar = logspace(log10(dxstar),1,100);
WtstarFin = snapWtstar2Grid(dxstar,Wtstar);
%Dstar = ones(size(xstar))';

Lcstar = 20;
Ltstar = 20;

%for j = 1:length(Wtstar)

depth = zeros(size(WtstarFin));
width = zeros(size(WtstarFin));

for i = 1:length(WtstarFin)
    Hstar = zeros(size(xstar))';
    Hstar(xstar < WtstarFin(i)) = 1;
    F = sum(Hstar)*dxstar;
    Hstar = Hstar ./ F;
    test = sum(Hstar);
    
    Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
    wstar = solveW(dxstar,Dstar,Hstar);
    %plot(xstar,-wstar);
    %hold on
    %plot(xstar,Hstar,'k:')
    [depth(i),width(i)] = findDepthWidthofBasin(xstar,wstar,WtstarFin(i));
end

plot(WtstarFin,-depth)
%loglog(WtstarFin,-depth)
%loglog(WtstarFin,width)
hold on
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)
% end
% grid on
axis([0.01,10,-inf,inf])
% title('Basin width and width of fold-and-thrust belt')
% % title('Basin width in relation to thinning ratio as thrust loading progresses')
% xlabel('Normalized width of load Wt* (in terms of alpha)');
%ylabel('Normalized basin depth');
% ylabel('Normalized basin width (in terms of alpha)');
% legend(sprintf('Wt* = %0.2f',Wtstar(1)), sprintf('Wt* = %0.2f',Wtstar(2)),...
%     sprintf('Wt* = %0.2f',Wtstar(3)), sprintf('Wt* = %0.2f',Wtstar(4)),...
%     sprintf('Wt* = %0.2f',Wtstar(5)), sprintf('Wt* = %0.2f',Wtstar(6)),'Location','northwest');