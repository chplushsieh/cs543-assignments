
num_of_mistakes = 0;
for i=1:size(val_confusionMatrix, 1)
  for j=1:size(val_confusionMatrix, 2)
    if i ~= j && val_confusionMatrix(i, j) > 13.5
      num_of_mistakes = num_of_mistakes + 1;
      msg = ['Some of the class ', meta.classes(i), 'are mistaken as ', meta.classes(j), '. '];
      disp(msg);
    end
  end
end

disp('Total mistakes: ');
disp(num_of_mistakes);

% Some bear's are mistaken as chimpanzee's.
% Some bicycle's are mistaken as motorcycle's.
% Some boy's are mistaken as girl's.
% Some bus's are mistaken as pickup_truck's.
% Some bus's are mistaken as streetcar's.
% Some camel's are mistaken as cattle's.
% Some cloud's are mistaken as sea's.
% Some dolphin's are mistaken as shark's.
% Some dolphin's are mistaken as whale's.
% Some house's are mistaken as castle's.
% Some lamp's are mistaken as cup's.
% Some man's are mistaken as boy's.
% Some man's are mistaken as woman's.
% Some maple_tree's are mistaken as oak_tree's.
% Some maple_tree's are mistaken as willow_tree's.
% Some plain's are mistaken as sea's.
% Some poppy's are mistaken as rose's.
% Some rose's are mistaken as tulip's.
% Some shark's are mistaken as ray's.
% Some spider's are mistaken as cockroach's.
% Some streetcar's are mistaken as bus's.
% Some train's are mistaken as streetcar's.
% Some tulip's are mistaken as orchid's.
% Some tulip's are mistaken as poppy's.
% Some tulip's are mistaken as rose's.
% Some wolf's are mistaken as possum's.
% Some woman's are mistaken as girl's.
