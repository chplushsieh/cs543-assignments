function  height_map = get_surface(surface_normals, image_size, method)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object


%% <<< fill in your code below >>>
h = image_size(:,1);
w = image_size(:,2);
height_map = zeros(h, w);

along_y = surface_normals(:, :, 1);
along_x = surface_normals(:, :, 2);

along_y = along_y ./ surface_normals(:, :, 3);
along_x = along_x ./ surface_normals(:, :, 3);

    switch method
        case 'column'
          for x=1:h-1
            height_map(x+1, 1) = height_map(x, 1) + along_x(x+1, 1);
          end

          for x=1:h
              for y=1:w-1
                height_map(x, y+1) = height_map(x, y) + along_y(x, y+1);
              end
          end

        case 'row'
          for y=1:w-1
            height_map(1, y+1) = height_map(1, y) + along_y(1, y+1);
          end

          for y=1:w
              for x=1:h-1
                height_map(x+1, y) = height_map(x, y) + along_x(x+1, y);
              end
          end

        case 'average'
          col_h_map = get_surface(surface_normals, image_size, 'column');
          row_h_map = get_surface(surface_normals, image_size, 'row');

          height_map = bsxfun(@plus, col_h_map, row_h_map);
          height_map = height_map ./ 2;

        case 'random'
          height_map = n_random_path(5, image_size, along_x, along_y);

        case 'all'
          for x=1:h-1
             for y=1:w-1
                 height_map(x,y+1) = height_map(x,y) + along_y(x,y+1);
                 height_map(x+1,y) = height_map(x,y) + along_x(x+1,y);
             end
          end
    end

end

% take average of n height map derived from different random paths
function  height_map = n_random_path(n, image_size, along_x, along_y)
    h = image_size(:,1);
    w = image_size(:,2);
    height_map = zeros(h, w);
    for  i = 1:n
        r_h_map = random_path(image_size, along_x, along_y);
        height_map = bsxfun(@plus, height_map, r_h_map);
    end
    height_map = height_map ./ n;
end

% get a height map derived from random path
function  height_map = random_path(image_size, along_x, along_y)
    h = image_size(:,1);
    w = image_size(:,2);
    height_map = zeros(h, w);

    for x=1:h
        for y=1:w
            height_map(x,y) = walk(x, y, along_x, along_y);
        end
    end

end

% compute one pixel height from random walk to the origin
function  height = walk(x, y, along_x, along_y)
    if x == 1 && y == 1
        height = 0;
    elseif x == 1 && ~(y == 1)
        height = along_y(x, y) + walk(x, y-1, along_x, along_y);
    elseif ~(x == 1) && y == 1
        height = along_x(x, y) + walk(x-1, y, along_x, along_y);
    else
        if rand >= 0.5
            height = along_x(x, y) + walk(x-1, y, along_x, along_y);
        else
            height = along_y(x, y) + walk(x, y-1, along_x, along_y);
        end
    end
end
