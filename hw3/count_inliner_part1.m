function [cur_inliner, inliner_pairs, avg_residual] = count_inliner_part1(top_pairs, homography)
    threshold = 10; % TODO
    
    cur_inliner = 0;
    avg_residual = 0;
    is_inliner = false(size(top_pairs, 1), 1);
    
    for i = 1:size(top_pairs, 1)  
        left_coordinate = top_pairs(i, 1:2);
        right_coordinate = top_pairs(i, 3:4);
        
        r_left = left_coordinate(1);
        c_left = left_coordinate(2);
        
        cr_left_transormed = homography_transform([c_left r_left], homography);
        
        left_transormed = [cr_left_transormed(2), cr_left_transormed(1)];
        
        error_distance = dist2(left_transormed, right_coordinate);
        if error_distance < (threshold^2)
            cur_inliner = cur_inliner + 1;
            avg_residual = avg_residual + error_distance;
            is_inliner(i) = true;
        end
    end
    
    inliner_pairs = top_pairs(is_inliner == true, :);
    avg_residual = avg_residual / cur_inliner;
end