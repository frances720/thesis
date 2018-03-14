dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 48e3;
T2 = 52e3;
E = 70e9;
v = 0.25;
rho_m = 3300;
rho_s = 2400;
rho_c = 2700;
rho_w = 1030;
rho_star = calcRhoStar(rho_c,rho_m,rho_s);

Lc = 550e3;
Lt = 250e3;

D1star = (T1./T2).^3;
D2 = calcD(T2,E,v);
alpha = calcAlpha(D2,rho_m,rho_s);
Lcstar = Lc/alpha;
Ltstar = Lt/alpha;

Dstar = computeDstar(xstar,D1star,Lcstar,Ltstar);

Wt = 300e3;
Wtstar = Wt/alpha;

H = zeros(size(xstar))';
H(xstar <= Wtstar) = 2e3;

w = solveW_dimOnVertical(dxstar,Dstar,rho_star,H);

thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar-Ltstar)).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar-Ltstar))).*((xstar-Lcstar+Ltstar).*(T2-T1)./Ltstar + T1);

isoratio = (rho_m - rho_c) ./ (rho_m - rho_w);
w_iso = isoratio .* (T2 - thickness);
plot(xstar*alpha/1e3,(-w-w_iso')/1e3)
hold on

%plot(xstar*alpha/1e3,-w_iso/1e3)
plot(xstar*alpha/1e3,-w/1e3)

D1 = calcD(T1,E,v);
alpha2 = calcAlpha(D1,rho_m,rho_s);

Wtstar2 = Wt/alpha2;

H2 = zeros(size(xstar))';
H2(xstar <= Wtstar2) = 2e3;
F2 = sum(H2);
Hstar2 = H2 ./ F2;
w02 = calcw0(rho_c,rho_m,rho_s,F2);
wstar2 = - solveW(dxstar,Dstar,Hstar2);
w2 = wstar2*w02;
hold on
plot(xstar*alpha2/1e3, w2/1e3, 'Color', [0.7,0.7,0.7], 'LineWidth', 2);
axis([250,650,-4.5,2.3])

% T = computeT(xstar,Lcstar,Ltstar, T1, T2);
% plot(xstar*alpha/1e3,-w/1e3,'k-', 'LineWidth', 2);
% hold on
%plot(xstar*alpha/1e3,-w/1e3-T'/1e3,'k-');