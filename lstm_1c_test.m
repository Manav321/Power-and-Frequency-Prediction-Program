%{
clc;
clear all;
close all;
%}
raw = readtable('Data_m.xlsx', 'Sheet','Sheet1', 'VariableNamingRule','preserve');
times = raw(:,1).Variables;
times = rmmissing(times);
data = raw(:,2:4).Variables;
data = str2double(rmmissing(data));
data = data';

% Creating the datetime array
startTime = datetime('2021-10-01 00:00:00');
endTime = datetime('2022-10-11 23:45:00');
timeData = startTime:minutes(15):endTime;
timeData = timeData';

numInput = 3;
colOutput = 2;
numChannels = size(data,1);
stepsize = 40;

pred_change_array = string.empty(0, 1);
act_change_array = string.empty(0, 1);


%%% partition dataset into training and testing set -- 90%:10% of the data
numTimeStepsTrain = floor(0.8*size(data,2));
dataTrain = data(:,1:numTimeStepsTrain);
dataTest = data(:,numTimeStepsTrain+1:end);
timeDataTest = timeData(numTimeStepsTrain+1:end,:);


%%% mean and std of training dataset
muX = mean(dataTrain(:,1:end-1),2);
sigX = std(dataTrain(:,1:end-1),0,2);
muY = mean(dataTrain(colOutput,2:end),2);
sigY = std(dataTrain(colOutput,2:end),0,2);


YtimeDataTest = timeDataTest(2:end,:);

timesTest = times(numTimeStepsTrain+1:end,:);


%%% normalization of testing set
XTest = (dataTest(:,1:end-1)-muX)./sigX;
YTest = (dataTest(colOutput,2:end)-muY)./sigY;

% loading the network model
load lstm_1c_256_0.005_nnet.mat


numTimestepsTest = size(XTest,2);
YOpenPred = [];
deviation = [];

% Making Predicitons and smoothing the predictions
for i = 1:numTimestepsTest
    [net, YOpenPred(i)] = predictAndUpdateState(net, XTest(:,i));
    
    deviation(i) = sigY*(YOpenPred(i)-XTest(2,i));

    if (-stepsize<deviation(i))&&(deviation(i)<stepsize)
        YOpenPred(i) = XTest(2,i);
    end
    

end



YOpenPred = sigY.*YOpenPred + muY;
TUnstandardized = sigY.*YTest + muY;

% Giving input to variables for confusion matrix
for i = 2:numTimestepsTest

    if ((YOpenPred(i)-TUnstandardized(i-1))>-20)&&((YOpenPred(i)-TUnstandardized(i-1))<20)
        pred_change_array = [pred_change_array; "No Change"];
    elseif (YOpenPred(i)-TUnstandardized(i-1))>0
        pred_change_array = [pred_change_array; "Increase"];
    else 
        pred_change_array = [pred_change_array; "Decrease"];
    end

    if ((TUnstandardized(i)-TUnstandardized(i-1))>-20)&&((TUnstandardized(i)-TUnstandardized(i-1))<20)
        act_change_array = [act_change_array; "No Change"];
    elseif (TUnstandardized(i)-TUnstandardized(i-1))>0
        act_change_array = [act_change_array; "Increase"];
    else
        act_change_array = [act_change_array; "Decrease"];
    end
end
rmse = sqrt(mean((YOpenPred-TUnstandardized).^2));

% Visualization of the predictions with the Test data
figure(1);
set(gcf, 'Name', 'Scheduled Power Generation Prediction');
plot(YtimeDataTest, TUnstandardized);
hold on; 
plot(YtimeDataTest, YOpenPred, 'r--');
hold off;
xlabel("Time Stamp");
ylabel("Scheduled Generation");
title("Scheduled Generation in MW");
legend(["Observed" "Foreccasted"]);

% Confusion Matrix 
figure(3);
%plotconfusion(TUnstandardized,YOpenPred);
cm = confusionchart(act_change_array,pred_change_array);
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
cm.Title = 'Confusion Matrix';


%{
% Visualizing the predictions
net = resetState(net);
hist = 10;
figure;
for i=hist:size(XTest,2)
    yp = predict(net,XTest(:,i-hist+1:i),'SequencePaddingDirection','left');
    ya = YTest(i);
    hold on;
    plot(YtimeDataTest(i), sigY*yp(end)+muY, 'rx');
    plot(YtimeDataTest(i), sigY*ya+muY, '-bx');
    %ylim([0 3000]);
    %axis([YtimeDataTest(i-10) YtimeDataTest(i+10) 0 3000]);    
    hold off;
    pause(0.5);
end
%}
