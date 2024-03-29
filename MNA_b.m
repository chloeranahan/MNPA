clear

R1 = 1;
C1 = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
Ro = 1000;

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
Go = 1/Ro;


%1 V1 = Vin;
%2 (d(V1-V2)/dt)*C + (V1-V2)*G1 + Iin = 0
%3 (d(V2-V1)/dt)*C + (V2-V1)*G1 + V2*G2 + IL = 0
%4 V2-V3 = L*(d(IL)/dt)  % V2-V3 - 1i*omega*(L)*IL = 0
%5 I3 = V3*G3
%6 IL+I3 = 0
%7 V4 = a*I3
%8 (V4-Vo)*G4 + I4 = 0
%9 (Vo-V4)*G4 + Vo*Go = 0


%Frequency Domain
%1 V1 = Vin;
%2 (V1-V2)*1i*omega*C + (V1-V2)*G1 + Iin = 0
%3 (V2-V1)*1i*omega*C + (V2-V1)*G1 + V2*G2 + IL = 0
%4 V2-V3 - 1i*omega*(L)*IL = 0
%5 V3*G3 - I3 = 0
%6 IL+I3 = 0
%7 V4 - a*I3 = 0
%8 (V4-Vo)*G4 + I4 = 0
%9 (Vo-V4)*G4 + Vo*Go = 0


%Qb)

omega = 0;
N = 9;

%X = [V1 V2 V3 V4 Vo Iin IL I3 I4];
n3 = 3;
no = 5;

G = zeros(N);  
F = zeros(N,1);
C = zeros(N);
CFinal = C.*(1i*omega);


G(1,1) = 1;

G(2,1) = G1; G(2,2) = -G1; G(2,6) = 1;
C(2,1) = C1; C(2,2) = -C1;

G(3,1) = -G1; G(3,2) = G1 + G2; G(3,7) = 1;
C(3,1) = -C1; C(3,2) = C1;

G(4,2) = 1; G(4,3) = -1;
C(4,7) = -L;

G(5,3) = G3; G(5,8) = -1;

G(6,7) = 1; G(6,8) = 1;

G(7,4) = 1; G(7,8) = -a;

G(8,4) = G4; G(8,5) = -G4; G(8,9) = 1;

G(9,4) = -G4; G(9,5) = G4 + Go;

V3 = [];
Vo = [];

for i = 1:21
    Vin = i-11;
    
    F(1) = Vin;
    
    V = G\F;
    V3(i) = V(n3);
    Vo(i) = V(no);
end

figure(1)
plot(-10:10,V3)
hold on
plot(-10:10,Vo)
hold off
xlabel('Vin')
ylabel('V')



