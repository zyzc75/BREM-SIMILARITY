load featuresMatrixSplit.mat
channel = ["Fp1","AF3","F3","F7","FC5","FC1","C3","T7","CP5","CP1","P3","P7","PO3","O1","Oz","Pz","Fp2","AF4","Fz","F4","F8","FC6","FC2","Cz","C4","T8","CP6","CP2","P4","P8","PO4","O2"];
Fregion = [1,17,2,18,19,3,20];
Cregion = [5,6,7,22,23,24,25];
Pregion = [9,10,11,27,28,29,16];
Tregion = [4,8,21,26,12,30];
Oregion = [13,14,15,31,32];

REGION = {Fregion;Cregion;Pregion;Tregion;Oregion};
clearvars -except REGION featuresMatrixSplit

M = 5;
N = 12;
testNums = 40;
subjectNums = 32;
channelNums = 32;
featuresMatrixSplitTemp = cell(1,N);
for p = 1 : N
    featuresMatrix = featuresMatrixSplit{1,p};
    for s = 1 : subjectNums
        % 遍历每一个区域
        % 将区域的特征矩阵融合在一起
        for i = 1 : M
           featuresMatrixtemp = featuresMatrix{1,s};
           for t = 1 : testNums
            % 遍历每一次实验
                fusionMatrix = [];
                % 将所涉及的区域拼接在一起
                for r = 1 : length(REGION{i,1})
                    idx = REGION{i,1}(r);
                    tt = featuresMatrixtemp{t,idx};
                    fusionMatrix = [fusionMatrix,tt];
                end
                temp{t,i} = fusionMatrix;
           end
        end
        TEMP{1,s} = temp;
    end
    featuresMatrixSplitTemp{1,p} = TEMP;
end

featuresMatrixSplit = featuresMatrixSplitTemp;

save("featuresMatrixSplit.mat","featuresMatrixSplit");