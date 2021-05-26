function q=Simple_GD_L4(q_ini,Y,maxstep)
q=q_ini;
step_size=0.0001;
for step=1:maxstep
   %step=step
   dq=L4_Grad(q,Y); 
   %dq=dq/norm(dq);
   q=q+step_size*dq;
   q=q/norm(q);
end
