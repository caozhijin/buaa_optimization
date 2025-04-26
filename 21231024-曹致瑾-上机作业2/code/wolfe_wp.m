%����������wolf׼���������������������wolf׼�������������

function result = wolfe_wp(f,g,x,d) %�����x��x��k�����ֵ
    alpha = 0.5;%��ʼ����
    rho = 1e-30; %wolfe�㷨����
    sigma = 1 - 1e-5; %wolfe�㷨����
    flag = 0;%ѭ���жϱ�־
    
    a_min = 0; 
    b_max = inf;
    
    f_old = f(x);
    g_old = g(x);
    value1 = f_old + rho*((g_old)'*d)*alpha;
    value3 = sigma*((g_old)'*d);
    
    while flag == 0
        x_new = x + alpha*d;
        f_new = f(x_new);
        g_new = g(x_new);
        
        value0 = f_new;
        value2 = (g_new)'*d;
        
        if value0 <= value1
            if value2 >= value3
                flag = 1;
            else
                a_min = alpha;
                alpha = min(2*alpha,(alpha + b_max)/2);
            end
        else
            b_max = alpha;
            alpha = (alpha+a_min)/2;
        end
        
    end
    result = alpha;
end

