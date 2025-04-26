%���newton������

problem = 26; %�������

%���newton������
get_problem; %���нű������ض�Ӧ����µ�����

line_search_method = 2; %������������ţ�wolfeΪ1��powerful_wolfeΪ2��gllΪ3

use_gm_correction = 1; %�Ƿ����gm��������Ϊ1����������Ϊ0

epsilon = 10^(-8); %�������Ȳ���

flag = 0;
k = 1;
while flag == 0
    f_old = double(subs(f,a,x(:,k)));
    g_old = double(subs(g,a,x(:,k)));
    h_old = double(subs(h,a,x(:,k)));
    
%%%%%%%%%%���½�����d
    
    if use_gm_correction == 1 %��ţ�ٷ���
        h_old = gill_murray_correction(h_old,n);
    end
        
    if rcond(h_old) < 10^(-8) %�жϾ����Ƿ�ӽ����죬����ȡ���ݶȷ���Ϊd
        d(:,k) = -g_old;
    else
        d(:,k) = -inv(h_old)*g_old;
        factor_1 = 0.3; %�ж��Ƿ�Ϊ�½��������
        factor_2 = 0.1; %�ж��½������Ƿ����ݶȷ�����������
        norm_g_old = norm(g_old);
        norm_d_k = norm(d(:,k));
        decrease = (g_old)'*d(:,k);
        if decrease > factor_1*norm_g_old*norm_d_k %�ж��Ƿ���½���������ȡd������Ϊd
            d(:,k) = -d(:,k);
        end
        if abs(decrease) <= factor_2*norm_g_old*norm_d_k %�ж��½������Ƿ����ݶȷ�������������ȡ���ݶȷ���Ϊd
            d(:,k) = -g_old;
        end
    end
    
%%%%%%%%%%������������alpha
    if line_search_method == 1
        alpha = wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 2
        alpha = powerful_wolfe(f,g,a,x(:,k),d(:,k));
    elseif line_search_method == 3
        m = 5;
        alpha = gll(f,g,a,x,d(:,k),m,k);
    end
    
%%%%%%%%%%����x���ж���ֹ����
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
