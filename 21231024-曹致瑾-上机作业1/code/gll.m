%����������gll׼���������������������gll׼�������������

function result = gll(f,g,a,x,d,m,k) %�����x��x��1��k���ĵ��У�mΪ����ĵ�������
    alpha = 1;%��ʼ����
    index = 0.6; %��������ϵ��
    rho = 0.0001; %gll�㷨����
    flag = 0;%ѭ���жϱ�־
    len = k;%ǰ���ݸ���
    
    f_max = double(subs(f,a,x(:,len)));
    
    if ( len < m ) %�ж�Ҫ���캯��ֵ�ĸ���,�����Щֵ�е����ֵ
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
        alpha = alpha*index; %��ʼ����Ϊ0.5
        x_new = x(:,k) + alpha*d;
        
        f_new = double(subs(f,a,x_new));
        g_old = double(subs(g,a,x(:,k)));
        
        value0 = f_new;
        value1 = f_max + rho*((g_old)'*d)*alpha;
        flag = logical(value0 <= value1);
    end
    result = alpha;
end