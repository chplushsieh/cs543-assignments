function F = ransac_part2(top_pairs)

% set how many time 
round = 8000;

max_inliner = 0;
F = eye(3);

while(round > 0)
    round = round-1;
    
    % randomly pick eight pairs
    eight_pairs = k_random_pairs(10, top_pairs);
    
    try
        cur_F = fit_fundamental(eight_pairs, 1);
    catch me
        cur_F = eye(3);
    end
    
    [cur_inliner, ~, ~] = count_inliner_part2(top_pairs, cur_F);
    
    if cur_inliner > max_inliner
        % display(max_inliner)
        max_inliner = cur_inliner;
        F = cur_F;
    end
end

end