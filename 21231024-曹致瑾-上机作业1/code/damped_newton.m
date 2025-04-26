%阻尼newton主函数
clear all;

problem = 32; %问题序号

get_problem; %运行脚本，加载对应序号下的问题

line_search_method = 2; %线搜索方法序号，wolfe为1，powerful_wolfe为2，gll为3

use_gm_correction = 1; %是否采用gm修正，是为1，不采用则为0

epsilon = 10^(-8); %迭代精度参数

flag = 0;%是否达成终止条件标志
k = 1;%循环次数

while flag == 0
    f_old = double(subs(f,a,x(:,k)));
    g_old = double(subs(g,a,x(:,k)));
    h_old = double(subs(h,a,x(:,k)));
    
%%%%%%%%%%求下降方向d
    if use_gm_correction == 1 %求牛顿方向
        h_old = gill_murray_correction(h_old,n);
        d(:,k) = -inv(h_old)*g_old;
    else
        d(:,k) = -inv(h_old)*g_old;
    end
    
%%%%%%%%%%求线搜索步长alpha
    if line_search_method == 1
        alpha = wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 2
        alpha = powerful_wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 3
        M = 15;
        alpha = gll(f,g,a,x,d(:,k),M,k);
    end
    
%%%%%%%%%%更新x，判断终止条件
    x(:,k + 1) = x(:,k) + alpha*d(:,k);
    f_new = double(subs(f,a,x(:,k + 1)));
    value0 = abs(f_new - f_old);
    value1 = norm(g_old);
    
    flag = logical((value0 <= epsilon)&&(value1 <= epsilon));
    if flag == 0
        k = k + 1;
    end
end
result = x(:,k);
