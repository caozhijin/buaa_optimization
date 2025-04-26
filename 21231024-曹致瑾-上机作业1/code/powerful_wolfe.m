%函数，利用强wolf准则进行线搜索，返回满足强wolf准则的线搜索步长

function result = powerful_wolfe(f,g,a,x,d) %这里的x是x（k）点的值
    alpha = 1;%初始步长
    index = 0.6; %缩减步长系数
    rho = 0.0001; %强wolfe算法参数
    sigma = 0.9; %强wolfe算法参数
    flag = 0;%循环判断标志
    while flag == 0
        alpha = alpha*index; %初始步长为0.5
        x_new = x + alpha*d;
        
        f_old = double(subs(f,a,x));
        f_new = double(subs(f,a,x_new));
        g_old = double(subs(g,a,x));
        g_new = double(subs(g,a,x_new));
        
        value0 = f_new;
        value1 = f_old + rho*((g_old)'*d)*alpha;
        value2 = abs((g_new)'*d);
        value3 = -sigma*((g_old)'*d);
        flag = logical((value0 <= value1)&&(value2 <= value3));
    end
    result = alpha;
end
