function T=FUNtriDiag(a,b,c,n)

% T=tridiag(a,b,c,n) returns an (nxn) matrix that has a, b, c as the 
% subdiagonal, main diagonal and superdiagonal entries in the matrix. 

T=b*diag(ones(n,1))+c*diag(ones(n-1,1),1)+a*diag(ones(n-1,1),-1);

end