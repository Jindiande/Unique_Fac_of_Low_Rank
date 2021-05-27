function Q = proj_orthogonal_group( M )

% project a square matrix M onto the orthgonal group, in the Frobenius
% sense
[n1,n2]=size(M);
[U,S,V] = svd(M);

Q = U*eye(n1,n2)*V';
