%脚本，加载所需要求解的问题函数及其初值
problem = 25;

if problem == 21
    n = 100;
    m = n;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    for k=1:1:m
        r = mod(k,2);
        if (r == 1)
            f(k) = 10*(a(k + 1) - a(k)^2);
        else
            f(k) = 1 - a(k - 1);
        end
    end
    
    f = (norm(f))^2;
    f_function = matlabFunction(f, 'Vars',{a});
    g = gradient(f,a); 
    g_function = matlabFunction(g, 'Vars',{a});
    
elseif problem == 25
    n = 10000;
    m = n + 2;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    for k=1:1:n
        f(k) = a(k) - 1;
    end
    
    t = zeros(n,1);
    for k=1:1:n
        t(k) = k;
    end
    f(n + 1) = t'*f(1:n);
    f(n + 2) = f(n + 1)^2;
    
%     比较简单原始的生成方式
%     f = (norm(f))^2;
%     f_function = matlabFunction(f, 'Vars',{a});
%     g = gradient(f,a);
%     g_function = matlabFunction(g, 'Vars',{a});

%随着n增大，25题函数的特性使得匿名函数复杂而难以计算，如果依然采用原始方法，p25_n500.mat为3888kb，p25_n1000.mat为15236kb
%因此利用25题函数本身的特点，采用下面的方式简化生成 ，注：简化生成只是依据优化过程，不影响结果   
    f_function_1ton = matlabFunction(f(1:n), 'Vars',{a});
    f_function_n1 = matlabFunction(f(n + 1), 'Vars',{a});
    
    f = (norm(f))^2;
    f_function = matlabFunction(f, 'Vars',{a});
    g_function = @(in1)2*f_function_1ton(in1) + 2*t*f_function_n1(in1) + 4*t*(f_function_n1(in1)^3);
    
elseif problem == 28
    n = 1000;
    m = n;
    a=sym('a',[n,1]);
    f = sym('f',[m,1]);
    
    for k=1:1:n
        h = 1/(n + 1);
        t = k*h;
        if k == 1
            f(k) = 2*a(k) - a(k+1) + (h^2)*((a(k) + t + 1)^3)/2;
        elseif k == n
            f(k) = 2*a(k) - a(k-1) + (h^2)*((a(k) + t + 1)^3)/2;
        else
            f(k) = 2*a(k) - a(k-1) - a(k+1) + (h^2)*((a(k) + t + 1)^3)/2;
        end
    end
    
    f = (norm(f))^2;
    f_function = matlabFunction(f, 'Vars',{a});
    
    g = gradient(f,a);
    g_function = matlabFunction(g, 'Vars',{a});
    
%     g=sym('g',[n,1]);
%     for k=1:1:n
%         g(k) = diff(f,a(k));
%     end 
%     g_function = matlabFunction(g, 'Vars',{a});

end
