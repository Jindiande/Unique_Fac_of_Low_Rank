function error_q=Simple_GD_L4_final(Y,D,maxstep)
[p,n]=size(Y);
q_init=randn(p,1);
q=Simple_GD_L4(q_init,Y,maxstep);
error_q=min(ones(size(D'*q))-abs(D'*q));% D should be normlised