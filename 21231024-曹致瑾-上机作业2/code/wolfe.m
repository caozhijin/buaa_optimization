%����������wolf׼���������������������wolf׼�������������

function result = wolfe(f,g,x,d) %�����x��x��k�����ֵ
    alpha = 1;%��ʼ����
    index = 0.6; %��������ϵ��
    rho = 0.0001; %wolfe�㷨����
    sigma = 0.9; %wolfe�㷨����
    flag = 0;%ѭ���жϱ�־
    
    f_old = f(x);
    g_old = g(x);
    value1 = f_old + rho*((g_old)'*d)*alpha;
    value3 = sigma*((g_old)'*d);
    
    while flag == 0
        alpha = alpha*index; %��ʼ����Ϊ0.5
        x_new = x + alpha*d;
        
        f_new = f(x_new);
        g_new = g(x_new);
        
        value0 = f_new;
        value2 = (g_new)'*d;
        flag = logical((value0 <= value1)&&(value2 >= value3));
    end
    result = alpha;
end
