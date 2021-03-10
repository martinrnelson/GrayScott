function ss=FUNfindSteadyStates(f,k)
% This function finds the steady states of the homogeneous Gray-Scott model

    ustarTRIV = 1;
    vstarTRIV = 0;

    ustar1 = (1/2)*(1 + (1 - 4*((f + k).^2)*f.^(-1))^(1/2));
    vstar1 = (1/2)*(f.*(f + k).^(-1))*(1 - (1 - 4*((f + k).^2)*f.^(-1))^(1/2));

    ustar2 = (1/2)*(1 - (1 - 4*((f + k).^2)*f.^(-1))^(1/2));
    vstar2 = (1/2)*(f.*(f + k).^(-1))*(1 + (1 - 4*((f + k).^2)*f.^(-1))^(1/2));

    ss=[ustarTRIV, vstarTRIV;
        ustar1   , vstar1;
        ustar2   , vstar2];

end 