function [D_noise_orth_inv_trans]=GD_L4(Y,D)% Y should be processed  
[p,n]=size(Y);
[~,r]=size(D);
time_try=10^(3);
end_colum=p-1;
if_satis=1;
q_init=ones(p,1);
D_noise_orth_inv_trans=[];% left inverse of dictionry
res=0;
%Y_noise_orth=real(inv(sqrtm(Y_noise*transpose(Y_noise)/(p*sparsity)))*Y_noise)  %  preconditioning for Y_noise
for time=1:(time_try)% each time generate a column of left inverse of dictionary
    %fprintf("i=%d,k=%d,time=%d,column=%d,real column%d\n",i,k,time,column,size(D_noise_orth_inv_trans,2))
    
    if size(D_noise_orth_inv_trans,2)~=0
         q_init=null(D_noise_orth_inv_trans')*randn(p-size(D_noise_orth_inv_trans,2),1);% q_init lies in null space of D_noise
         q_init=q_init/norm(q_init);
    else
         q_init=randn(size(Y,1),1);
         q_init=q_init/norm(q_init);
    end
    q = Gradiant_decent_L4(Y,q_init,D_noise_orth_inv_trans); % using algorithm to generate q
    D_noise_orth_inv_trans=[D_noise_orth_inv_trans,q];

    if size(D_noise_orth_inv_trans,2)==end_colum% D_noise_orth_inv_trans is n by n-1
       D_noise_orth_inv_trans=[D_noise_orth_inv_trans,null(transpose(D_noise_orth_inv_trans))];
    end  
    if(size(D_noise_orth_inv_trans,2)==r)
          break;
    end
           
end


%[error_D,~,~]=error3(D_noise_orth_inv_trans,D); 
%[error_X,~,~]=error2(D_noise_orth_inv_trans'*Y,X);