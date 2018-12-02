t  =  linspace(0,  1,  1000);
xt = @(z) 13.*z.^9 + 4.*z.^8 - 3.*z.^7 + 11.*z.^6 +z.^5-9.*z.^4+2.*z.^3 -z.^2 + z + 7;
N=5;
G = zeros(N,N);
for ii = 1:N
    for jj = 1:N
        psiij = @(z) z.^(2*jj - 2) .* z.^(2*ii - 2);
        G(jj,ii) = integral(psiij,-1,1);
    end
end
b = zeros(N,1);
for ii = 1:N
    psii = @(z) z.^(2*ii - 2).*xt(z);
    b(ii) = integral(psii,-1,1);
end