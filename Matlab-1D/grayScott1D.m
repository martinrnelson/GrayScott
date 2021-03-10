%% DEMI GANDY - REACTION-DIFFUSION - GRAY SCOTT 1D
clear; clc;

%% scenario (uncomment one) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Du, Dv, feed, kill are positive parameters. 
% all presets listed here (excluding WAVE) work with the initial conditions 
% (ICs) given by (A). For WAVE, use n=256 and IC B.

Du=2e-5; Dv=1e-5; feed=0.042; kill=0.060; % SRP
% Du=2e-5; Dv=1e-5; feed=0.020; kill=0.047; % CHAOS
% Du=2e-5; Dv=1e-5; feed=0.020; kill=0.052; % YOYO
% Du=2e-5; Dv=1e-5; feed=0.052; kill=0.063; % PULSE
% Du=2e-5; Dv=1e-5; feed=0.040; kill=0.050; % BLUE
% Du=2e-5; Dv=1e-5; feed=0.020; kill=0.060; % RED

% Du=2e-5; Dv=1e-5; feed=0.010; kill=0.042; % WAVE

%% setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=256;   % nxn grid
xL=0.8;  % system size 
dt=0.1;  % time step
nt=5e4;  % number of time steps

t0=0;
x0=0; x=linspace(x0,xL,n);
h=(xL-x0)/(n-1); % spatial step size
nn=n^2; 

A=FUNtriDiag(1,-2,1,n); % construct Laplacian matrix
A(1,n)=1; A(n,1)=1; A=sparse(A); % periodic BCs

ss=FUNfindSteadyStates(feed,kill);

load('MyColormaps.mat')

%% initial conditions (uncomment one) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% (A) preset distribution 
w0=FUN_IC_1Ddistribution(n);

% % (B) preset for waves 
% if n==256 
%     load IC_1D_n256_Wave.mat
% else 
%     sprintf('Please set n=256'), return       
% end   

% % (C) pertubations around (u-,v+)
% if isreal(ss(3,1))==1 && isreal(ss(3,2))==1
%     a=0.2*rand(n,1)-0.1; b=0.2*rand(n,1)-0.1;
%     u0=real(ss(3,1))+a; v0=real(ss(3,2))+b; w0=[u0;v0];
% else
%     sprintf('The steady state (u-,v+) does not exist for the chosen parameters')
%     return
% end

%% loop %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t(1)=t0; w(:,1)=w0;

for k=1:nt 
    
    t(k+1)=t(k)+dt;
    w(:,k+1)=w(:,k)+dt*FUNgrayScottODEs_1D(t(k),w(:,k),n,h,A,Du,Dv,feed,kill);
    
    if max(abs(w(:,k+1)-w(:,k))) < 1e-10
        sprintf('Stopped')
        break
    end
end

%% plot 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)

for k=1:100:length(t)
    
    u=w(1:n,k); v=w(n+1:end,k);
    
    plot(x,u,'r','linewidth',4); hold on
    plot(x,v,'b','linewidth',4);
    
    xlim([x0 xL]); ylim([0 1]); axis square
    
    set(gca,'fontsize',20)
    T=sprintf('feed=%g, kill=%g, t=%g',feed,kill,t(k)); title(T),
    xlabel('x'), ylabel('u,v')
    
    % plot blue state solution if it exists for chosen parameters
    if isreal(ss(3,1))==1 && isreal(ss(3,2))==1
       plot(linspace(0,xL),ss(3,1)*ones(100,1),'r--','linewidth',2)
       plot(linspace(0,xL),ss(3,2)*ones(100,1),'b--','linewidth',2)
    end
    
    pbaspect([2 1 1])
    drawnow, hold off
    
end

if isreal(ss(3,1))==1 && isreal(ss(3,2))==1
    legend('u','v','u-','v+','EdgeColor','w')
else
    legend('u','v','EdgeColor','w')
end

%% plot 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)

[tt,xx]=meshgrid(t(1:10:end),x);
s=surf(xx,tt,w(n+1:end,1:10:end));

view(0,80), axis square, grid off

s.EdgeColor = 'none';  set(gca,'fontsize',20); 
set(gca,'color','none','xcolor','none','ycolor','none','zcolor','none');

xlim([x0 xL]); ylim([t(1) t(end)]); zlim([0 1]);
caxis([0 1]); colorbar; colormap(mymap2);

T=sprintf('feed=%g, kill=%g',feed,kill);
title(T), xlabel('x'), ylabel('t')
