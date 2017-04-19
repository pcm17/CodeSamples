im1 = imread('jupiter.jpg');
im2 = imread('egg.jpg');
top_k = 10;
radius = 30;

edges = detectEdges(im1, threshold);
centers = detectCircles(im1, edges, radius, top_k);

radius = 10;
edges = detectEdges(im2, threshold);
centers = detectCircles(im2, edges, radius, top_k);
