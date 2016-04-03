function F = fit_fundamental(matches)

% Matlab library solution
% matchedPoints1 = matches(:, 1:2);
% matchedPoints2 = matches(:, 3:4);
% F = estimateFundamentalMatrix(matchedPoints1,matchedPoints2);

N = size(matches,1);
x1 = [transpose(matches(:, 1:2)); ones(1, N)];
x2 = [transpose(matches(:, 3:4)); ones(1, N)];
F = det_F_normalized_8point(x1,x2);

% TODO read and modify det_F_normalized_8point
% TODO add un-normalized 8 point algorithm
end