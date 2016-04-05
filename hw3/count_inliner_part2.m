function [cur_inliner, inliner_pairs, avg_residual] = count_inliner_part2(top_pairs, F)
    threshold =4; % set
    
    cur_inliner = 0;
    avg_residual = 0;
    is_inliner = false(size(top_pairs, 1), 1);
    
    L = get_epipolar_line(F, top_pairs);
    [closest_pt, L] = get_closest_pt(L, top_pairs);
    
     for i = 1:size(top_pairs, 1)  
        right_coordinate = top_pairs(i,3:4);
        left_transormed = closest_pt(i,1:2);
        
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