%混合newton主函数

problem = 26; %问题序号

%混合newton主函数
get_problem; %运行脚本，加载对应序号下的问题

line_search_method = 2; %线搜索方法序号，wolfe为1，powerful_wolfe为2，gll为3

use_gm_correction = 1; %是否采用gm修正，是为1，不采用则为0

epsilon = 10^(-8); %迭代精度参数

flag = 0;
k = 1;
while flag == 0
    f_old = double(subs(f,a,x(:,k)));
    g_old = double(subs(g,a,x(:,k)));
    h_old = double(subs(h,a,x(:,k)));
    
%%%%%%%%%%求下降方向d
    
    if use_gm_correction == 1 %求牛顿方向
        h_old = gill_murray_correction(h_old,n);
    end
        
    if rcond(h_old) < 10^(-8) %判断矩阵是否接近奇异，是则取负梯度方向为d
        d(:,k) = -g_old;
    else
        d(:,k) = -inv(h_old)*g_old;
        factor_1 = 0.3; %判断是否为下降方向参数
        factor_2 = 0.1; %判断下降方向是否与梯度方向正交参数
        norm_g_old = norm(g_old);
        norm_d_k = norm(d(:,k));
        decrease = (g_old)'*d(:,k);
        if decrease > factor_1*norm_g_old*norm_d_k %判断是否非下降方向，是则取d反方向为d
            d(:,k) = -d(:,k);
        end
        if abs(decrease) <= factor_2*norm_g_old*norm_d_k %判断下降方向是否与梯度方向正交，是则取负梯度方向为d
            d(:,k) = -g_old;
        end
    end
    
%%%%%%%%%%求线搜索步长alpha
    if line_search_method == 1
        alpha = wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 2
        alpha = powerful_wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 3
        m = 5;
        alpha = gll(f,g,a,x,d(:,k),m,k);
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
