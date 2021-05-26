%Projected Gradient Decent to search for a sparse vector in the problem
% min_q  h_mu(q' * Y),  s.t.  ||q|| =1.
% replacement of TR_Sphere.m 
function q=Gradiant_decent_L4( Y, q_init,q_exist )
    [n,~] = size(Y);

	% initalize q
	if nargin > 2,% always use q_init
		q = q_init;
	else
		q = randn(n,1);% random initialization
		q = q / norm(q);
    end
    %parameter setting 
    MaxIter1=40; % Gradiant decent ite_num
    %MaxIter2=150; % backtracking line search ite_num
    for iter = 1:MaxIter1
        if(size(q_exist,2)==(size(q_exist,1)-1))% abandoned condition, will never happen 
           U = null(q');
        elseif(size(q_exist,2)==0)
           U=eye(n,n);
        else
           U = null([q_exist]'); % basis of the tangent space T_q = { v| v'*q =0}
        end
            
        %U = null(q');
		%[f,g] = l1_exp_approx2(Y,q,mu,true); % evaluate the function, gradient and hessian at q
        g=L4_Grad(q,Y);
        g_pro=project1(U,g)  ;                    % project gradiant to span of U 
        g_pro=g_pro/norm(g_pro);                  % normlise g_pro
		
        q=g_pro;
        %fprintf('%f\n',norm(q));
        %fprintf("Iter is %d,f=%d,norm of grad is %f\n",iter,f_new,norm(g));

		    
    end


end

