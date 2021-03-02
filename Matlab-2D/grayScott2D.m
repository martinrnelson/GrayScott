%% DEMI GANDY - REACTION-DIFFUSION - GRAY SCOTT 2D
clear; clc;

%% scenario (uncomment one) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% all presets listed here (exclusing rho) work with the inital conditions
% (ICs) given by "IC_xL2_n256.mat", or you can uncomment the "randomly 
% generated rectangles" inital conditions for different inital conditions.
% Rho patterns require special initial conditions, also included below.\

% Du=0.00002; Dv=0.00001; feed=0.010; kill=0.050; % alpha (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.025; kill=0.050; % beta (Pearson)
Du=0.00002; Dv=0.00001; feed=0.025; kill=0.054; % gamma (Pearson) 
% Du=0.00002; Dv=0.00001; feed=0.025; kill=0.052; % delta (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.020; kill=0.060; % epsilon (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.025; kill=0.060; % zeta (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.030; kill=0.060; % eta (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.035; kill=0.060; % theta (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.050; kill=0.060; % iota (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.050; kill=0.062; % kappa (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.035; kill=0.064; % lambda (Pearson)
% Du=0.00002; Dv=0.00001; feed=0.050; kill=0.064; % mu (Pearson)

% Du=0.00002; Dv=0.00001; feed=0.050; kill=0.066;  % nu (Munafo)
% Du=0.00002; Dv=0.00001; feed=0.010; kill=0.042;  % xi (Munafo)
% Du=0.00002; Dv=0.00001; feed=0.062; kill=0.061;  % pi (Munafo)
% Du=0.00002; Dv=0.00001; feed=0.095; kill=0.056;  % sigma (Munafo)

% Du=0.00002; Dv=0.00001; feed=0.100; kill=0.056;  % rho (Munafo) 

%% setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=256;   % nxn grid
xL=2.0;  % domain size 
dt=0.1;  % time step
nt=1e5;  % number of time steps
th=1000; % save every thth step

t0=0;
x0=0;        x=linspace(x0,xL,n);
y0=0; yL=xL; y=linspace(y0,yL,n);
[xx,yy]=meshgrid(x,y);

h=(xL-x0)/(n-1); % spatial step size
nn=n^2;

A=FUNfivePointLaplacian(n); A=sparse(A);  % construct Laplacian matrix

load('MyColormaps.mat')

%% initial conditions (uncomment one) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % (A) randomly generated rectangles, on background (u,v)=(1,0)
% numrects=10; backgroundu=1; backgroundv=0;
% w0=FUN_IC_randomRects(n,numrects,backgroundu,backgroundv,[0,1]);

% (B)  n=256, xL=2.0. preset random rectangles (requires n=256 above)
load 'IC_xL2_n256'

% % (C) n=256, xL=2.0. preset random rectangles for rho
% load 'IC_xL2_n256'
% w0=1-w0;

%% loop (don't change) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t(1)=t0;  w(:,1)=w0; 
tt(1)=t0; W(:,1)=w0;

for i=1:nt  
    tnew=t+dt;
    wnew=w+dt*FUNgrayScottODEs_2D(t,w,n,h,A,Du,Dv,feed,kill);

    if mod(i,th)==0
        tt((i/th)+1)=tnew;
        W(:,(i/th)+1)=wnew;
    end

    if max(abs(wnew-w)) < 1e-10
        tt(ceil(i/th))=tnew;
        W(:,ceil(i/th))=wnew;
        sprintf('Stop')
        break
    end

    t=tnew; 
    w=wnew;
    
end

%% plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)

for i=1:length(tt)
    
    uu=reshape(W(1:nn,i),n,n); vv=reshape(W(nn+1:end,i),n,n);

    s=surf(xx,yy,uu); view(0,90), axis square
    
    s.EdgeColor = 'none';  set(gca,'fontsize',15); 
    set(gca,'xtick',[],'ytick',[],'ztick',[]); 
    set(gca,'color','none','xcolor','none','ycolor','none','zcolor','none');
    
    xlim([x0 xL]); ylim([y0 yL]); zlim([0 1]);
    caxis([0 1]); colorbar; colormap(mymap2);
    
    T=sprintf('sigma=%g, feed=%g, kill=%g, t=%g',Du/Dv,feed,kill,tt(i));
    title(T)
    
    drawnow 
    
end
