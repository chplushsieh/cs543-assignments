function [x_world] = triangulate(x1, x2, P1, P2)
% input x1, x2: 2xN
% input P1, P2: 3x4 camera matrices
% output x_world: 4xN world homogeneous coordinates of x
N = size(x1,2);

x_world = ones(4, N);

% P1 = [eye(3) zeros(3,1)]; % P1 is assumed to be [I|0]

for i = 1:N
    A =[x1(1,i)*P1(3,1:3) - P1(1,1:3);...
        x1(2,i)*P1(3,1:3) - P1(2,1:3);...
        x2(1,i)*P2(3,1:3) - P2(1,1:3);...
        x2(2,i)*P2(3,1:3) - P2(2,1:3)];
    
    b = -[x1(1,i)*P1(3,4) - P1(1,4);...
        x1(2,i)*P1(3,4) - P1(2,4);...
        x2(1,i)*P2(3,4) - P2(1,4);...
        x2(2,i)*P2(3,4) - P2(2,4)];
    
    [u,s,v] = svd(A);
    bprime = u'*b;
    y = bprime(1:3) ./ (diag(s));
    x_world(1:3,i) = v*y;
end

x_world = x_world./repmat(x_world(4,:),4,1);
x_world = x_world(1:3, :);

end