%undercomplete  recover whole vs theta and r
delete(gcp('nocreate'));
clear all; clc;
r=10*[1:2:9];;
%p=50*[1:1:6];
p=100;
%theta=0.1;
theta=[0.05:0.05:0.6]
n=1.2*10^(4);
core_number=8;
parpool('local',core_number);
repeat_time1=8;
repeat_time2=2;
maxstep=10;
prob_average=ones(size(r,1),size(theta,1));
for i=1:length(r)
    for j=1:length(theta)
        num_sum1=0;
        i=i
        j=j
        parfor time2=1:repeat_time1
            D=null(rand(p,p-r(i))');
            size(D);
            X=random_ini_X(r(i),n,theta(j));
            Y=D*X;
            num_sum2=0;
            for k=1:repeat_time2
                %error=GD_L4(Y,D);
                error=Simple_GD_L4_final(Y,D,200);
                if (error<0.01)
                    num_sum2=num_sum2+1;
                end
            end
            num_sum1=num_sum1+num_sum2;
        end
        prob_average(i,j)=num_sum1/(repeat_time1*repeat_time2);
    end
end
%save("final_result/theta_r_whole_recover_times");
delete(gcp('nocreate'));
strx='\theta'
stry='Recovery probability';

h=[];
figure();
Markers = {'-+','-o','-*','-x','-v','-d'}
for i=1:size(prob_average,1)
    pj=plot(theta,prob_average(i,:),Markers{i});
    h=[h,pj];
    hold on;
end
xlim([0.05,0.6]);
ylim([0 1.2]);
hold off;
legend(h,"r=10","r=30","r=50","r=70","r=90");
xlabel(strx);
ylabel(stry);
%}