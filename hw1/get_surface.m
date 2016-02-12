function  height_map = get_surface(surface_normals, image_size, method)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object


%% <<< fill in your code below >>>
sur2d = surface_normals(:, :, 1:2);

    switch method
        case 'column'
          height_map = cumsum(sur2d);
          height_map = cumsum(height_map, 2);
        case 'row'
          height_map = cumsum(sur2d, 2);
          height_map = cumsum(height_map);
        case 'average'
          col_h_map = get_surface(surface_normals, image_size, 'column');
          row_h_map = get_surface(surface_normals, image_size, 'row');

          height_map = bsxfun(@plus, col_h_map, col_h_map);
          height_map = height_map ./ 2;
        case 'random'
          height_map = zeros(size(surface_normals));
          for row = 1:size(height_map, 1)
            for col = 1:size(height_map, 2)
              height_map(row, col) = random_path(row, col, surface_normals);
            end
          end
    end

end

function height = random_path(row, col, surface_normals)
  height = 0;

  while( row >= 1 | col >= 1 )
    height = height + surface_normals(i, j);
    if row > 1 & col > 1
      if (rand >= 0.5 & row > 1)
        row = row - 1;
      else
        col = col - 1;
      end
    elseif ~(row > 1)
      col = col - 1;
    else% ~(col > 1) or row==1 & col==1
      row = row - 1;
    end
  end
  
end
