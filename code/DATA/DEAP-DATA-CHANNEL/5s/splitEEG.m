%%%%%%%%%%%% 用于切割信号 %%%%%%%%%%%%%%%%% 统一输出未splitdata; 输入未data;
load data.mat;  % DEAP数据库脑电信号，是一个32病人*40次试验的元组，每个元素是一个7680*32的信号集合
% 遍历32个人
length = 7680;
splitSize = 5;  % 代表切片时间为5s
FS = 128;
N = length / (splitSize * FS);
splitdata = cell(1,N);
% 将60s切割成每一段都是10s
for m = 1 : N
    eeg = cell(32,40);
    for i = 1 : 32
        % 遍历每个人的每次实验
        for j = 1 : 40
            % 将每次实验从一分钟分割为十秒
            temp = data{i,j};   % 单个人单次实验共计32个通道长度为7680的EEG
            eeg{i,j} = temp((m-1)*splitSize*FS+1:m*splitSize*FS,:);
        end
    end
    splitdata{1,m} = eeg;
end