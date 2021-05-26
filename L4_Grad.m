function dq=L4_Grad(q,Y)
%q is p*1 and Y is p*n
M1=Y'*q;
M2=M1.*M1.*M1;
dq=Y*M2;
end