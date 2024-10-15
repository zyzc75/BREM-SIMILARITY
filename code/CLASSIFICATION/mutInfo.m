function z = mutInfo(x, y)
    % 确保向量长度相同
    if length(x) ~= length(y)
        error('向量x和y的长度必须相同');
    end
    
    % 定义分箱的数量
    numBins = 20;
    
    % 使用histc函数计算每个向量的概率分布
    [~, nx] = histc(x, 1:numBins);
    [~, ny] = histc(y, 1:numBins);
    nx = nx / sum(nx);
    ny = ny / sum(ny);
    
    % 初始化联合概率分布矩阵
    joint = zeros(numBins, numBins);
    
    % 计算联合概率分布
    for i = 1:length(x)
        binX = min(numBins, ceil(x(i)/max(x)/numBins)); % 将x(i)映射到对应的bin
        binY = min(numBins, ceil(y(i)/max(y)/numBins)); % 将y(i)映射到对应的bin
        joint(binX, binY) = joint(binX, binY) + 1;
    end
    joint = joint / sum(sum(joint));
    
    % 避免除以零
    joint(joint == 0) = eps;
    
    % 计算互信息
    z = sum(sum(joint .* log2(joint./(nx' * ny))));

