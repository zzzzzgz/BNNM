#UTF-8


MAIN_MOD:=module()
    export Start,run;
    
    
    Start:=proc(i):
        local j,k,p,q;
        #下面两个是不含alpha，beta，gamma的KPBBM含u方程和含f的方程
        #local NPDE:=(u)->diff(u, x, t) + diff(u, x, x) - diff(u^2, x, x) + diff(u, x, x, x, t) + diff(u, y, y);
        #local KPBBM:=(f)->-2*f*diff(f, x, t) + 2*diff(f, x)*diff(f, t) + 2*f*diff(f, x, x) - 2*diff(f, x)^2 + f*diff(f, y, y) - diff(f, y)^2 + f*diff(f, x, x, x, t) - 3*diff(f, x)*diff(f, x, x, t) + 3*diff(f, x, x)*diff(f, x, t) - diff(f, t)*diff(f, x, x, x);
        #下面两个是含alpha，beta，gamma的KPBBM含u方程和含f的方程
      
        local NPDE_KP:=(u)->diff(u, [x,t]) + 6*diff(u,x)^2 + 6*u*diff(u, [x,x]) + diff(u, [x$4]) + 3*alpha*diff(u, [y,y]);
        local KP:=(f)->2*diff(f, [t, x])*f-2*diff(f, x)*diff(f, t)+2*diff(f, [x, x, x, x])*f-8*diff(f, [x, x, x])*diff(f, x)+6*diff(f, [x, x])^2+3*alpha*(2*diff(f,[y, y])*f - 2*diff(f, y)^2);

        local NPDE_NEW_KP:=(u)->diff(diff(u, t) +6*u*diff(u,x) +diff(u, [x,x,x]),x)+diff(u,[y,y]);
        local NEW_KP:=(f)->f*(diff(f, [x, t])+diff(f, [x,x,x,x])+diff(f, [y,y]))-(diff(f, x)*diff(f, t)+4*diff(f, x)*diff(f, [x,x,x])-3*diff(f, [x,x])*diff(f, [x,x])+diff(f, [y,y])*diff(f, [y,y]));
        #logarithmic transformation
        local trans:=(f)->2*diff(log(f), [x, x]);
        #Initialization of neural network layer，make sure that the last layer is [(k)->k]；
        local l1:=[(k)->k],l2:=[(k)->k],l3:=[(k)->k];
        local input_table:= table([log_trans=trans,ufunction=NPDE_KP,bfunction=KP,var=[t,x,y],other_parameter=[alpha]]);
        read "main.mpl";#单次循环
        read "text_data.mpl";#放网络结构类型的
        #for i to 7 do 
            local testnet:=netarr[i],testlayer:=[1,2,3];    #i是选定的神经网络结构，例i=2，netarr[2]=[3,4,1]；
            input_table[net]:=testnet;                      #                            input_table[net]=[3,4,1]；
            for j to numelems(netarr[i])-2 do               #                            numelems(netarr[i])=3  3-2=1             
                if netarr[i][j+1]=2 then                    #                                
                    testlayer[j]:=layer2;
                elif netarr[i][j+1]=3 then
                    testlayer[j]:=layer3;
                elif netarr[i][j+1]=4 then                  
                    testlayer[j]:=layer4;                   #                            testlayer[1]:=layer4 (in text_data.mpl) layer4:=[lay4_1,lay4_2,lay4_3,lay4_4,lay4_5,lay4_6,lay4_7,...]
                elif netarr[i][j+1]=5 then
                    testlayer[j]:=layer5;
                end if;
            end do;
            #print(testlayer);
            

            if numelems(testnet)=3 then #single hidden layer
                for p to numelems(testlayer[1]) do
                    input_table[lay1]:= testlayer[1][p];
                    input_table[lay2]:= l2;
                    run(input_table,120);
                end do;
            elif numelems(netarr[i])=4 then #double hidden layer
                for p to numelems(testlayer[1]) do
                    for q to numelems(testlayer[2]) do
                        input_table[lay1]:= testlayer[1][p];
                        input_table[lay2]:= testlayer[2][q];
                        input_table[lay3]:= l3;
                        run(input_table,120);                   
                    end do;
                end do;
            end if;
            printf("Finish!");
        #end do;




        # local input_table:= table([log_trans=trans,ufunction=NPDE,bfunction=KPBBM,var=[t,x,y],net=testnet,lay1=l1,lay2=l2,lay3=l3]);
        # NEW_BNNM:-Main_function(input_table);
	end proc:

    run:=proc(input_table,time_limit)
        local t1:=0;
        try
            print(input_table);
            timelimit(time_limit,NEW_BNNM:-Main_function(input_table));    #set a time limit for each iteration
        catch "numeric exception" :
            t1++;                                 #防止分母为0的报错 
            print("random number with a zero denominator.");
            print("retry count",t1);
            run(input_table,time_limit);
        catch "time expired":                                       #超时      
            print("overtime.");
        end try;
    end proc:

end module: