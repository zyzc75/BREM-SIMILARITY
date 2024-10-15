function matrix = getFeatures(inputSignal)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[c,l]=wavedec(inputSignal,4,'db4'); 
sr = 128;
a5=wrcoef('a',c,l,'db4',4); % 0-4
d5=wrcoef('d',c,l,'db4',4); % 4-8
d4=wrcoef('d',c,l,'db4',3); % 8-16
d3=wrcoef('d',c,l,'db4',2); % 16-32
d2=wrcoef('d',c,l,'db4',1); % 32-64

bands = [d2;d3;d4;d5;a5];

matrix = zeros(5,6); % 返回的矩阵
    for i = 1 : 5
        % matrix(i,1) = approximateEntropy(bands(i,:));
        % matrix(i,2) = FuzzyEntropy(bands(i,:),2,0.15,2,1);
        % matrix(i,3) = SampleEntropy(bands(i,:));
        % matrix(i,4) = PermutationEntropy(bands(i,:));
        matrix(i,5) = SingularSpectrumEntropy(bands(i,:),2,1);
        matrix(i,6) = SpectrumEntropy(bands(i,:),sr);
    end

end