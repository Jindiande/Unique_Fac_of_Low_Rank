clear all; clc;
r=10*[1:1:5];

p=100;
MAX_ITER=1e5;
TOL = 1e-5;
tau=0.1;
theta=[0.05:0.05:0.6];
n=1.2*10^(4);
delete(gcp('nocreate'));
core_number=8;
parpool('local',core_number);
repeat_time1=8;
repeat_time2=5;
%maxstep=10;
error_average_r_theta=ones(size(r,2),size(theta,2));
for i=1:length(theta)
for j=1:length(r)
    error_D_L4_sum1=0;
    %error_D_ADMM_sum1=0;
    %error_D_SPCA_sum1=0;
    j=j
    i=i
    parfor time2=1:repeat_time1
        D=randn(p,r(j));
        X=random_ini_X(r(j),n,theta(i));
        Y_gt=D*X;
        [U,~,W]=svd(Y_gt);
        Y=U*[sqrt(n*theta(i))*[eye([r(j),n]);zeros(p-r(j),n)]]*transpose(W);
        error_D_L4_sum2=0;
        %error_D_ADMM_sum2=0;
        %error_D_SPCA_sum2=0;
        for k=1:repeat_time2
            [D_orth_inv_trans]=GD_L4(Y,D)
            D_res=sqrtm(Y_gt*Y_gt'/(n*theta(i)))*D_orth_inv_trans;
            %[error_D_ADMM]=ADMM(Y,D,MAX_ITER,TOL,tau);
            %[error_D_SPCA]=spca_error(Y,D);
            [error_D_L4,~,~]=error3(D_res,D); 
            error_D_L4_sum2=error_D_L4_sum2+error_D_L4;
            %error_D_ADMM_sum2=error_D_ADMM_sum2+error_D_ADMM;
            %error_D_SPCA_sum2=error_D_SPCA_sum2+error_D_SPCA;
        end
        error_D_L4_sum1=error_D_L4_sum1+error_D_L4_sum2;
        %error_D_ADMM_sum1=error_D_ADMM_sum1+error_D_ADMM_sum2;
        %error_D_SPCA_sum1=error_D_SPCA_sum1+error_D_SPCA_sum2;
    end
    error_average_r_theta(j,i)=error_D_L4_sum1/(repeat_time1*repeat_time2);
    %error_average_r(2,j)=error_D_ADMM_sum1/(repeat_time1*repeat_time2);
    %error_average_r(3,j)=error_D_SPCA_sum1/(repeat_time1*repeat_time2);
end
end
strx='\theta'
stry='Recovery Error';
%load(filename);
h=[]
figure();
Markers = {'-+','-o','-*','-x','-v','-d'}

for i=1:size(error_average_r_theta,1)
    a=reshape(error_average_r_theta(i,1:size(error_average_r_theta,2)),1,size(error_average_r_theta,2))./(r(i)^(1/2));
    pj=plot(theta(1:size(error_average_r_theta,2)),a, Markers{i});
    h=[h,pj];
    hold on;
end
%}
%xlim([0.05 0.6])
%ylim([0, 2])


hold off;
%legend(h,"Our Method","ADMM","LARS");
legend(h,'r=10','r=20','r=30','r=40','r=50');
xlabel(strx);
ylabel(stry);