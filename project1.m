% This function aims to project vector g\in R^{d*1} into space of U \in R^{d*n}
% g_proj=sum_{i=1}^{i=n}(a_i*u_i) a_i=<g,u_i>/<u_i,u_i>,u_i is the ith column
% vector of U
 
function g_pro=project1(U,g)
     [d,n]=size(U);
     t=transpose(g)*U ;%t_i=<g,u_i>, t is 1*n vector
     a=t./sum(U.*U,1) ;%a_i=<g,u_i>/<u_i,u_i>
     g_pro=U*transpose(a);
end