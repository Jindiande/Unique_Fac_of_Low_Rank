function [X_GT]=random_ini_X(r,n,sparsity)
X_GT=zeros(r,n);
for ll = 1:r
   % generate p columns of k-sparse vectors for Y
   X_GT(ll,randperm(n,round(sparsity*n))) = randn(1,round(sparsity*n));
end
end