%using cvx minimise |X-X_groud_truth*P|_2 
%given X and X_groud_truth, where P
% is permutation matrix solved with SOPT3
function [error_1,P_out,P]=error3(X,X_groud_truth)
    n1=size(X,1);
    n2=size(X,2);
	cvx_quiet(1);
	cvx_begin 
		variable P(n2,n2)  ;
		minimize(norm(X-X_groud_truth*P,'fro'))%+norm(P,1))
		subject to
        (P)*ones(n2,1)<=ones(n2,1)
        (P)*ones(n2,1)>=-1*ones(n2,1)
        ones(1,n2)*(P)<=ones(1,n2)
        ones(1,n2)*(P)>=-1*ones(1,n2)
        %A.*P==0
	cvx_end
    % solve  linear assignemnt problem  
    P_extend=repmat(P,[1,1,n2]);
    BasisPosi=repmat(reshape(transpose(eye(n2,n2)),[1,n2,n2]),[n2,1,1]);
    BasisNega=repmat(reshape(-1*transpose(eye(n2,n2)),[1,n2,n2]),[n2,1,1]);
    LossPoss=reshape(vecnorm(P_extend-BasisPosi,2,2),[n2,n2]) ;
    LossNega=reshape(vecnorm(P_extend-BasisNega,2,2),[n2,n2]) ;
    Sign=2*double(LossPoss<LossNega)-ones(n2,n2);
    Loss=min(LossPoss,LossNega);
    P_out=zeros(n2,n2);
    index=matchpairs(Loss,1000);
    ind=sub2ind([n2,n2],index(:,1),index(:,2));
    P_out(ind)=1;
    P_out=Sign.*P_out;
    error_1=(1/2)*norm(X-X_groud_truth*P_out,'fro');
     
end