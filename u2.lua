
--for k,v in pairs(os.date("*t",os.time())) do   	print(k,v); end

--local curDate=os.date("*t",os.time());
--for k,v in pairs (curDate) do print (k,v) ; end

--local nmFirstDay=os.time{year=curDate.year, month=curDate.month+1, day=1,}

--print (nmFirstDay);

--local nmFirstDay2=os.time{year=curDate.year, month=curDate.month+1, day=2,}

--print (nmFirstDay2-nmFirstDay);  -->86400



local date={};                                        --日期时间变量集合
date.curDay=os.date("*t",os.time());    --当前日期时间

date.curMonthFirstDayS  =os.time{year=date.curDay.year, month=date.curDay.month, day=1,hour=0};         --当月1号秒数
date.nextMonthFirstDayS=os.time{year=date.curDay.year, month=date.curDay.month+1, day=1,hour=0};   --次月1号秒数



date.curMonthFirstDay=os.date("*t",date.curMonthFirstDayS);     --当月1号日期表  --wday西历星期天/七为1, 周六为7 中历-1循环
date.nextMonthFirstDay=os.date("*t",date.nextMonthFirstDayS);  --次月1号日期表

--本月最后一个自然交易日

local wdays={  [2]=function() return 3 end; [3]=function() return 1 end; [4]=function() return 1 end; 
						[5]=function() return 1 end; [6]=function() return 1 end; [7]=function() return 1 end; 
						[1]=function() return 2 end; }

--print(wdays[1]())  -->4

date.curMonthLastTradeDay=os.date("*t", date.nextMonthFirstDayS-3600*24*wdays[date.nextMonthFirstDay.wday]()  );


--三层table嵌套打印
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


