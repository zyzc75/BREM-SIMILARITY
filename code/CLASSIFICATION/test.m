load featuresMatrixSplit.mat   %特征矩阵 每种切片有不同的特征矩阵
load ALable.mat    % Arousal唤醒度的分类标签
load VLable.mat    % Valence唤醒度的分类标签

N = 1;   % 代表时间切片数量 5s->N=12,10s->N=6....
methods = 4; %  方法从1-4 1代表dtw 2代表mutinfo 3代表spearman 4代表jaccard

testNums = 40;
channelNums = 32;   % 当channelNums=32代表单通道 channelNums=5代表单区域
subjectNums = 32;
A_ACC = cell(1,N);
for p = 1 : N
    acc = cell(channelNums,subjectNums);
    featuresMatrix = featuresMatrixSplit{1,p};
    parfor channelNo = 1 : channelNums
        for subjectNo = 1 : subjectNums
            Y = ALable{1,subjectNo}';
            lidx = find( Y == 0);
            hidx = find( Y == 1);
            % 遍历两个正负样本
            result = zeros(1,4);
            count2 = 1;
            for i = 1 : length(lidx)
                for j = 1 : length(hidx)
                    large_value = realmax('double');  % MATLAB中双精度浮点数的最大值
                    ltemp = featuresMatrix{1,subjectNo};
                    ltemp = ltemp{lidx(i),channelNo};
                    htemp = featuresMatrix{1,subjectNo};
                    htemp = htemp{hidx(j),channelNo};
                    ltemp(isinf(ltemp)) = large_value;
                    htemp(isinf(htemp)) = large_value;
                    count = 1;
                    real_lables = zeros(1,testNums-2);
                    pred_lables = zeros(1,testNums-2);
                    for m = 1 : testNums
                        % 遍历正负样本之外的其他样本
                        if m ~= lidx(i) && m ~= hidx(j)
                            xtemp = featuresMatrix{1,subjectNo};
                            xtemp = xtemp{m,channelNo};
                            real_lables(count) = Y(1,m);
                            if methods == 1 % 使用dtw
                                ldist = dtw(ltemp,xtemp);
                                hdist = dtw(htemp,xtemp);
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            elseif methods == 2 % 使用mutInfo
                                ldist = mutInfo(ltemp(:),xtemp(:));
                                hdist = mutInfo(htemp(:),xtemp(:));
                                if abs(ldist) > abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            elseif methods == 3       % 使用spearman
                                ldist = pdist2(ltemp,xtemp,'spearman');
                                hdist = pdist2(htemp,xtemp,'spearman');
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            else        % 使用jaccard
                                ldist = pdist2(ltemp,xtemp,'jaccard');
                                hdist = pdist2(htemp,xtemp,'jaccard');
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            end

                            count = count + 1;
                        end
                    end
                    TN = 0;
                    TP = 0;
                    FN = 0;
                    FP = 0;
                    % 获取TN\TP\FN\FP
                    for mm = 1 : length(real_lables)
                        if real_lables(mm) == 1
                            if pred_lables(mm) == 1
                                TP = TP + 1;
                            else
                                FP = FP + 1;
                            end
                        else
                            if pred_lables(mm) == 0
                                TN = TN + 1;
                            else
                                FN = FN + 1;
                            end
                        end
                    end
                    % 统计该次实验的结果
                    result(count2,1) =  (TN+TP) / (TN+FN+TP+FP);    %ACC
                    result(count2,2) =  TP / (FN+TP);               %SEN
                    result(count2,3) =  TN / (TN+FP);               %SPE
                    result(count2,4) =  2*TP / (2*TP+FP+FN);        %F1
                    count2 = count2 + 1;
                end
            end
            acc{channelNo,subjectNo} = result
        end
    end
    A_ACC{1,p} = acc; 
end

V_ACC = cell(1,N);
for p = 1 : N
    acc = cell(channelNums,subjectNums);
    featuresMatrix = featuresMatrixSplit{1,p};
    parfor channelNo = 1 : channelNums
        for subjectNo = 1 : subjectNums
            Y = VLable{1,subjectNo}';
            lidx = find( Y == 0);
            hidx = find( Y == 1);
            % 遍历两个正负样本
            result = zeros(1,4);
            count2 = 1;
            for i = 1 : length(lidx)
                for j = 1 : length(hidx)
                    large_value = realmax('double');  % MATLAB中双精度浮点数的最大值
                    ltemp = featuresMatrix{1,subjectNo};
                    ltemp = ltemp{lidx(i),channelNo};
                    htemp = featuresMatrix{1,subjectNo};
                    htemp = htemp{hidx(j),channelNo};
                    ltemp(isinf(ltemp)) = large_value;
                    htemp(isinf(htemp)) = large_value;
                    count = 1;
                    real_lables = zeros(1,testNums-2);
                    pred_lables = zeros(1,testNums-2);
                    for m = 1 : testNums
                        % 遍历正负样本之外的其他样本
                        if m ~= lidx(i) && m ~= hidx(j)
                            xtemp = featuresMatrix{1,subjectNo};
                            xtemp = xtemp{m,channelNo};
                            real_lables(count) = Y(1,m);
                            if methods == 1 % 使用dtw
                                ldist = dtw(ltemp,xtemp);
                                hdist = dtw(htemp,xtemp);
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            elseif methods == 2 % 使用mutInfo
                                ldist = mutInfo(ltemp(:),xtemp(:));
                                hdist = mutInfo(htemp(:),xtemp(:));
                                if abs(ldist) > abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            elseif methods == 3       % 使用spearman
                                ldist = pdist2(ltemp,xtemp,'spearman');
                                hdist = pdist2(htemp,xtemp,'spearman');
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            else        % 使用jaccard
                                ldist = pdist2(ltemp,xtemp,'jaccard');
                                hdist = pdist2(htemp,xtemp,'jaccard');
                                if abs(ldist) < abs(hdist)
                                    pred_lables(1,count) = 0;
                                else
                                    pred_lables(1,count) = 1;
                                end
                            end

                            count = count + 1;
                        end
                    end
                    TN = 0;
                    TP = 0;
                    FN = 0;
                    FP = 0;
                    % 获取TN\TP\FN\FP
                    for mm = 1 : length(real_lables)
                        if real_lables(mm) == 1
                            if pred_lables(mm) == 1
                                TP = TP + 1;
                            else
                                FP = FP + 1;
                            end
                        else
                            if pred_lables(mm) == 0
                                TN = TN + 1;
                            else
                                FN = FN + 1;
                            end
                        end
                    end
                    % 统计该次实验的结果
                    result(count2,1) =  (TN+TP) / (TN+FN+TP+FP);    %ACC
                    result(count2,2) =  TP / (FN+TP);               %SEN
                    result(count2,3) =  TN / (TN+FP);               %SPE
                    result(count2,4) =  2*TP / (2*TP+FP+FN);        %F1
                    count2 = count2 + 1;
                end
            end
            acc{channelNo,subjectNo} = result
        end
    end
    V_ACC{1,p} = acc; 
end


save("result","A_ACC","V_ACC");
