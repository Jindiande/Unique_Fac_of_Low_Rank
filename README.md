# Unique_Fac_of_Low_Rank
This deposite is the implementation on experiments results of our paper [Unique Sparse Decomposition of Low Rank Matrices]( https://rutgersconnect-my.sharepoint.com/:b:/g/personal/dj370_soe_rutgers_edu/EShimHFuS_dEsgA6PBbtAH4BKR-QTjGLGI_S7pqvvkrJZw?e=fcKzbZ).

+ Run *recover_one_vs_n_and_r.m* and *recover_one_vs_theta_and_r.m* to reproduce left and right part of figure 1 respectively.
+ Run *general_full_recover_L4_varing_theta.m* to reproduce figure 3.
+ Run *theta_general_full_recover_three_deflation.m* and *r_general_full_recover_three_deflation.m* to get figure 4.

We use some codes from [DL_focm](https://github.com/sunju/dl_focm) and [LARS](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/58939/versions/1/previews/spca.m/index.html) to compare our method with ADMM and LARS respectively in solving Sparse-PCA problem.

Code is written by Dian Jin, Xin Bing and Yuqian Zhang. Contact dj370@scarletmail.rutgers.edu if there exist any problems.
