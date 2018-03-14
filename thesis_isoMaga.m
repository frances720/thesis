dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = [20e3,35e3];
T2 = 40e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2850;
rho_w = 1030;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

Lc = 200e3;
Lt = 130e3;

D2 = calcD(T2,E,v);
alpha = calcAlpha(D2,rho_m,rho_s);
Lcstar = Lc/alpha;
Ltstar = Lt/alpha;

Wt = 70e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar <= Wtstar) = 2e3;

isoratio = (rho_m - rho_c) ./ (rho_m - rho_w);

figure;
for i = 1:length(T1)
    D1star = (T1(i)./T2).^3;
    Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);
    w = -solveW_dimOnVertical(dxstar,Dstar,rho_star,H);

    thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar-Ltstar)).*T1(i) + ...
        ((xstar <= Lcstar) & (xstar >= (Lcstar-Ltstar))).*((xstar-Lcstar+Ltstar)...
        .*(T2-T1(i))./Ltstar + T1(i));

    Tthin = T2 - thickness;
    w_iso = isoratio .* Tthin;
    hold on
    plot(xstar*alpha/1e3,-w_iso/1e3)
    wtotal = w - w_iso';
    %plot(xstar*alpha/1e3,w_2040/1e3)
    plot(xstar*alpha/1e3,wtotal/1e3)
end
%axis([0,400,-5.2,2.1])
axis([0,400,-9,2.1])
%axis([0,450,-inf,inf]);
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)