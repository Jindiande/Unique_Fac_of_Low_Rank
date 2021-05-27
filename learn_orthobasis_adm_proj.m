function [A,X,loss] = learn_orthobasis_adm_proj( Y_noise,A_exist, A_init, MAX_ITER, TOL, tau, DISPLAY) 

%%%
%
% learn_orthobasis_alternating
%
% Learns a sparsifying orthobasis
%
% Inputs:
%
% Outputs:
%
% Ju Sun and John Wright, January '14
%  Questions? johnwright@ee.columbia.edu
%  
% Last Update: Sat 18 Oct 2014 04:10:00 PM EDT 
%%%

done = false;
iter = 0;

dim = size(Y_noise, 1); 

A_old = A_init; 
if(size(A_exist,2)==0)
           U=eye(size(Y_noise,1),size(Y_noise,1));
else
     U = null([A_exist]'); % basis of the tangent space T_q = { v| v'*q =0}
end
while ~done,   
    
	iter = iter + 1;    
        
    X = prox_L1(A_old' * Y_noise, tau );    
    A_new = proj_orthogonal_group( Y_noise * X');
    A_new=project1(U,A_new)  ;                    % project gradiant to span of U 
    A_new=A_new/norm(A_new);                  % normlise g_pro
    
    stepSize = norm(A_old - A_new, 'fro');
    
    if DISPLAY,
        disp(['Iteration ' num2str(iter) '  ||X||_1 ' num2str(norm1(X)) '  ||A-A_prev||_F ' num2str(stepSize)]);
    end

    if stepSize < TOL * sqrt(dim) || iter >= MAX_ITER,
    	done = true; 
    end 
    
    A_old = A_new; 
    
end

A = A_new; 


loss=norm(Y_noise-A*X,'fro')/(dim*size(Y_noise,2))^(1/2);
X=X;