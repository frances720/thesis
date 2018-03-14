dxstar = 0.01;
xstar = 0:dxstar:20;

T1 = 20e3;
T2 = 40e3;

rho_m = 3300;
rho_s = 2400;
rho_c = 2850;
rho_w = 1030;

Lc = 200e3;
Lt = 130e3;

alpha = calcAlpha(D2,rho_m,rho_s);
Lcstar = Lc/alpha;
Ltstar = Lt/alpha;


thickness = (xstar > Lcstar).*T2 + (xstar < (Lcstar-Ltstar)).*T1 + ...
    ((xstar <= Lcstar) & (xstar >= (Lcstar-Ltstar))).*((xstar-Lcstar+Ltstar).*(T2-T1)./Ltstar + T1);

% plot(thickess/2)
% hold on
% plot(-thickess/2)
% axis([0,400,-3*1e4,3*1e4])

%isoratio = (rho_m - rho_c) ./ (rho_m - rho_w);
%w_iso = isoratio .* (T2 - thickness);

% plot(w_iso+thickness/2)
% hold on
% plot(w_iso-thickness/2)
plot(xstar*alpha/1e3, thickness/2e3)
hold on
plot(xstar*alpha/1e3, -thickness/2e3)
axis([0,400,-30,30])
xt = get(gca, 'XTick');
set(gca, 'FontSize', 14)
%start_datum = -T2 + thickness;
%plot(start_datum)
%hold on
%plot(-w_iso)