function [closest_pt, L] = get_closest_pt(L, matches)
% find points on epipolar lines L closest to matches(:,3:4)

N = size(matches,1);

L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
pt_line_dist = sum(L .* [matches(:,3:4) ones(N,1)],2);
closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);
end

