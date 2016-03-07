function y = leave_max(x)
  % find maximum responses
    if x(2, 2) < max(x)
      y = 0;
    else
      y = max(x);
    end
end
