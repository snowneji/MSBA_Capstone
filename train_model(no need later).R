a=read.csv('final_best_train.csv',header = T)
#### train data
iftrain=createDataPartition(train_data$trainning_label,p = 0.87,list = F)
train = train_data[iftrain,]
vali = train_data[-iftrain,]
#
train2 = train[,-ncol(train)] %>% as.matrix
label = train$trainning_label
vali2 = vali[,-ncol(vali)] %>% as.matrix
result = vali$trainning_label
#model
param <- list("objective" = "multi:softprob",
              "eval_metric" = "mlogloss",
              "eta" = 0.1,
              "num_class" = 4)

bst.cv = xgb.cv(param=param,label=label, data = train2, nfold = 5, nrounds = 100,nthread=4,early.stop.round = 5)

#best: trigram:
#0.95: accu:0.7225
#0.96, accu:0.7361
#0.97, accu:0.7319
#0.98, accu:0.7301

#with new words removed:
#0.96sparseremove,eta0.2 accu 0.7404

set.seed(1028)
md = xgboost(param=param,label=label, data = train2,nrounds = 37,nthread=4,verbose = T)

res = predict(md,vali2)
res_data<-matrix(res,nrow=4,ncol=1171)
res_data<-as.data.frame(res_data)
row.names(res_data)<-c(0,1,2,3)
res_data<-t(res_data)
new_res<-apply(res_data,1, function(x) names(sort(x,decreasing = T))[1] )
confusionMatrix(new_res,reference = result)

# save the model locally
xgb.save(md,'xgboost_model')