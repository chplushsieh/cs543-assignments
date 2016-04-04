function homography = ransac(top_pairs)

% set how many time 
round = 1400;

max_inliner = 0;
homography = eye(3);

while(round > 0)
    round = round-1;
    
    % randomly pick four pairs
    four_pairs = four_random_pairs(top_pairs);
    % display(four_pairs)
    
    r_left = four_pairs(:, 1);
    c_left = four_pairs(:, 2);
    r_right = four_pairs(:, 3);
    c_right = four_pairs(:, 4);
    
    try
        T = maketform('projective', [c_left, r_left], [c_right, r_right]);
        cur_homography = T.tdata.T;
    catch me
        cur_homography = eye(3);
    end
    
    [cur_inliner, ~] = compute_num_of_inliners(top_pairs, cur_homography);
    
    if cur_inliner > max_inliner
        display(max_inliner)
        max_inliner = cur_inliner;
        homography = cur_homography;
    end
end

end

function pairs = four_random_pairs(top_pairs)
    
    pairs = zeros(4, 4);
    
    for i = 1:4
        
        cur_pair = random_pair(top_pairs);
        pairs(i, :) = cur_pair;
    end
end

function pair = random_pair(top_pairs)
    random_index = randi([1, size(top_pairs, 1)]);
    pair = top_pairs(random_index, :);
end