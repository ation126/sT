
--for k,v in pairs(os.date("*t",os.time())) do   	print(k,v); end

--local curDate=os.date("*t",os.time());
--for k,v in pairs (curDate) do print (k,v) ; end

--local nmFirstDay=os.time{year=curDate.year, month=curDate.month+1, day=1,}

--print (nmFirstDay);

--local nmFirstDay2=os.time{year=curDate.year, month=curDate.month+1, day=2,}

--print (nmFirstDay2-nmFirstDay);  -->86400



local date={};                                        --����ʱ���������
date.curDay=os.date("*t",os.time());    --��ǰ����ʱ��

date.curMonthFirstDayS  =os.time{year=date.curDay.year, month=date.curDay.month, day=1,hour=0};         --����1������
date.nextMonthFirstDayS=os.time{year=date.curDay.year, month=date.curDay.month+1, day=1,hour=0};   --����1������



date.curMonthFirstDay=os.date("*t",date.curMonthFirstDayS);     --����1�����ڱ�  --wday����������/��Ϊ1, ����Ϊ7 ����-1ѭ��
date.nextMonthFirstDay=os.date("*t",date.nextMonthFirstDayS);  --����1�����ڱ�

--�������һ����Ȼ������

local wdays={  [2]=function() return 3 end; [3]=function() return 1 end; [4]=function() return 1 end; 
						[5]=function() return 1 end; [6]=function() return 1 end; [7]=function() return 1 end; 
						[1]=function() return 2 end; }

--print(wdays[1]())  -->4

date.curMonthLastTradeDay=os.date("*t", date.nextMonthFirstDayS-3600*24*wdays[date.nextMonthFirstDay.wday]()  );


--����tableǶ�״�ӡ
function Print(var,varName)
	if varName then print(varName.."={");  else print("{");  end
	for k,v in pairs (var) do
		if type(v)=="table" then 
			print("\t"..k.."=={");
			for l,w in pairs (v) do 
				
				if type(w)=="table" then 
					print("\t"..l.."==={");
					for m,w in pairs(w) do 
						print("\t",m,w);
					end
					print("\t".."}");
				else print("\t",l,w);
				end
				
			end
			print("\t".."}");
		else print("\t"..k,v);
		end
	end
	print("}");
end


Print(date,"date");
--Print(date);

--Print(date.curMonthLastTradeDay)


