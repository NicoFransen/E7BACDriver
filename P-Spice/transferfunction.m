s = tf('s');

fBW = 4410;

Nps = 1;
Rout = 8.4;
Rcs = 0.167;
Acs = 1.65;
D = 0.447;
tL = 1.374;
M = 0.808;

Cz = 10*10^(-9);
Rz = 36083;
RFB2 = 1000;
CFB = 9.021*10^(-9);
R1 = 18000;
R2 = 2400;

R8 = 7517;
C9 = 40.07*10^(-9);
C10 = 1.38*10^(-9);

Rpar = 2200;
Gain = R8/Rpar;

wzero = 1 / (2*pi*R8*C9);
wpole = 1 / (2*pi*R8*((C9*C10)/(C9+C10)));

G0 = ((Rout*Nps)/(Rcs*Acs))*(1/(((1-D)^2/tL) + (2*M)+1));
%Gs = ((1+s*Cz*Rz)/(s*Cz))*(R1/R2)*(1/(s*CFB*RFB2+1));
%Gs1 = Gain * ((1+s/(fBW/2))/(1+s/(fBW*2)));
%Gs2 = 2.839*((1+s/(4000))/(1+s/(3000)));
%Gs3 = 5 * ((1+s/(700))/(1+s/(1700)));

wesr = 189470;
wrhpz = 15851;

wp1 = 132.807;
wp2 = 50000;

Gcomp1 = Gain * (1+s/wpole)/(1+s/wzero);
Gcomp2 = Gain * (1+s/wzero)/(1+s/wpole);

sys = G0 * (((1+s/wesr)*(1-s/wrhpz))/(1+s/wp1)) * (1/(1+(s/wp2)+(s^2/wp2^2)));
sys1 = sys * (1 / (1+s/314)) * 4.45;
sys2 = sys * Gcomp1;
sys3 = sys * Gcomp2;


figure(1)
bode(sys)
margin(sys)
 
figure(2)
bode(sys1)
margin(sys1)

figure(3)
bode(sys3)
margin(sys3)
% 
% figure(7)
% step(sys3)
