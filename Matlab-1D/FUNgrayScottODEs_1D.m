function F=FUNgrayScottODEs_1D(~,w,n,h,A,Du,Dv,f,k)
% This function evaluates the right-hand sides of the discretised ODE system
% for an n x 1 mesh, with uniform spatial stepsize h, Laplacian matrix A,
% and parameters Du,Dv,f,k. w=[u;v] contains the dependent variables
% evaluated at the previous timestep.

    u=w(1:n); v=w(n+1:end);

    F=[((Du/h^2)*(A*u)) + (-u.*v.^2 +f*(1-u) ) ;
       ((Dv/h^2)*(A*v)) + ( u.*v.^2 -(f+k)*v ) ];
   
end