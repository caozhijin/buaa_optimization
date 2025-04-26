%�����ڴ�BFGS������

problem = 28; %�������

n = 1000; 

get_f_g;%���нű������ض�Ӧ����µ�����

m = 30;%�洢��Ϣ����

%�ڴ����
max_k = m + 1;
x = zeros(n,max_k);
s = zeros(n,m);
y = zeros(n,m);
rho_h = zeros(1,m);
f_value = zeros(1,max_k);
g_value = zeros(n,max_k);

get_x0; %���нű������ض�Ӧ�����µĳ�ʼֵ

epsilon = 10^(-6); %�������Ȳ���

flag = 0;%�Ƿ�����ֹ������־
k = 1;%ѭ������

f_value(1) = f_function(x(:,1));
g_value(:,1) = g_function(x(:,1));

d = -g_value(:,1);%��ʼ����Ϊ���ݶȷ���

while flag == 0
  
    if k >= m
        bound = m;
    else
        bound = k;
    end
    
%%%%%%%%%%������������alpha,����ǿwolfe׼��
    alpha = wolfe_wp(f_function,g_function,x(:,bound),d);
    
%%%%%%%%%%����x
    x(:,bound + 1) = x(:,bound) + alpha*d;
    f_value(bound + 1) = f_function(x(:,bound + 1));
    g_value(:,bound + 1) = g_function(x(:,bound + 1));

%%%%%%%%%%��d(:,k+1)    
    s(:,bound) = x(:,bound+1) - x(:,bound);
    y(:,bound) = g_value(:,bound+1) - g_value(:,bound);
    rho_h(bound) = 1/(s(:,bound)'*y(:,bound));

    q = -g_value(:,bound + 1);
    for i=bound:-1:1
        alpha_h(i) = rho_h(i)*(s(:,i)')*q;
        q = q - alpha_h(i)*y(:,i);
    end
    r = q;
    for i=1:1:bound
        beta_h = rho_h(i)*(y(:,i)')*r;
        r = r + s(:,i)*(alpha_h(i)-beta_h);
    end
    d = r;
    
%%%%%%%%%%�ж���ֹ����
    value1 = norm(g_value(:,bound + 1));
    flag = logical(value1 <= epsilon);
    
%%%%%%%%%%����
    x(:,1:bound) = x(:,2:(bound + 1));
    f_value(1:bound) = f_value(2:(bound + 1));
    g_value(:,1:bound) = g_value(:,2:(bound + 1));
    s(:,1:(bound - 1)) = s(:,2:bound);
    y(:,1:(bound - 1)) = y(:,2:bound);
    rho_h(:,1:(bound - 1)) = rho_h(2:bound);
    k = k + 1;
end

result_x = x(:,bound);
result_fx = f_value(bound);
result_norm_gx = value1;
