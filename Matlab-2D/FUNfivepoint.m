function A=FUNfivepoint(n)

% This function constructs a five-point Laplacian matrix for an n x n
% mesh, with periodic boundary conditions

    A=zeros(n^2,n^2);
            
    for i=1:n^2
        if(i>(n-1)*n),   NORTH=i-(n-1)*n; else, NORTH=i+n; end
        if(i<n+1),       SOUTH=(n-1)*n+i; else, SOUTH=i-n; end
        if(mod(i,n)==0), EAST=i+1-n;      else, EAST=i+1;  end
        if(mod(i,n)==1), WEST=i-1+n;      else, WEST=i-1;  end

        A(i,NORTH)=1;
        A(i,SOUTH)=1;
        A(i,EAST)=1;
        A(i,WEST)=1;
        A(i,i)=-4;   
    end
        
end