%����������wolf׼���������������������wolf׼�������������

function result = wolfe(f,g,a,x,d) %�����x��x��k�����ֵ
    alpha = 1;%��ʼ����
    index = 0.5; %��������ϵ��
    rho = 0.0001; %wolfe�㷨����
    sigma = 0.9; %wolfe�㷨����
    flag = 0;%ѭ���жϱ�־
    while flag == 0
        alpha = alpha*index; %��ʼ����Ϊ0.5
        x_new = x + alpha*d;
        
        f_old = double(subs(f,a,x));
        f_new = double(subs(f,a,x_new));
        g_old = double(subs(g,a,x));
        g_new = double(subs(g,a,x_new));
        
        value0 = f_new;
        value1 = f_old + rho*((g_old)'*d)*alpha;
        value2 = (g_new)'*d;
        value3 = sigma*((g_old)'*d);
        flag = logical((value0 <= value1)&&(value2 >= value3));
    end
    result = alpha;
end