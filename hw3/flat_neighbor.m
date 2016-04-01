function [flattened] = flat_neighbor(img, r, c, neighbor_size)
    
    % set neighbor range
    M=(neighbor_size-1)/2;
    N=(neighbor_size-1)/2;
    
    % get neighborhood index
    siz = size(img);
    selected_rows = max(1, r-M):min(siz(1), r+M);
    selected_cols = max(1, c-N):min(siz(2), c+N);
    
    % get neighbor submatrix
    submatrix = img(selected_rows, selected_cols);
    
    % flatten neighbor submatrix into a row vector
    flattened = reshape(submatrix, 1, []);
    
    if size(flattened, 2) < neighbor_size^2
        flattened = [flattened, zeros(1, neighbor_size^2 - size(flattened, 2))];
    end
    
end