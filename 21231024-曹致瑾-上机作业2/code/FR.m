%FR主函数

problem = 21; %问题序号

n = 1000; 

get_f_g;%运行脚本，加载对应序号下的问题

%内存分配
max_k = 2;
x = zeros(n,max_k);
f_value = zeros(1,max_k);
g_value = zeros(n,max_k);

get_x0; %运行脚本，加载对应问题下的初始值

epsilon = 10^(-6); %迭代精度参数

flag = 0;%是否达成终止条件标志
k = 1;%循环次数

f_value(1) = f_function(x(:,1));
g_value(:,1) = g_function(x(:,1));
d = -g_value(:,1);%初始方向为负梯度方向

while flag == 0
  
%%%%%%%%%%求线搜索步长alpha,采用强wolfe准则
    alpha = wolfe(f_function,g_function,x(:,1),d);
    
%%%%%%%%%%更新x
    x(:,2) = x(:,1) + alpha*d;
    f_value(2) = f_function(x(:,2));
    g_value(:,2) = g_function(x(:,2));

%%%%%%%%%%求d(:,k+1)
    beta = (g_value(:,2)'*g_value(:,2))/(g_value(:,1)'*g_value(:,1));
    d = -g_value(:,2) + beta*d;
    
%%%%%%%%%%判断终止条件
    value1 = norm(g_value(:,2));
    flag = logical(value1 <= epsilon);
    
%%%%%%%%%%更新
    x(:,1) = x(:,2);
    f_value(1) = f_value(2);
    g_value(:,1) = g_value(:,2);
    k = k + 1;
end

result_x = x(:,1);
result_fx = f_value(1);
result_norm_gx = value1;
