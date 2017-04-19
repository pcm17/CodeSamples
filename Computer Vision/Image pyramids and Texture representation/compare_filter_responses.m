image_files = dir('*.jpg');   % Read in images from current directory endng in .jpg   
nfiles = length(image_files);    % Number of files found in MATLAB folder

image = cell(nfiles,1);
for i=1:nfiles
   current_filename = image_files(i).name;
   current_image = imread(current_filename);
   gray_image = rgb2gray(current_image);
   % First the image is resized to 512x512, then reduced in size by 1/2
   standard_sized_image = imresize(gray_image,[512,512]);
   resized_image = imresize(standard_sized_image,0.5);
   image{i} = resized_image; % We'll be using this array of images from now on
   %figure, imshow (image{i})
end
  F = makeLMfilters();% Generate filter bank
  bin_ranges = 2.^(0:0.5:7);
  nfilters = 48;
  vector_image_descriptor = cell(6,1); % 6x1 vector image descriptor 
  
  for n = 1:nfiles
      filt_im = imfilter(image{n}, F(:, :, 1)); filt_im = filt_im(:);
      % Calculate bin counts for the first time. 
      vector_image_descriptor{n} = (histc(filt_im, bin_ranges))';
      
      for i = 2:nfilters % Iteratively apply all filters to the image and concatenate the histogram of responses to image_vector_description
        %filter_image{n}  = conv2(image{n}, F(:,:,i),'valid');
        filt_im = imfilter(image{n}, F(:, :, i)); filt_im = filt_im(:); % Record responses to filter i for each image n 
        temp_hist = (histc(filt_im, bin_ranges))'; % Create histogram of responses
        vector_image_descriptor{n} = horzcat(vector_image_descriptor{n},temp_hist); % Concatenate the histograms to eventually create 1x720 vector image descriptor
        %if n == 1 || n == 2 || n ==3
        %    figure; subplot(1, 2, 1); imagesc(filter_image{n}); subplot(1, 2, 2); imagesc(F(:,:,i));
        %end
      end
  end
  % Test Print:
  % vector_image_descriptor
  % Euclidean distance between pairs of images
  within_distance = cell(3,1); % Distances between images that are of the same animal category i.e leopard1 to leopard2
  between_distance = cell(12,1); % Distances between images showing different animal categories
  n = 1; m = 1;
  
  % Calculate Euclidian Distance for each pair of images
  for i = 1:5
      for j = (i+1):6
        % Square root of the sum of the squared element-wise distances between the image descriptors
        current_distance = sqrt((sum((vector_image_descriptor{i} - vector_image_descriptor{j}) .^ 2)));
        if (i == 1 || i == 3 || i == 5) && j == (i + 1)
            within_distance{n} = current_distance; n = n + 1;
        else
            between_distance{m} = current_distance; m = m + 1;
        end
      end
  end
  
  %{
  Test Print:
  fprintf('Test Prints:\n')
  within_distance
  fprintf('\n\n')
  between_distance
  %}
  
  % Mean value of within-category
  total = 0;
  num_within_distances = size(within_distance,1);
  for i = 1:num_within_distances
      total = total + within_distance{i};
  end
  mean_distance_within = total / num_within_distances;
  fprintf('Average Euclidian Distance for within-category = %f\n', mean_distance_within);  
  
   % Mean value of between-category
  num_between_distances = size(between_distance,1);
  total = 0;
  for i = 1:num_between_distances
      total = total + between_distance{i};
  end
  mean_distance_between = total / num_between_distances;
  fprintf('Average Euclidian Distance for between-category = %f\n', mean_distance_between);  
  
  % Now let's compute the image represenation using the mean response across all pixels to each filter
  % Resulting in one mean value per filter. 
  % Overall image representation of size 1x48
  vector_mean_image_descriptor = cell(6,1); % 6x1 vector image descriptor 
  for n = 1:nfiles
      filt_im = imfilter(image{n}, F(:, :, 1)); filt_im = filt_im(:);
      % Calculate bin counts for the first time. 
      vector_mean_image_descriptor{n} = mean(filt_im);
      
      for i = 2:nfilters % Iteratively apply all filters to the image and calculate mean of responses to each filter, then concatenate those responses to create 1x48 image representation
        filt_im = imfilter(image{n}, F(:, :, i)); filt_im = filt_im(:); % Record responses to filter i for each image n 
        temp_mean = mean(filt_im); % Calculate mean of responses
        vector_mean_image_descriptor{n} = horzcat(vector_mean_image_descriptor{n},temp_mean); % Concatenate the mean responses to eventually create 1x48 vector image descriptor
      end
  end
  % Test Print:
  % vector_mean_image_descriptor
  
  % Repeat the above process to compute within-category and between-category distances
  within_distance_mean = cell(3,1); % Distances between images that are of the same animal category i.e leopard1 to leopard2
  between_distance_mean = cell(12,1); % Distances between images showing different animal categories
  n = 1; m = 1;
  
  % Compute Euclidean distance between pairs of images
  for i = 1:5
      for j = (i+1):6
        % Square root of the sum of the squared element-wise distances between the image descriptors
        current_distance = sqrt((sum((vector_mean_image_descriptor{i} - vector_mean_image_descriptor{j}) .^ 2)));
        if (i == 1 || i == 3 || i == 5) && j == (i + 1)
            within_distance_mean{n} = current_distance; n = n + 1; % Increment n to move to next within-category index
        else
            between_distance_mean{m} = current_distance; m = m + 1; % Increment m to move to next between-category index
        end
      end
  end
  
  %{
  Test Print:
  fprintf('Test Prints:\n')
  within_distance_mean
  fprintf('\n\n')
  between_distance
  %}
  
  % Mean value of within-category using mean response to filters
  total = 0;
  num_within_distances_mean = size(within_distance_mean,1);
  for i = 1:num_within_distances_mean, total = total + within_distance_mean{i}; end   
  mean_distance_within_mean = total / num_within_distances_mean;
  fprintf('Average Euclidian Distance for within-category using mean responses to filters = %f\n', mean_distance_within_mean);  
  
  % Mean value of between-category using mean response to filters
  num_between_distances_mean = size(between_distance_mean,1);
  total = 0;
  for i = 1:num_between_distances_mean, total = total + between_distance_mean{i}; end
  mean_distance_between_mean = total / num_between_distances_mean;
  fprintf('Average Euclidian Distance for between-category using mean responses to filters = %f\n', mean_distance_between_mean);  


  % Finally, just use the image pixels im(:) as the representation/description
  bin_ranges = 0:5:255;
  vector_image_descriptor_no_filter = cell(6,1); % 6x1 vector image descriptor 
  
  for n = 1:nfiles 
      im = image{n};
      vector_image_descriptor_no_filter{n} = (histc(im(:), bin_ranges))';
  end
  % Test Print:
  % vector_image_descriptor
  % Euclidean distance between pairs of images
  within_distance_no_filter = cell(3,1); % Distances between images that are of the same animal category i.e leopard1 to leopard2
  between_distance_no_filter = cell(12,1); % Distances between images showing different animal categories
  n = 1; m = 1;
  
  for i = 1:5
      for j = (i+1):6
        % Square root of the sum of the squared element-wise distances between the image descriptors
        current_distance = sqrt((sum((vector_image_descriptor_no_filter{i} - vector_image_descriptor_no_filter{j}) .^ 2)));
        if (i == 1 || i == 3 || i == 5) && j == (i + 1)
            within_distance_no_filter{n} = current_distance; n = n + 1;
        else
            between_distance_no_filter{m} = current_distance; m = m + 1;
        end
      end
  end
  
  %{
  Test Print:
  fprintf('Test Prints:\n')
  within_distance
  fprintf('\n\n')
  between_distance
  %}
  
  % Mean value of within-category
  total = 0;
  num_within_distances_no_filter = size(within_distance_no_filter,1);
  for i = 1:num_within_distances_no_filter
      total = total + within_distance_no_filter{i};
  end
  mean_distance_within_no_filter = total / num_within_distances_no_filter;
  fprintf('Average Euclidian Distance for within-category using plain pixel representation = %f\n', mean_distance_within_no_filter);  
  
   % Mean value of between-category
  num_between_distances_no_filter = size(between_distance_no_filter,1);
  total = 0;
  for i = 1:num_between_distances_no_filter
      total = total + between_distance_no_filter{i};
  end
  mean_distance_between_no_filter = total / num_between_distances_no_filter;
  fprintf('Average Euclidian Distance for between-category using plain pixel representation = %f\n', mean_distance_between_no_filter);  
