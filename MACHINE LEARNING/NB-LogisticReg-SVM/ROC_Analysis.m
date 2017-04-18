clear all

main1;
main2_1;
main2_2;
main2_3;
main3_1;

[X_LR,Y_LR,~,AUC_LR] = perfcurve(y_train, y_train_pred_LR(:),1);
[X_NB,Y_NB,~,AUC_NB] = perfcurve(y_train, y_train_pred_NB(:),1);
[X_svm,Y_svm,~,AUC_SVM] = perfcurve(y_train, y_train_pred_SVM(:),1);

plot(X_LR,Y_LR);
hold on
plot(X_NB,Y_NB);
hold on
plot(X_svm,Y_svm);
hold off
legend('Linear Regression','Naive Bayes', 'SVM', 'Location','SE');
xlabel('False positive rate'); ylabel('True positive rate');

%teste = immse(test_labels, test_predictions);

