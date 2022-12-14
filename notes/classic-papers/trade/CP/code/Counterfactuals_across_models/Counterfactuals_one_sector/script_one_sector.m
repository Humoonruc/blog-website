% Script

close all
clear all
clc

vfactor  = -0.2;
tol      = 1E-07;
maxit    = 1E+10;

%Inputs
J=40; N=31;

% Countries = [Argentina    Australia   Austria Brazil  Canada  Chile China   Denmark Finland France...
%              Germany  Greece  Hungary India   Indonesia   Ireland Italy   Japan   Korea Mexico ...
%              Netherlands New Zealand Norway  Portugal    SouthAfrica Spain   Sweden  Turkey  UK   USA ...
%              ROW];

% Loading trade flows
xbilat1993=importdata('xbilat1993.txt'); 
xbilat1993=xbilat1993*1000;                                  % converted to dollars from thousand dollars
xbilat1993_new=[xbilat1993;zeros(20*N,N)];                   % adding the non-tradabble sectors    

xbilat1993_new2=zeros(N,N);

for i=1:N
    xbilat1993_new2(i,:)=sum(xbilat1993_new(i:N:J*N,:));      %aggregate bilateral trade matrix
end

xbilat1993_new=[xbilat1993_new2; zeros(N,N)];

 tau1993=importdata('tariffs1993.txt');                       % tariffs 1993  
 tau2005=importdata('tariffs2005.txt');                       % tariffs 2005

 tau1993_v2=zeros(N,N);
 for i=1:N
    tau1993_v2(i,:)=median(tau1993(i:N:20*N,:));
 end;

tau2005_v2=zeros(N,N);
 for i=1:N
    tau2005_v2(i,:)=median(tau2005(i:N:20*N,:));
 end
tau1993=tau1993_v2;                                       %aggregate tariffs 1993      
tau2005=tau2005_v2;                                       %aggregate tariffs 2005
 % 
 tau=[1+tau1993/100;ones(N,N)];                           % actual tariff vector   
 taup=[1+tau2005/100;ones(N,N)];                          % counterfactual tariff vector
 taup=tau;
 tau_hat=taup./tau;                                           % Change in tariffs 
 
% % Parameters
   G=importdata('IO.txt');    % IO coefs
   
 G_aux_T=zeros(N*J,1);
 G_aux_NT=zeros(N*J,1);
   for j=1:N*J
  G_auxT(j,:)=mean(G(j,1:20));
   end
  for j=1:N*J
  G_auxNT(j,:)=mean(G(j,21:40));
   end
  
  G_aux=[G_auxT,G_auxNT]; 
  
  G_aux2=zeros(2*N,2);
  for j=1:2*N
      G_aux2(j,:)=mean(G_aux(1+(j-1)*20:j*20,:));
  end
  
  G_aux3=zeros(2*N,2);
  for j=1:N
      G_aux3(1+(j-1)*2:j*2,:)=G_aux2(1+(j-1)*2:j*2,:)./(ones(2,1)*sum(G_aux2(1+(j-1)*2:j*2,:)));
  end   
G=G_aux3;                   %aggregate I-O

   B=importdata('B.txt');    % share of value added
   B1=median(B(1:20,:));
   B2=median(B(21:40,:));
   B=[B1;B2];               %aggregate share of value added in gross output
   GO=importdata('GO.txt'); % gross Output 
   GO1=sum(GO(1:20,:));
   GO2=sum(GO(21:40,:));
   GO=[GO1;GO2];            %aggregate gross output
%  

  T=1/4.55*ones(2,1);   % Thetas - dispersion of productivity 

 % calculating expenditures
 xbilat=xbilat1993_new.*tau;                         
% % 
% 

J=2;
% % % Domestic sales
x=zeros(J,N);
xbilat_domestic=xbilat./tau;         
for i=1:J
x(i,:)=sum(xbilat_domestic(1+(i-1)*N:i*N,:));
end
GO=max(GO,x); domsales=GO-x;                                              % Domestic sales
% 
% Bilateral trade matrix
domsales_aux=domsales';
aux2=zeros(J*N,N);
for i=1:J
     aux2(1+(i-1)*N:i*N,:)=diag(domsales_aux(:,i));
end
xbilat=aux2+xbilat;

% Calculating X0 Expenditure
A=sum(xbilat');
for j      = 1:1:J
    X0(j,:) = A(:,1+N*(j-1):N*j);
end
% 
% % Calculating Expenditure shares
Xjn = sum(xbilat')'*ones(1,N);
Din=xbilat./Xjn;

% Calculating superavits
xbilattau=xbilat./tau;
for j      = 1:1:J
    % Imports
    M(j,:) = (sum(xbilattau(1+N*(j-1):N*j,:)'))';
    for n  = 1:1:N
    % Exports
    E(j,n) = sum(xbilattau(1+N*(j-1):N*j,n))';
    end
end;

Sn=sum(E)'-sum(M)';

% Calculating Value Added 
VAjn=GO.*B;
VAn=sum(VAjn)';
% 
 for n=1:N
    irow=1+J*(n-1):J*n;
    num(:,n)=X0(:,n)-G(irow,:)*+((1-B(:,n)).*E(:,n));
end




for j   = 1:1:J
irow    = 1+N*(j-1):1:N*j;
F(j,:) = sum((Din(irow,:)./tau(irow,:))');
end
% 
alphas=num./(ones(J,1)*(VAn+sum(X0.*(1-F))'-Sn)');
 
for j=1:J
    for n=1:N
        if alphas(j,n)<0
            alphas(j,n)=0;
        end
    end
end
alphas=alphas./(ones(J,1)*(sum(alphas)));


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %   Main Program Counterfactuals
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

  [wf0 pf0 PQ Fp Dinp ZW Snp2] = equilibrium_LC(tau_hat,taup,alphas,T,B,G,Din,J,N,maxit,tol,VAn./100000,Sn./100000,vfactor);
% 
PQ_vec   = reshape(PQ',1,J*N)'; % expenditures Xji in long vector: PQ_vec=(X11 X12 X13...)' 
Dinp_om = Dinp./taup;
xbilattau = (PQ_vec*ones(1,N)).*Dinp_om;
xbilatp = xbilattau.*taup;

for j=1:J
    GO(j,:) = sum(xbilattau(1+(j-1)*N : j*N,:));
end

for j=1:J
    for n = 1:N
        xbilatp(n+(j-1)*N,n) = 0;
    end   
end

save('xbilat_base_year', 'xbilatp','Dinp','xbilattau')
save('alphas', 'alphas')
save('GO', 'GO')
% % 
