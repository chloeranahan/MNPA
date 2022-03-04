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


% Qc)

Vin = 1;
N = 9;

%X = [V1 V2 V3 V4 Vo Iin IL I3 I4];
n3 = 3;
no = 5;

G = zeros(N);  
F = zeros(N,1);
C = zeros(N);


G(1,1) = 1;
F(1) = Vin;

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


for i = 1:101
    omega = i-1;
  
    CFinal = C.*(1i*omega);
    
    H = G + CFinal;
    V = H\F;
    
    V3(i) = V(n3);
    Vo(i) = V(no);
end

Gain1 = real(Vo)/Vin;
Gain2 = real(V3)/Vin;

% figure(1)
% plot(0:100,V3)
% hold on
% 
% plot(0:100,Vo)
% hold off

figure(2)
plot(0:100,Gain1)
xlabel('Frequency (omega)')
ylabel('Gain (Vo/Vin)')
hold on

plot(0:100,Gain2)
hold off

