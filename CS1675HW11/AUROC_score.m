function score = AUROC_score(x, y)

mdl = fitglm(x,y);
predictions = predict(mdl,x);
[X,Y,T,AUC] = perfcurve(y,predictions,'1');
score = AUC;

end