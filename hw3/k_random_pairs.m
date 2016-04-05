function pairs = k_random_pairs(k, top_pairs)
    
    pairs = zeros(k, 4);
    
    for i = 1:k
        
        cur_pair = random_pair(top_pairs);
        pairs(i, :) = cur_pair;
    end
end

function pair = random_pair(top_pairs)
    random_index = randi([1, size(top_pairs, 1)]);
    pair = top_pairs(random_index, :);
end