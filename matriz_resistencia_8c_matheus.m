%Este programa calcula a resistencia R_ij_kl = (V_k – V_l)/I_ij
% os contatos estao identificados como:
% 1u -> 1
% 1d -> 2
% 2u -> 3
% 2d -> 4
% 3u -> 5
% 3d -> 6
% 4u -> 7
% 4d -> 8

ang = 4.0; %ver tabela de equivalencias quando aparece iXX
I1 = 2; %lead que entra a corrente 
I2 = 4; %lead que sai a corrente se considera que tem voltagem 0
V1 = 1; % lead para medir voltagem
V2 = 5; % lead para medir voltagem 

%FOUT = strcat("R_",num2str(I1),num2str(I2),"_",num2str(V1),num2str(V2),"_",num2str(ang),".dat");

FOUT = strcat("R_",num2str(V1),num2str(V2),"_",num2str(I1),num2str(I2),"_",num2str(ang),".dat");

varhead = [I1 I2 V1 V2 ang];

%save(FOUT,'varhead','-ascii');

MG2u1u = load('G2u1u_AA50x50_4p0_0T_th.dat');
MG3u1u = load('G3u1u_AA50x50_4p0_0T_th.dat');
MG4u1u = load('G4u1u_AA50x50_4p0_0T_th.dat');
MG2d1u = load('G2d1u_AA50x50_4p0_0T_th.dat');
MG3d1u = load('G3d1u_AA50x50_4p0_0T_th.dat');
MG4d1u = load('G4d1u_AA50x50_4p0_0T_th.dat');
MG1d1u = load('G1d1u_AA50x50_4p0_0T_th.dat');
MG2u1d = load('G2u1d_AA50x50_4p0_0T_th.dat');
MG3u1d = load('G3u1d_AA50x50_4p0_0T_th.dat');
MG4u1d = load('G4u1d_AA50x50_4p0_0T_th.dat');
MG2d1d = load('G2d1d_AA50x50_4p0_0T_th.dat');
MG3d1d = load('G3d1d_AA50x50_4p0_0T_th.dat');
MG4d1d = load('G4d1d_AA50x50_4p0_0T_th.dat');
MG2u4u = load('G2u4u_AA50x50_4p0_0T_th.dat');
MG3u4u = load('G3u4u_AA50x50_4p0_0T_th.dat');
MG2d4u = load('G2d4u_AA50x50_4p0_0T_th.dat');
MG3d4u = load('G3d4u_AA50x50_4p0_0T_th.dat');
MG4d4u = load('G4d4u_AA50x50_4p0_0T_th.dat');
MG2u4d = load('G2u4d_AA50x50_4p0_0T_th.dat');
MG3u4d = load('G3u4d_AA50x50_4p0_0T_th.dat');
MG2d4d = load('G2d4d_AA50x50_4p0_0T_th.dat');
MG3d4d = load('G3d4d_AA50x50_4p0_0T_th.dat');

E = MG2u1u(:,1);
[f c] = size(MG2u1u);

i = 1;

G = zeros(8,8);
vecI = zeros(7,1);

%renumbering the indeces of the current and voltage leads. Necessary whrn the dimension of G is reduced 
if (I1 > I2)
I1 = I1 - 1; 
endif

if (V1 > I2)
V1 = V1 - 1; 
endif

if (V2 > I2)
V2 = V2 - 1; 
endif

while i <= f
 % 1u <-> 1d
   g1d1u = MG1d1u(i,2);
   g1u1d = g1d1u;
   G(2,1) = -g1d1u;
   G(1,2) = -g1u1d;

% 1u <-> 2u
   g2u1u = MG2u1u(i,2);
   g1u2u = g2u1u;
   G(3,1) = -g2u1u;
   G(1,3) = -g1u2u;

% 1u <-> 2d
  g2d1u = MG2d1u(i,2);
  g1u2d = g2d1u;
  G(4,1) = -g2d1u;
  G(1,4) = -g1u2d;

% 1u <-> 3u
  g3u1u = MG3u1u(i,2);
  g1u3u = g3u1u;
  G(5,1) = -g3u1u;
  G(1,5) = -g1u3u;

% 1u <-> 3d
  g3d1u = MG3d1u(i,2);
  g1u3d = g3d1u;
  G(6,1) = -g3d1u;
  G(1,6) = -g1u3d;

% 1u <-> 4u
  g4u1u = MG4u1u(i,2);
  g1u4u = g4u1u;
  G(7,1) = -g4u1u;
  G(1,7) = -g1u4u;

% 1u <-> 4d
  g4d1u = MG4d1u(i,2);
  g1u4d = g4d1u;
  G(8,1) = -g4d1u;
  G(1,8) = -g1u4d;

  G(1,1) = g1d1u + g2u1u + g2d1u + g3u1u + g3d1u + g4u1u + g4d1u;      

% 1d <-> 2u
  g2u1d = MG2u1d(i,2);
  g1d2u = g2u1d;
  G(3,2) = -g2u1d;
  G(2,3) = -g1d2u;

% 1d <-> 2d
  g2d1d = MG2d1d(i,2);
  g1d2d = g2d1d;
  G(4,2) = -g2d1d;
  G(2,4) = -g1d2d;

% 1d <-> 3u
  g3u1d = MG3u1d(i,2);
  g1d3u = g3u1d;
  G(5,2) = -g3u1d;
  G(2,5) = -g1d3u;

% 1d <-> 3d
  g3d1d = MG3d1d(i,2);
  g1d3d = g3d1d;
  G(6,2) = -g3d1d;
  G(2,6) = -g1d3d;

% 1d <-> 4u
  g4u1d = MG4u1d(i,2);
  g1d4u = g4u1d;
  G(7,2) = -g4u1d;
  G(2,7) = -g1d4u;

% 1d <-> 4d
  g4d1d = MG4d1d(i,2);
  g1d4d = g4d1d;
  G(8,2) = -g4d1d;
  G(2,8) = -g1d4d;

  G(2,2) = g1u1d + g2u1d + g2d1d + g3u1d + g3d1d + g4u1d + g4d1d;

% 2u <-> 2d
  g2d2u = g1d1u;
  g2u2d = g2d2u; 
  G(4,3) = -g2d2u;
  G(3,4) = -g2u2d;

% 2u <-> 3u
  g3u2u = g4u1u; % por simetria
  g2u3u = g3u2u; 
  G(5,3) = -g3u2u;
  G(3,5) = -g2u3u;

% 2u <-> 3d
  g3d2u = g4d1u; % por simetria
  g2u3d = g3d2u; 
  G(6,3) = -g3d2u;
  G(3,6) = -g2u3d;

% 2u <-> 4u
  g4u2u = g3u1u; % por simetria
  g2u4u = g4u2u; 
  G(7,3) = -g4u2u;
  G(3,7) = -g2u4u;

% 2u <-> 4d
  g4d2u = g3d1u; % por simetria
  g2u4d = g4d2u; 
  G(8,3) = -g4d2u;
  G(3,8) = -g2u4d;

  G(3,3) = g1u2u + g1d2u + g2d2u + g3u2u + g3d2u + g4u2u + g4d2u;

% 2d <-> 3u
  g3u2d = g4u1d; % por simetria
  g2d3u = g3u2d; 
  G(5,4) = -g3u2d;
  G(4,5) = -g2d3u;

% 2d <-> 3d
  g3d2d = g4d1d; % por simetria
  g2d3d = g3d2d; 
  G(6,4) = -g3d2d;
  G(4,6) = -g2d3d;

% 2d <-> 4u
  g4u2d = g3u1d; % por simetria
  g2d4u = g4u2d; 
  G(7,4) = -g4u2d;
  G(4,7) = -g2d4u;

% 2d <-> 4d
  g4d2d = g3d1d; % por simetria
  g2d4d = g4d2d; 
  G(8,4) = -g4d2d;
  G(4,8) = -g2d4d;

  G(4,4) = g1u2d + g1d2d + g2u2d + g3u2d + g3d2d + g4u2d + g4d2d;

% 3u <-> 3d, 4u <-> 4d
  g4d4u = MG4d4u(i,2);
  g4u4d = g4d4u;
  G(8,7) = -g4d4u;
  G(7,8) = -g4u4d;

  g3d3u = g4d4u;
  g3u3d = g3d3u;
  G(6,5) = -g3d3u;
  G(5,6) = -g3u3d;

% 4u <-> 3u
   g3u4u = MG3u4u(i,2);
   g4u3u = g3u4u;
   G(7,5) = -g4u3u;
   G(5,7) = -g3u4u;

% 4u <-> 3d
  g3d4u = MG3d4u(i,2);
  g4u3d = g3d4u;
  G(7,6) = -g4u3d;
  G(6,7) = -g3d4u;

% 4d <-> 3u
  g3u4d = MG3u4d(i,2);
  g4d3u = g3u4d;
  G(5,8) = -g3u4d;
  G(8,5) = -g4d3u;

% 4d <-> 3d
  g3d4d = MG3d4d(i,2);
  g4d3d = g3d4d;
  G(6,8) = -g3d4d;
  G(8,6) = -g4d3d;

  G(5,5) = g1u3u + g1d3u + g2u3u + g2d3u + g3d3u + g4u3u + g4d3u;
  G(6,6) = g1u3d + g1d3d + g2u3d + g2d3d + g3u3d + g4u3d + g4d3d;
  G(7,7) = g1u4u + g1d4u + g2u4u + g2d4u + g3u4u + g3d4u + g4d4u;
  G(8,8) = g1u4d + g1d4d + g2u4d + g2d4d + g3u4d + g3d4d + g4u4d;

%removing row and column of I2 (becuase voltage is zero)
  G(:,I2) = [];
  G(I2,:) = [];

  vecI(I1,1) = 1;

  V = G\vecI; % mejor resolver le sistema lineal que invertir la matriz!!

  R_i1i2_v1v2(i,1) = E(i);
  R_i1i2_v1v2(i,2) = V(V1,1) - V(V2,1); 

  i = i + 1;
end 


plot(R_i1i2_v1v2(:,1),R_i1i2_v1v2(:,2));

%save("-append",FOUT,'R_i1i2_v1v2','-ascii');
save(FOUT,'R_i1i2_v1v2','-ascii');
