%函数，利用gll准则进行线搜索，返回满足gll准则的线搜索步长

function result = gll(f,g,a,x,d,m,k) %这里的x是x（1：k）的点列，m为考察的点数限制
    alpha = 1;%初始步长
    index = 0.6; %缩减步长系数
    rho = 0.0001; %gll算法参数
    flag = 0;%循环判断标志
    len = k;%前回溯个数
    
    f_max = double(subs(f,a,x(:,len)));
    
    if ( len < m ) %判断要考察函数值的个数,求出这些值中的最大值
        n = len - 1; 
    else
        n = m - 1;
    end  
    for i =0:1:n
        f_older =double(subs(f,a,x(:,len - i)));
        if f_older > f_max
            f_max = f_older;
        end
    end
    
    while flag == 0
        alpha = alpha*index; %初始步长为0.5
        x_new = x(:,k) + alpha*d;
        
        f_new = double(subs(f,a,x_new));
        g_old = double(subs(g,a,x(:,k)));
        
        value0 = f_new;
        value1 = f_max + rho*((g_old)'*d)*alpha;
        flag = logical(value0 <= value1);
    end
    result = alpha;
end