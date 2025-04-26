%FR������

problem = 21; %�������

n = 1000; 

get_f_g;%���нű������ض�Ӧ����µ�����

%�ڴ����
max_k = 2;
x = zeros(n,max_k);
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
  
%%%%%%%%%%������������alpha,����ǿwolfe׼��
    alpha = wolfe(f_function,g_function,x(:,1),d);
    
%%%%%%%%%%����x
    x(:,2) = x(:,1) + alpha*d;
    f_value(2) = f_function(x(:,2));
    g_value(:,2) = g_function(x(:,2));

%%%%%%%%%%��d(:,k+1)
    beta = (g_value(:,2)'*g_value(:,2))/(g_value(:,1)'*g_value(:,1));
    d = -g_value(:,2) + beta*d;
    
%%%%%%%%%%�ж���ֹ����
    value1 = norm(g_value(:,2));
    flag = logical(value1 <= epsilon);
    
%%%%%%%%%%����
    x(:,1) = x(:,2);
    f_value(1) = f_value(2);
    g_value(:,1) = g_value(:,2);
    k = k + 1;
end

result_x = x(:,1);
result_fx = f_value(1);
result_norm_gx = value1;
