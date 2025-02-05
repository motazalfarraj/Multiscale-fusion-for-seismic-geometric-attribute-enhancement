function curve = curvature(data)

data = double(data); 
Z = data; 
[n,h] = size(Z);
u = linspace(-1,1,h); % vector of u-coords on parameter plane
v = linspace(-1,1,n); % vector of v-coords on parameter plane
[X,Y] = meshgrid(u,v); % grid of points on parameter plane
dx = 1;
dy = 1;
% Tangent space calculation
% First Partials (dZx, dZy)
[dZx,dZy]=gradient(Z,dx,dy);
% Second Partials (dZxx, dZxy, dZyy)
[dZxx,dZxy]=gradient(dZx,dx,dy);
[dZxy,dZyy]=gradient(dZy,dx,dy);
% First Fundamental Form Coefficiants (E, F, G)
% inner product on the tangent space
E = 1+dZx.^2;
F = dZx.*dZy;
G = 1+dZy.^2;
% Surface Unit Normal Componants (Nx, Ny, NZ)
normN = -sqrt(dZx.^2+dZy.^2+1);
Nx = -dZx./normN;
Ny = -dZy./normN;
Nz = ones(size(dZx))./normN;
%Second Fundamental Coefficiants (L, M, N)
L = dZxx./normN;
M = dZxy./normN;
N = dZyy./normN;
%Prinicpal Curvature Directions and Magnitudes
% (Kminx, Kminy, Kminz, Kmin; Kmaxx, Kmaxy, Kmaxz, Kmax)
[n,h] = size(Z);
Km1 = zeros(n,h);
Km2 = zeros(n,h);
K1x = zeros(n,h);
K1y = zeros(n,h);
K2x = zeros(n,h);
K2y = zeros(n,h);

for i=1:n
    for j=1:h
        I=[E(i,j) F(i,j);F(i,j) G(i,j)];
        II=[L(i,j) M(i,j);M(i,j) N(i,j)];
        SO=inv(I)*II;
        A=max(max(isnan(SO)));
        if A==0
            [Kd,Km]=eig(SO);
        elseif A==1
            Kd=[NaN NaN;NaN NaN];
            Km=[NaN NaN;NaN NaN];
        end
        %Principle Curvature A
        KmA(i,j)=Km(1,1); KdA1(i,j)=Kd(1,1); KdA2(i,j)=Kd(2,1);
        %Principle Curvature B
        KmB(i,j)=Km(2,2); KdB1(i,j)=Kd(1,2); KdB2(i,j)=Kd(2,2);    
    end
end

% Convert Principle Directions to Tangent Space (3D)
KAx = KdA1;
KAy = KdA2;
KAz = KdA1.*dZx+KdA2.*dZy;
normA = sqrt(KAx.^2+KAy.^2+KAz.^2);
KAx = KAx./normA;
KAy = KAy./normA;
KAz = KAz./normA;

KBx = KdB1;
KBy = KdB2;
KBz = KdB1.*dZx+KdB2.*dZy;
normB = sqrt(KBx.^2+KBy.^2+KBz.^2);
KBx = KBx./normB;
KBy = KBy./normB;
KBz = KBz./normB;

%Sort to Kmax and Kmin
i = find(KmB>KmA);
Kmax = KmA;
Kmin = KmB;
Kmaxx = KAx; Kmaxy = KAy; Kmaxz = KAz;
Kminx = KBx; Kminy = KBy; Kminz = KBz;

Kmax(i) = KmB(i);
Kmin(i) = KmA(i);
Kmaxx(i) = KBx(i);Kmaxy(i) = KBy(i);Kmaxz(i) = KBz(i);
Kminx(i) = KAx(i);Kminy(i) = KAy(i);Kminz(i) = KAz(i);
curve = real(Kmax.*(abs(Kmax)>=abs(Kmin))+Kmin.*(abs(Kmax)<abs(Kmin))); 
end 
