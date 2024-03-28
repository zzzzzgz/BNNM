NEW_BNNM:=module()
    export Main_function,constructure,coff_solve,solutions_proc,function_indets,rand_sub,judge_proc,plot_proc;
    local coefficient_name_table:=table([]),coefficient_value_table:=table([]);
    local coeffsolword,count1:=1,flited:=0,n:=1,flited_notsuit:=0,flited_uvar:=0,flited_I:=0,solution_number,need_b:=1,exp_judge:=0;
    ###exp_judge: if we need to convert trigonometric functions into exponential form;  
    ####need_b: choose if we need bias_unit, if need_b:=2,need all the bias_unit;   if need_b:=1,need all the bias_unit except the b in last layer;   if need_b:=0 ,we dont need b.
    Main_function:=proc(input_table)
        coefficient_value_table:=table([]);
        flited:=0;flited_notsuit:=0;flited_uvar:=0;flited_I:=0;count1:=1;
        local i,u_value,figure1,f_coefficient,numerp1;
        #print(input_table[log_trans]);
        local f_constructure:=constructure(input_table);
        print(f_constructure);
        #Bilinear form with the neural network structure
        local f_total:=input_table[bfunction](f_constructure):
        if exp_judge=1 then
            local p1:=convert(f_total,exp);
            numerp1:=numer(p1);
            f_total:=numerp1;
        end if;
        #The indeted functions of bilinear form
        local ind_functions:=function_indets(input_table,f_total); 
        #printf("indets functions:");
        #print(ind_functions);
        local union_ind_fun:=ind_functions union convert(input_table[var],set);
        #solve the list 解提取的系数的方程组，得到系数解solutions
        f_total:=expand(f_total,op(ind_functions));
        local solutions:=coff_solve(input_table,union_ind_fun,f_total);
        solution_number:=numelems({solutions});
        for i in solutions do
            #coefficient_name_table:=table([]);
            #coefficient_value_table:=table([]);
            coeffsolword:="";

            #subs the coefficient into the expression for f,obtain f_coefficient with coefficient relationship
            f_coefficient:=subs(i,f_constructure);
            #preliminary screening here to avoid excessive computation
            #f_coefficient=0的话直接筛除（如果不筛除会导致后面分母为0报错），不为0则进行接下来的运算
            if simplify(f_coefficient)<>0 then
                judge_proc(f_coefficient,input_table,i);
                else
                    flited_uvar++;
                    flited++;
            end if;

        end do;
        printf("number of solutions:%d \t flited solutions:%d.\n",solution_number,flited);
        printf("u=0/f=0/miss varibles:%d; have roots:%d; not suitable solution:%d.",flited_uvar,flited_I,flited_notsuit);
        #solutions_proc(solutions,f_constructure);
        

	end proc:

    #make the construction of the network
    constructure:=proc(input_table)
        local f_express:=0,first_neural:=1,last_neural:=input_table[net][2],previous_neural,need_b:=1;
        local w,i,j,k,m,neural_list,output_b:=0;

        if need_b=2 then
            need_b:=need_b-1;
            output_b:=1;
        end if;

        #constructure of the first hidden layer
        for i to input_table[net][2] do
            local neural:=0;
            for j in input_table[var] do
                local weight_coff:=cat(w,j,i);                
                coefficient_name_table[count1]:=weight_coff;# Record all the coefficients used in order in the coefficient_name_table;
                count1++;  
                neural:=neural+weight_coff*j;# Record the neural in the first layer;
            end do;
            #collect the bias unit in order;
            if need_b>0 then
                neural:=neural+cat(b,need_b);
                coefficient_name_table[count1]:=cat(b,need_b);
                need_b++;
                count1++; 
            end if;
            #record each neural unit in neural_list;
            neural_list[i]:=input_table[lay1][i](neural);
        end do;
        
        #constructure of the other hidden layer
        #for example: get input_table[net]:=[3,3,2,1] -> for k to 2 do ; input_table[net]:=[3,4,2,2,1] -> for k to 3 do;
        for k to numelems(input_table[net])-2 do #k=1,2 ; k=1,2,3
            i:=input_table[net][k+2];#i=2,1 ; i=3,4,5
            previous_neural:=last_neural-first_neural+1; # previous_neural := the number of neural units in the last layer
            first_neural:=last_neural+1; # first_neural := the order of the first neural unit in the new layer
            last_neural:=last_neural+i; # last_neural := the order of the last neural unit in the new layer
            for j from first_neural to last_neural do
                local neural:=0;
                for m from first_neural-previous_neural to first_neural-1 do
                    local weight_coff:=cat(w,m,j);
                    coefficient_name_table[count1]:=weight_coff;
                    count1++;
                    neural:=neural+weight_coff*neural_list[m];
                end do;
                if need_b>0 then
                    #if we come to the end of the loop, we get the expression of f,which is named f_express, and we dont need a bias unit;
                    if (k=numelems(input_table[net])-2 and j=last_neural) then
                        neural_list[j]:=input_table[cat(lay,k+1)][j-first_neural+1](neural);
                        f_express:=neural_list[j];
                    #in other situations, we add a bias unit;
                    else
                        neural:=neural+cat(b,need_b);
                        coefficient_name_table[count1]:=cat(b,need_b);
                        count1++; 
                        need_b++;
                    end if;
                end if;
                # neural_list subs() the activation functions 
                neural_list[j]:=input_table[cat(lay,k+1)][j-first_neural+1](neural);
            end do;
        end do;
        if output_b=1 then
            f_express:=f_express+b;
            coefficient_name_table[count1]:=b;
            count1++;
        end if;
        

        #add other parameter
        for w in input_table[other_parameter] do
            coefficient_name_table[count1]:=w;
            count1++;
        end do;
        return f_express;
       
    end proc:

    #indet function 
    function_indets:=proc(input_table,functions)
        local tolfun:=indets(functions,function);
       
       
    end proc:

    # solve the list 提取的系数的方程组
    coff_solve:=proc(input_table,ind_functions,f_total)
        local list1:=coeffs(collect(f_total, ind_functions, distributed), ind_functions):#coefficient
        local list2:=remove(has, f_total, ind_functions);#constant
        local besol:=convert(coefficient_name_table,set);
        local varsol:=besol minus convert(input_table[other_parameter],set);
        local sol:=solve({list1,list2},varsol,maxsols = 20): #convert(coefficient_name_table,list);
    end proc:

    #主要功能：1.判断误差ferror/uerror；2.筛选解flag_1=0为合格解，=1则筛去;3.将筛选过的解进行接下来的画图模块；4.记录筛选解的数量flited_uvar/flited_I/flited_notsuit分别为u，f=0/含虚根/缺少变量或者函数结构
    judge_proc:=proc(f_coefficient,input_table,coe_solution)
        local vars,flag_1:=0,flag_2,f_value,u_coefficient,u_value,ferror,uerror,uerrorplot,n1,m;
        f_value:=rand_sub(f_coefficient,1);
        u_value:=input_table[log_trans](f_value);
        u_coefficient:=input_table[log_trans](f_coefficient);
        if numelems(convert(f_coefficient, string))>5000 then
            flag_1:=1;
            flited_notsuit++;
        end if;
        
        # about error:cost a lot of time
        # ferror:=simplify(input_table[bfunction](f_coefficient)):
        # uerror:=simplify(input_table[ufunction](u_coefficient)):
        # ferror:=subs(coe_solution,ferror):
        # uerror:=subs(coe_solution,uerror):
        # ferror:=subs(x=1,y=2,t=4,ferror);
        # uerror:=subs(x=1,y=2,t=4,uerror);
        # print(ferror,uerror);
        # ferror:=rand_sub(ferror,0);
        # uerror:=rand_sub(ferror,0);

        if flag_1=0 then
            for vars in input_table[var] do
                if has(f_coefficient,vars)=false or uvalue=0 then
                    flited_uvar++;
                    flag_1:=1;
                end if;       
            end do;
            if hasfun(f_coefficient, RootOf) or has(f_coefficient, I) then
                    flited_I++;
                    flag_1:=1;
            end if;
            

            #if have more than 2 of those functions
            flag_2:=selectfun(f_value,{cos,cosh,sinh,sin,exp,tanh,tan,cot,coth});
            for m in flag_2 do
                if has(m,input_table[var])=false then
                    flag_2:=flag_2 minus {m};
                end if;
            end do;
            if numelems(flag_2)<2 then
                if has(expand(f_coefficient),x^2)=false then
                    flag_1:=1;
                    flited_notsuit++;
                end if;
            end if;#有两个x 进行筛选/以上方式多加一个平方项 
        end if;


        if flag_1=0 then
            printf(%d,n);
            n++;
            print("f with no random coeff:",f_coefficient);
            print("u with no random coeff:",u_coefficient);
            print("coefficient solution:",coe_solution);
            print(coeffsolword);                                    #带入画图的未定系数解的定值
            # print("The error of f:",ferror,"error of u:",uerror);
            plot_proc(f_value,u_value,input_table);
            print("_______________________");
            else
            #print("Illegal expression");   
            flited++;            
        end if;      
        
    end proc:

    #取随机数带入解f=xxxx中
    #Taking random numbers into solution f (which is named f_coefficient)
    rand_sub:=proc(f_coefficient,flag_m)
        local ii,rand1,f_randcoeff;
        f_randcoeff:=f_coefficient;
        for ii to count1-1 do
            rand1:=rand(1 .. 8);
            coefficient_value_table[ii]:=rand1();           
            f_randcoeff:=subs({coefficient_name_table[ii]=coefficient_value_table[ii]},f_randcoeff);
            if flag_m=1 then
                coeffsolword:=cat(coeffsolword,coefficient_name_table[ii],"=",coefficient_value_table[ii],",");
            end if;
        end do; 
        return f_randcoeff;
    end proc:


    #plot procdure
    plot_proc:=proc(fvalue,uvalue,input_table)
        local figure1;
                if numelems(input_table[var])=2 then
                    try
                        figure1:=plot([subs({t = -1}, u), subs({t = 0}, u), subs({t = 1}, uvalue)], x = -20 .. 20, color = ["Red", "Green", "Blue"]);
                        print(figure1);
                    catch :
                        print("Print error!");
                        error
                    end try;              
                elif numelems(input_table[var])=3 then
                    try
                        figure1:=plot3d(subs({t = 1}, uvalue),x = -20 .. 20, y = -20 .. 20);
                        print(figure1);
                    catch :
                        print("Print error!");
                        error
                    end try; 
                elif numelems(input_table[var])=4 then
                    try
                        figure1:=plot3d(subs({t = 1,z=1}, uvalue),x = -20 .. 20, y = -20 .. 20);
                        print(figure1);
                    catch :
                        print("Print error!");
                        error
                    end try;     
                end if;
    end proc:

end module: