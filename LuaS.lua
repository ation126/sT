

---------------------------ȫ�ֻ���--------------------------------

--[[

print("\n","-----------------_G---------------------------");

for k,v in pairs(_G) do
	print(k,v);
end

s
print("\n","-----------------_G.table---------------------------");

for k,v in pairs(_G.table) do
	print(k,v);
end


print("\n","-----------------_G.io---------------------------");

for k,v in pairs(_G.io) do
	print(k,v);
end

print("\n","-----------------_G.coroutine---------------------------");

for k,v in pairs(_G.coroutine) do
	print(k,v);
end

print("\n","-----------------_G.string---------------------------");
for k,v in pairs(_G.string) do
	print(k,v);
end


print("\n","-----------------_G.package---------------------------");
for k,v in pairs(_G.package) do
	print(k,v);
end

print("\n","-----------------_G.os---------------------------");
for k,v in pairs(_G.os) do
	print(k,v);
end

print("\n","-----------------_G.math---------------------------");
for k,v in pairs(_G.math) do
	print(k,v);
end


print("\n","-----------------_G.debug---------------------------");
for k,v in pairs(_G.debug) do
	print(k,v);
end


do           --  clunk

for k, v in pairs(_G) do print(k, v) end

end
--]]


--[[
do           --  clunk
print "��֧ IF-ElseIF-ElseIF-End"

local age=40      -- �ֲ�����
local sex="Male"

--age = io.read()

if age == 40 and sex =="Male" then
    print("������ʮһ֦��")
elseif age > 60 and sex ~="Female" then
    print("old man without country!")
elseif age < 20 then
    io.write("too young, too naive!\n")
else
    local age = io.read()
    print("Your age is "..age)
end

end

--]]


----------------------------------------ʱ�������� ��֧ switch---------------------------------
--[[
switch={}
switch[1]=function() return 'һ��' end
switch[2]=function() return '����' end
switch[3]=function() return '����' end
switch[4]=function() return '����' end
switch[5]=function() return '����' end
switch[6]=function() return '����' end
switch[7]=function() return '����' end
switch[8]=function() return '����' end
switch[9]=function() return '����' end
switch[10]=function() return 'ʮ��' end
switch[11]=function() return 'ʮһ��' end
switch[12]=function() return 'ʮ����' end

print(switch[1]())  -->һ��
--]]

--[[
local switch = {
    [1] = function()    -- for case 1
        print "Case 1."
    end,
    [2] = function()    -- for case 2
        print "Case 2."
    end,
    [3] = function()    -- for case 3
        print "Case 3."
    end
}

local a = 3
local f = switch[a]
if(f) then
    f()
else                -- for case default
    print "Case default."
end
--]]


--------------------------------���� dofile/require/loadstring------------------------------

--dofile()�������ļ����벢ִ��,dofileÿ�ζ�Ҫ����, ������λ��������������ʵ���书�ܵ���loadfile()
--loadfile()�����������м��룬���ر����chunk��Ϊ��������ִ�д��룬���׳�������Ϣ�����ش������nil������һ�Σ����ɶ������
--loadstring()����������Ĳ���chunk�����Ǵ�һ�����ж��룻 ���д���Ļ���Ҳ�����׳����󣬶��Ƿ��ش������nil��
--loadstring��loadfile����������߽�ЧӦ�����ǽ����Ǳ��룬�����Ƕ���chunk��Ϊ�Լ��ڲ���һ������������
--require ��������һ��ģ��ʱ���ڱ�package.loaded�в����Ƿ���ڣ��еĻ��ͷ��ظ�ֵ��
--loadfile�Ὣ�ļ��������������أ�require�Ὣģ������Ϊ���������ú��������з���ֵ�򽫷���ֵ�����package.loaded�С���û���򷵻ر�package.loaded�е�ֵ��
--module ������

--[[
module ��mymodule��
local modname = ��mymodule��  --����ģ����
local M = {}                  --�������ڷ��ص�ģ���
_G[modname] = M               --��ģ�����뵽ȫ�ֱ�����
package.loaded[modname] = M  --��ģ�����뵽package.loaded�У���ֹ��μ���
setfenv(1,M)                  --��ģ�������Ϊ�����Ļ�������ʹ��ģ�������в���������ģ����У����庯����ֱ�Ӷ�����ģ�����

--]]


-------------------------���� �ļ� ģ�� �ַ��� require dofie loadfile  loadstring load module ---------------------------

--[[
do
--mod.lua ������ģ��   ����M��


local M = {}
local function sayMyName()
  print('Hrunkner.Mod.Local')
end

function M.sayHello()
  print('Why hello there, Public')
  sayMyName()
end


return M

end
--]]


--[[
--���غ��� mod.lua (ͬĿ¼)

require('mod').sayHello()  -- require Only Once �����ļ�mod.lua  --return M{}
dofile('mod.lua').sayHello()     -- dofile  Once/Again ����(���)�ļ�mod.lua (���ļ���) --return M{}
loadfile('mod.lua') ().sayHello()  --load & Not Run
loadstring('print(343)') ()  --����һ������

--]]


--[[
do
-- BeRequired.lua
print(" require �÷� ʵ�� ")

--˽�к���
local function myPrivateFunction()
  print("this is a private function!")
end
--���нӿ�
function Vprint()
  myPrivateFunction()
  print("this is a public function!")
  print("This is a required package!")
  print("\n")

end
Vprint()
--��ʶ���� ����һ����
complex = {Vprint = Vprint}

end
--]]

--[[
do
-- main.lua
print(" require �÷� ʵ�� ")

package.path = package.path .. ";?.lua"     --ģ��ʽ��·�� ?�ĵط���require�����л��
print(package.path)

local requiredpackage = require("BeRequired")  --�����Ǳ����Ҫ�ġ�

print(requiredpackage,'\n')

function Vprint()
print("main print!",'\n')
end
Vprint()  -- main print

local requirecomplex = {}  --����һ������
requirecomplex = complex  --�����ö���
requirecomplex.Vprint()  --require�ж���

end
--]]



----------------------------------------ʱ�������� Time/Date--------------------

--[[
do           --  clunk

print(os.time{year=1971, month=1, day=1, hour=0})                   -->31507200  ����ʱ��
print(os.time{year=1971, month=1, day=1, hour=0, sec=1})            -->31507201  ����ʱ��
print(os.time{year=1971, month=1, day=1, hour=0, minute=1, sec=1})  -->31510801  ����ʱ��
print(os.time{year=1970, month=1, day=1})                           -->14400  ��ʼʱ�� 1970.01.01

print(os.time() );                        -->1403084206  �ղ���:Ĭ�ϱ���ϵͳʱ��(�ۼ����� ʼ1970.01.01)
print(os.date("%c",os.time() ) );        -->06/18/14 17:36:46  date����ʱ���ʽ��� time���� ������
print(os.date("%Y%m%d %X",os.time() ) ); -->20140618 17:46:41
--  %a-weekday:Wed  %A-weekday:Wednesday  %b-month:Sep  %B-month:September  %c-date&time:09/16/9823:48:10
--  %d-day:01-31  %H-hour24:00-23  %I-hour12:01-12  %M-minute:00-59  %m-month:00-12  %p-am\pm:pm  %S-second:00-61
--  %w-weekday:0-6  %x-date:09/16/98  %X-time:23:48:10  %Y-year4:1998  %y-year2:00-99  %%-%

for k,v in pairs(os.date("*t",os.time())) do   	print(k,v); end
 --> һά���  [hour]=17,[min]=36,[wday]=4,[day]=18,[month]=6,[year]=2014,[sec]=46,[yday]=169,[isdst]=FALSE

end
--]]

---------------------------------------------------�ַ��� string--------------------------------------------

--[=[


--�ַ�����ʽ�� format
-- ʮ����'d'��ʮ������'x'���˽���'o'��������'f'���ַ���'s'
print( string.format("%%c:%c",83) )      -->S%c:����תASCII�ַ�
print( string.format("%+d",17.0) )       -->+17%d:����ת��������
print( string.format("%05d",17) )        -->00017
print( string.format("%o",17) )          -->21%o:����ת8����
print( string.format("%u",3.14) )        -->3%u:����ת�޷�������
print( string.format("%x",13) )          -->d%x,%X(��д) ����ת16����
print( string.format("%e",1000) )        -->1.000000e+03%e,%E(��д) ����ת��ѧ��¼��
print( string.format("%6.3f",13) )       -->13.000%f,����ת����
print( string.format("%q","One\nTwo") )  -->"One \n Two"%g,%G����ת�̸�ʽ
print( string.format("%s","monkey") )    -->monkey%s, �ַ�����ʽ
print( string.format("%10s","monkey") )  -->monkey
print( string.format("%5.3s","monkey") ) -->mon

print( string.byte("[in brackets]", 2) ) -->105  byte(string [,pos]) ��pos���ַ���������ʾ��ʽ(ASCII��).��iΪ105.ͬ��posΪ���ǵ�������
print( string.char(97,105) ) -->ai  char(i1,i2...):i1,i2Ϊ����,��i1,i2..��ת��Ϊ��Ӧ���ַ�Ȼ�����ӳ��ַ���,������.��i1=97�򷵻�a��
print( string.len("Hello World") )    -->11           �ַ���s�ĳ��ȣ�
print( string.rep("a", 2^10) )        -->1Kb �ַ���   �ظ�n���ַ���s�Ĵ�
print( string.lower("Hello World") )  -->hello world  Сд
print( string.upper("Hello World") )  -->HELLO WORLD  ��д
print( string.reverse("Hello World")) -->dlroW olleH  ����
--table.sort(a, function (a, b) return string.lower(a) < string.lower(b) end) --��������: ��Сд�޹�
print( string.sub("[in brackets]", 2, -2) ) --> in brackets sub(s,i,[j]) ��ȡs�Ĵ�i��j��, -i��ʾ�����ڼ�λ, [j]Ĭ��-1

print( string.gsub("Lua is cute", "cute", "great") )   --> Lua is great
--string.gsub("ԭ�ַ���", "Ҫ�ҵ��ַ���", "ϣ���滻�ɵ��ַ���", [n�滻����])��д�滻����������»�ȫ���滻
--����ģʽƥ��: ��������ֵ ���� �滻����ַ������滻ִ�д���
print( string.gsub("all lii", "l", "x") )              --> axx xii
print( string.gsub("Lua is great", "perl", "tcl") )    --> Lua is great
--print( string.dump(functoin) ) --���ظ��������Ķ����Ʊ�ʾ���ַ�����֮��������Ӧ��loadstring���غ����Ŀ�����function�����ǲ���upvalue��Lua������
--function test()  print("just a test") end ; local sd = string.dump(test) ; local ls = loadstring(sd) ; ls() ;

print( string.find("hello world", "hello") )                             --> 1    5
print( string.sub("hello world", string.find("hello world", "hello"))) --> hello �������ַ���������ȫһ�������ַ���
print(string.find("hello world", "lll") )      --> nil  plain:true ���ر���ʽ��ƥ��ģʽ,��Ϊ�޸�ʽƥ��
--string.find("ԭ�ַ���", "Ҫ�ҵ��ַ���", [n��ʼλ��(֧�ָ�����) [,plain] ]) ��������ֵ: ��ʼ�����ͽ�β����

print( string.match("My birthday is 8/4/1991!", "%d+/%d+/%d+") )  -->8/4/1991  ����ģʽƥ��:���ַ���date���ҳ��ض���ʽ����Ϣ
--string.math("ԭ�ַ���", "Ҫ�ҵ��ַ���")��Ҳ�����ַ���������������ע�ص���ģʽƥ����ǲ������ַ���


--ģʽƥ��
-- .�����ַ�    %a��ĸ    %c�����ַ�    %d����    %lСд��ĸ    %p����ַ�    %s�հ׷�    %u��д��ĸ    %w��ĸ������    %xʮ����������    %z����0���ַ�
-- +1�λ��� *0�λ��� -0�λ���(���ƥ��) ?0�λ�1��   ê��^��ʼ��, ê��$������. ����^MYADDON:.+��ʾ��MYADDON:��ͷ���ַ���
-- �����ַ� ( ) . % + - * ? [ ^ $   '%' ת���ַ�  '%.' ƥ���  '%%' ƥ���ַ� '%'

--string.gmatch(str, pattern): ���ص���������
--[[ ��ʾÿ������
s = "hello world from Lua"
local tbWords = {}
for w in string.gmatch(s, "%a+") do tbWords[#tbWords + 1] = w  end
for _, val in pairs(tbWords) do  print(val) end
--]]

--string.gfind(s,pat):���ַ���s�в���ƥ������pat�����ַ���
--[[  �ռ�һ���ַ��������еĵ��ʣ�Ȼ����뵽һ������
local words = {}
local s="hello hi, again!";
for w in string.gfind(s, "%a") do
    table.insert(words, w)
end
--]]


----------------string split���� ------------------------------------
--[[
function Split(szFullString, szSeparator)
local nFindStartIndex = 1
local nSplitIndex = 1
local nSplitArray = {}
while true do
   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
   if not nFindLastIndex then
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
    break
   end
   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
   nSplitIndex = nSplitIndex + 1
end
return nSplitArray
end
--����
local str = "1234,389,abc";
local list = Split(str, ",");
for i = 1, #list
do
	str = string.format("index %d: value = %s", i, list[i]);
	print(str);
end


string.split = function(s, p)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end


--ʹ������һ
local str = 'abc,123,hello,ok'
local list = string.split(str, ',')
for _, s in ipairs(list�� do
    print(s)
end

--�����
abc
123
hello
ok


--ʹ�����Ӷ�
local str = 'abc \n123 \t hello ok'
local list = string.split(str, '%s')
for _, s in ipairs(list�� do
    print(s)
end

--�����
--abc
--123
--hello
--ok



--]]



--]=]




-------------------------------------------�ļ�����-------------------------------------

--[[
do
-- �ƺ���֧�ִ��ļ�(���ܳ���9k?)
function FileSaveLoad()
      local file = io.open("c:\\in.lua", "r");
      assert(file);
      local data = file:read("*a"); -- ��ȡ��������
      file:close();
      file = io.open("c:\\out.lua", "w");
      assert(file);
      file:write(data);
      file:close();
end
FileSaveLoad();

-------------------------------��ѭ�������----------------------------------------------


HERO = 1;
MONSTER = 2;
BUILDING = 3;
SUMUNIT = 4;
cha = {};
cha[1] =
{
      basic =
      {
      Name = "ũ��",    --NPC����
      cha_type = HERO,  --NPCģ��
      },
      combat =
      {
       acquire = 600.00,  --����������Χ
       basic_def = 10,   --��������
      },
};

function SaveTableContent(file, obj)
      local szType = type(obj);
      print(szType);
      if szType == "number" then
            file:write(obj);
      elseif szType == "string" then
            file:write(string.format("%q", obj));
      elseif szType == "table" then
            --��table�����ݸ�ʽ��д���ļ�
            file:write("{\n");
            for i, v in pairs(obj) do
                  file:write("[");
                  SaveTableContent(file, i);
                  file:write("]=\n");
                  SaveTableContent(file, v);
                  file:write(", \n");
             end
            file:write("}\n");
      else
      error("can't serialize a "..szType);
      end
end

function SaveTable()
      local file = io.open("e:\\00_00_00_������_ѧϰ\\д��.txt", "w");
      assert(file);
      file:write("cha = {}\n");
      file:write("cha[1] = \n");
      SaveTableContent(file, cha[1]);
      file:write("}\n");
      file:close();
end

SaveTable();


end

--]]

----------------------------------------ѭ������---------------------------------

--[[
do           --  clunk

function newCounter()
    local i = 0
    return function()     -- anonymous function
       i = i + 1
        return i
    end
end

local c1 = newCounter()
print(c1())  --> 1
print(c1())  --> 2
print(c1())  --> 3

local sum = 0
local num = 1
while num <= 100 do
    sum = sum + num
    num = num + 1
end
print("sum =",sum)

end
--]]

------------------------------------------��������--------------------------------------

--[[

function pythagorean(a,b) local c2=a^2+b^2 return (c2^0.5) end
print (pythagorean(30,40));

print (math.randomseed(23));

--table ��������
a={p=print};    a.p("hi, aTion","\n")

--]]

------------------------------���� Ƕ������ �Եݹ� �׳� ��������n------------------------------------

--[[
do

-- defines a factorial function
function fact (n)
    if n == 0 then
       return 1
    else
       return n * fact(n-1)
    end
end

print("enter a number:")
a = io.read("*number")      -- read a number
print(fact(a))

end
--]]

----------------------------------------------�����------------------------------------

--[[
print(math.random(100))
print(math.randomseed( os.time() ))
print(math.random());  print(math.random());  print(math.random());
print(math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) ))
--]]

------------------------------------------ģ�⵼��-----------------------------------

--[[

function derviative(f,delta)
	local delta=delta or 1e-4
	return function (x)
		return (f(x+delta)-f(x))/delta
	end
end

local c=derviative(math.sin)
print (math.cos(10),c(10),"\n")


--]]




----------------------------------------------ð��(:)����(.)������--------------------------

--[[
do

--1�������ʱ��Class:test()�� Class.test(self)�ǵȼ۵ģ����(.)Ҫ�ﵽð��(:)��Ч��Ҫ��һ��self��������һ��������
--2�����õ�ʱ��object:test() ��object.test(object)�ȼۣ����(.)Ҫ��Ӷ���������һ��������
--�ܽ᣺���԰ѵ��(.)��Ϊ��̬������������ð��(:)��Ϊ��Ա������������

Class = {}
Class.__index = Class

function Class.new(x,y)
    local cls = {}
    setmetatable(cls, Class)
    cls.x = x
    cls.y = y
    return cls
end
function Class:test()   -- Class:test()�� Class.test(self)�ǵȼ�
    print(self.x,self.y)
end

object = Class.new(10,20)
object:test() ;  object.test(object) ;  -- �ȼ���


end
--]]


-------------------------------------------------------Table---------------------------------------------


--[[
do

print("table ���� ")

tt = {"hello", 55};                                      --���п��Բ�ͬ����  �������͵�ֵ�������������

local function helloWorld()
   print( "Hello World A !" )
end

table = { 10 ,[tt] = "table", 29, ["flag"] = 5, key=11,  3.14,  [6]=6e-3 , 40 , 60, [10]="7K", [11]={1,2,3} , func=helloWorld , function() print( "Hello World B !" ); end,  helloWorld  };

print(table.key);     print(table["key"]);    print(table['key']);   print("\n")  --11 �ȼ�����
print(table["flag"]);    print(table.flag);    print(table['flag']);   print("\n")  --5  �ȼ�����

print(table[1]);    print(table[2]);   print(table[3]);  print(table[4]);   print(table[5]);    print(table[6]) ;   print(table[10]) ;  print(table[11]) ;  print(table[11][3]) ;   print("\n");       --��ע���� ����(��ǰ)��ɾֲ����� 20 ��ע�������, ����ڷ�ע��������  ֵΪtableʱ, ���ص�ַ

print(table[tt]);        --table(��)�����������

table.func();  table[6]() ;  table[7]()    -- Hello World!   table function���� ע���±�

end

--]]



--[[

-----------------------------------------------------Table ����----------------------------------

local tbl = {"alpha", "beta", "gamma", "delta"}
table.sort(tbl)   --������
print(table.concat(tbl, ", ")	,"\n") -- alpha, beta, delta, gamma
print(table.concat(tbl, ": "),"\n")
print(table.concat(tbl, nil, 1, 2))
print(table.concat(tbl, "\n", 2, 3))


table.insert(tbl, "delta")   --����
table.insert(tbl, "epsilon")
table.insert(tbl, 3, "zeta")
print(table.concat(tbl, ", ")	,"\n")


local tb2 = {[1] = "a", [2] = "b", [3] = "c", [26] = "z"}
print(#tb2)   -->3   ��Ϊ26��֮ǰ�����ֲ�����, ���Բ��������鲿����
print(table.maxn(tb2))
tb2[91.32] = true
print(table.maxn(tb2))


-----------------------------------------------------Table ����----------------------------------

function copy_table(ori_tab)
    if type(ori_tab) ~= "table" then
        return
    end
    local new_tab = {}
    for k,v in pairs(ori_tab) do
        local vtype = type(v)
        if vtype == "table" then
            new_tab[k] = copy_table(v)
        else
            new_tab[k] = v
        end
    end
    return new_tab
end

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end




print("-----------------table copy ���Ʊ�--------------")

function copytable(table_a)
  local table_b = {}
  for k, v in pairs(table_a) do
    if type(v) ~= "table" then
      table_b[k] = v
    else
      table_b[k] = copytable(v)
    end
  end
  return table_b
end

a = { a = "ab", b = "rt", c = "rf" , { 8, 2 }  }

b = copytable(a)

--assert(a[1][1] == 8)

table.insert(b,{3,4});

function show_table(b)
	local i = 0
	for k, v in pairs(b) do
		if type(v) ~= "table" then   print(k,":" , v)
		else
			show_table(v)
	  end
	end
end


show_table(b);
print("-------------------------")
show_table(a);




----------------------------Table ToString ���ת�ַ�---------------------

print("\n","-----------TableToString-----------------");

function MultiString(s,n)
	local r=""
	for i=1,n do
		r=r..s
	end
	return r
end
--o ,obj;b use [];n \n;t num \t;
function TableToString(o,n,b,t)
	if type(b) ~= "boolean" and b ~= nil then
		print("expected third argument %s is a boolean", tostring(b))
	end
if(b==nil)then b=true end
t=t or 1
local s=""
if type(o) == "number" or
	type(o) == "function" or
	type(o) == "boolean" or
	type(o) == "nil" then
	s = s..tostring(o)
elseif type(o) == "string" then
	s = s..string.format("%q",o)
elseif type(o) == "table" then
	s = s.."{"
	if(n)then
	s = s.."\n"..MultiString("  ",t)
end
for k,v in pairs(o) do
	if b then
		s = s.."["
	end

	s = s .. TableToString(k,n, b,t+1)

	if b then
		s = s .."]"
	end

	s = s.. " = "
	s = s.. TableToString(v,n, b,t+1)
	s = s .. ","
	if(n)then
	s=s.."\n"..MultiString("  ",t)
end
end
s = s.."}"

end
return s;
end

local ati=TableToString(at,n,b,t);


print(ati);



------------------------Tabel �������keyֵ--------------------------


function MergeTable(ta,tb)
	for m, v in pairs(tb) do
		ta[m]=v;
	end
	for n, val in pairs(ta) do
		print(n.."="..val)
	end
end

local td={szName="aaa",szKey="bbb"}
local te={nAge=15,szFaction="ccc"}

--MergeTable(td,te);


------------------------Tabel �����ݣ�����keyֵ--------------------------

local th={"aaa", 25, "�߻�"}
local ti={"bbb", 24, "����"}
local tj={"ccc", 26, "����"}
local tk={};
local tl={};

table.insert(tk,th);
table.insert(tk,ti);
table.insert(tk,tj);

for i,val in ipairs(tk) do
	local tm={};
	tm.szName=val[1];
	tm.nAge=val[2];
	tm.szTitle=val[3];
	table.insert(tl,tm);
end

for a,v1 in pairs(tl) do
	for b,v2 in pairs(v1) do
		print(a,b.."="..v2);
	end
end

print(tl[1].szTitle)

for k,v in ipairs(tl) do
	--print(k,v);

end


------------------------Tabel ������� ��дPrint--------------------------

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


function Print(obj)
	function PrintTable(obj)
		local getIndent, quoteStr, wrapKey, wrapVal, isArray, dumpObj
		getIndent = function(level)
			return string.rep("\t", level)
		end
		quoteStr = function(str)
			str = string.gsub(str, "[%c\\\"]", {
				["\t"] = "\\t",
				["\r"] = "\\r",
				["\n"] = "\\n",
				["\""] = "\\\"",
				["\\"] = "\\\\",
			})
			return '"' .. str .. '"'
		end
		wrapKey = function(val)
			if type(val) == "number" then
				return "[" .. val .. "]"
			elseif type(val) == "string" then
				return "[" .. quoteStr(val) .. "]"
			else
				return "[" .. tostring(val) .. "]"
			end
		end
		wrapVal = function(val, level)
			if type(val) == "table" then
				return dumpObj(val, level)
			elseif type(val) == "number" then
				return val
			elseif type(val) == "string" then
				return quoteStr(val)
			else
				return tostring(val)
			end
		end
		local isArray = function(arr)
			local count = 0
			for k, v in pairs(arr) do
				count = count + 1
			end
			for i = 1, count do
				if arr[i] == nil then
					return false
				end
			end
			return true, count
		end
		dumpObj = function(obj, level)
			if type(obj) ~= "table" then
				return wrapVal(obj)
			end
			level = level + 1
			local tokens = {}
			tokens[#tokens + 1] = "{"
			local ret, count = isArray(obj)
			if ret then
				for i = 1, count do
					tokens[#tokens + 1] = getIndent(level) .. wrapVal(obj[i], level) .. ","
				end
			else
				for k, v in pairs(obj) do
					tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
				end
			end
			tokens[#tokens + 1] = getIndent(level - 1) .. "}"
			return table.concat(tokens, "\n")
		end
		return dumpObj(obj, 0)
	end

	print(PrintTable(obj));
end


local obj = {
    string1 = "Hi! My name is LiXianlin",
    string2 = "aa\tbb\rcc\ndd\\ee\"ff",
    string3 = "a\\tb\\rc\\n\\\\ee\"ff",
    int = 9527,
    float = 3.1415,
    bool = true,
    array = {
        1, 2, 3,
        {
            a = 21,
            b = 22,
            c = 23,
        },
    },
    table = {
        x = 100,
        y = 200,
        w = 960,
        h = 640,
    },
    [88] = 88888,
    [9.7] = 22222,
}

print("\n","----------------���table����-------------------","\n");

Print(obj);


------------------------table ���� ���� �ݹ����---------------------------------------


table1 = {
    name = "Android Developer",
    email = "hpccns@gmail.com",
    url = "http://blog.csdn.net/hpccn",
    quote = [[
    There are
    10 types of pepole
    who can understand binary.
    ]],--��������
    embeddedTab = {
        em1 = xx,
        x =0,
        {x =1, y =2 } -- ����Ƕtable
    }-- ��Ƕtable
}

tab = "    "
function print_table(t, i)
    local indent ="" -- i��������ǰ��������
    for j = 0, i do
        indent = indent .. tab
    end
    for k, v in pairs(t) do
        if (type(v) == "table") then -- type(v) ��ǰ����ʱ��table ����ǣ�����Ҫ�ݹ飬
            print(indent .. "" .. k .. " is a table ")
            print_table(v, i + 1) -- �ݹ����
            print(indent .. " end table ".. k .. "")
        else -- ����ֱ�������ǰֵ

            print(indent .. "" .. k .. "=" .. v.."")
        end
    end
end


print_table(table1, 0)



print( "-------------------Table(���Ƕ��) ��λ ��value �������� value-------------------"  );


local tbcd=
{
 [1] = {
 ["szName"] = "aaa",
 ["szTitle"] = "�߻�",
 ["nAge"] = 25,
}
,
 [2] = {
 ["szName"] = "bbb",
 ["szTitle"] = "����",
 ["nAge"] = 24,
}
,
 [3] = {
 ["szName"] = "ccc",
 ["szTitle"] = "����",
 ["nAge"] = 26,
}
,
}



local g_t=nil;

for v,k in ipairs(tbcd) do
	for s,j in pairs(k) do
		if j=="����" then
			--print(v,s,j) ;
			g_t=v;
		end
	end
end



print ("-----tbcd[g_t].nAge :-------", tbcd[g_t].nAge);  -->26





--]]




-----------------------------------------------Table ����----------------------------------

--[=[

do

local tbl = {"alpha", "beta", ["one"] = "uno", ["two"] = "dos"}

for key, value in ipairs(tbl) do     -->1 alpha \ 2 beta
print(key, value)                     --ipairs()�������ڱ���table�е����鲿��
end  --������ѭ������Ҫ��tbtest�е�keyΪ˳��ģ��ұش�1��ʼ��ipairsֻ���1��ʼ��������key˳�������key������Ϊֹ

for key, value in pairs(tbl) do       -->1 alpha \ 2 beta \one uno \ two dos
print(key, value)                      --pairs()������������table, ���������鼰�����鲿��
end                 --����˳�򲢷���tb1��table������˳�򣬶��Ǹ���tb1��key��hashֵ���е�˳����������

for i=1, #(tbl) do
print(key, value)
end
--ֻ�ܱ�����tbtest�д���keyΪ1��valueʱ�Ż���ֽ���������ǰ���key��1��ʼ���ε���1��˳�����������ҵ�һ����������1��ʱ��ͽ������ٱ��������ۺ����Ƿ���Ȼ��˳���key

for i=1, table.maxn(tbl) do        --Ч��̫��
print(key, value)
end

function pairsByKeys(t)               --������
    local a = {}
    for n in pairs(t) do
        a[#a+1] = n
    end
    table.sort(a)
    local i = 0
    return function()
    i = i + 1
    return a[i], t[a[i]]
    end
end

for key, value in pairsByKeys(tbl) do
 if nSeq <= key then
 return key
 end
end

end

--]=]


-----------------------------------------------Table ����----------------------------------

--[=[

do
--��ֵ���������ַ�������ֵ����һ��������ǲ���sort��
local test_table = {2,1,3}
table.sort(test_table)
for key,value in pairs(test_table) do
    print(key,value)
end

--> 1   1
--> 2   2
--> 3   3

--�ַ�����������
local test_table = {"a","c","b"}
table.sort(test_table)
for key,value in pairs(test_table) do
    print(key,value)
end

--> 1   a
--> 2   b
--> 3   c

print("-----------������Key����---------------")


--��ֵ��Table���򣨰�Key���򣬲���Value��
local test_table = {a=3,b=2,c=4,d=1,}
local key_table = {}
local value_table={}

for key,_ in pairs(test_table) do     --ȡ�����еļ�
    table.insert(key_table,key)
end

table.sort(key_table)                 --�����м���������

for _,key in pairs(key_table) do
    print(key,test_table[key])
end

--> a   3
--> b   2
--> c   4
--> d	1


table.sort(test_table);                --�����м���������
for k,v in pairs (test_table) do
	--print (k,v)
end



--table.sort(test_table,function(a,b) return(a.a<b.a) end) --��name�Ž���

print("-----------����ֵValue����---(����ѭ��)------------")

for _,value in pairs(test_table) do     --ȡ�����еļ�
    table.insert(value_table,value)
end

table.sort(value_table)                 --�����м���������

for _,value in pairs(value_table) do
	for k,v in pairs(test_table) do
		if v==value then
		print(k,value)
		end
	end
end

-->d	1
-->b	2
-->a	3
-->c	4





local network={
    {name="grauna",IP="210.26.30.34"},
    {name="arraial",IP="210.26.30.23"},
    {name="lua",IP="210.26.23.12"},
    {name="derain",IP="210.26.23.20"},
}

table.sort(network,function(a,b) return(a.name<b.name) end) --��name�Ž���
for k, v in pairs(network) do  print(k, v.name ,v.IP ) end
print("\n")

table.sort(network,function(a,b) return(a.name>b.name) end) --��name������
for k, v in pairs(network) do  print(k, v.name,v.IP) end
print("\n")



local tbl = {"alpha", "beta", "gamma", "delta"}
table.sort(tbl)
print(table.concat(tbl, ", "))  -->alpha, beta, delta, gamma

sortFunc = function(a, b) return b < a end
table.sort(tbl, sortFunc)
print(table.concat(tbl, ", ")) -->gamma, delta, beta, alpha

local guild = {}

table.insert(guild, {
��name = "Cladhaire",
��class = "Rogue",
��level = 70,
})

table.insert(guild, {
��name = "Sagart",
��class = "Priest",
��level = 70,
})

table.insert(guild, {
��name = "Mallaithe",
��class = "Warlock",
��level = 40,
})


function sortLevelNameAsc(a, b)  --���ȼ���������, �ڵȼ���ͬʱ, ��������������
��if a.level == b.level then
����return a.name < b.name
��else
����return a.level < b.level
��end
end


table.sort(guild, sortLevelNameAsc)
for idx, value in ipairs(guild) do print(idx, value.name) end
-->1, Mallaithe
-->2, Cladhaire
-->3, Sagart



end
--]=]


--------------------------------------------�ַ���תtable-------------------------------------

--[[
do;

local a = "{pos=3, name='��Ʒ', color='���ɫ'}"
local b = loadstring("return "..a);
a = b();
print(a.pos, a.name, a.color)  --��Ʒ
end;
--]]


--------------------table ���塢ɾ���Ͳ���ʱ�临�Ӷ�ΪO(1)�ļ���-------------------------

--[[
do

function newset()
     local reverse = {} --������Ϊkey��������set�е�λ��Ϊvalue
     local set = {} --һ�����飬���е�value����Ҫ���������
     return setmetatable(set,{__index = {
          insert = function(set,value)
               if not reverse[value] then
                    table.insert(set,value)
                    reverse[value] = table.getn(set)
               end
          end,

          remove = function(set,value)
               local index = reverse[value]
               if index then
                    reverse[value] = nil
                    local top = table.remove(set) --ɾ�����������һ��Ԫ��
                    if top ~= value then
                         --������Ҫɾ����ֵ�����滻��
                         reverse[top] = index
                         set[index] = top
                    end
               end
          end,

          find = function(set,value)
               local index = reverse[value]
               return (index and true or false)
          end,
     }})
end


local s = newset()
s:insert("hi0")
s:insert("hi1")

for k,V in ipairs(s) do
     print(k,V)                    --> hi0   -->hi1
end

print(s:find("hi0"))     -->true
s:remove("hi0")
print(s:find("hi0"))    -->false

end
--]]

-------------------��ӡ�����͹���ʵ��tableǶ��table-----------------------

--[[
do

local cclog = function( ... )
    local tv = "\n"
    local xn = 0
    local function tvlinet(xn)
        -- body
        for i=1,xn do
            tv = tv.."\t"
        end
    end

    local function printTab(i,v)
        -- body
        if type(v) == "table" then
            tvlinet(xn)
            xn = xn + 1
            tv = tv..""..i..":Table{\n"
            table.foreach(v,printTab)
            tvlinet(xn)
            tv = tv.."}\n"
            xn = xn - 1
        elseif type(v) == nil then
            tvlinet(xn)
            tv = tv..i..":nil\n"
        else
            tvlinet(xn)
            tv = tv..i..":"..tostring(v).."\n"
        end
    end
    local function dumpParam(tab)
        for i=1, #tab do
            if tab[i] == nil then
                tv = tv.."nil\t"
            elseif type(tab[i]) == "table" then
                xn = xn + 1
                tv = tv.."\ntable{\n"
                table.foreach(tab[i],printTab)
                tv = tv.."\t}\n"
            else
                tv = tv..tostring(tab[i]).."\t"
            end
        end
    end
    local x = ...
    if type(x) == "table" then
        table.foreach(x,printTab)
    else
        dumpParam({...})
        -- table.foreach({...},printTab)
    end
    print(tv)
end

    local ttt = {23,aa=23,23,
                    {bbb=23,"dsd",false,nil,
                        {32,ccc="23dd",
                            {23,"sdfsdf",
                                {234,addd="23233jjjjsdOK"}
                            }
                        }
                    },
                    {dd = "sd",23},
                true
                }

    cclog(23,"sdf",ttt,"sdssssf",323223,false)

end
--]]

-------------------------------------------------------Ԫ��---------------------------------------------

--[==[
do

t = {}
print(getmetatable(t))  --��ʾ��Ԫ�� ��ʱ��nil

--������setmetatable�����û��޸��κ�table��Ԫ��
t1 = {}
setmetatable(t,t1)
-- assert(getmetatable(t) == t1, "No Meta")    -- if not n then error("invalid input") end

--��һ��table����Ԫ�� ���ǵ�����ʵ����table�����ʵ�ֵ�����ڵ�ʱ�� �᷵��Ĭ�ϵ�Ԫ�����ֵ, �����������������ļ̳�, Ԫ��������ĸ��� ���������ֵ���ñ����ֵ ûֵ���ø����ֵ
local t = {}
local mt = {7,8,9}
setmetatable(t,{__index = mt}) --��������lua���������, mt�Ǹ��� t������
print(t[3])



--------------------------------------Ԫ�� Ԫ����-------------------------------------
-- table��Ԫ���ṩһ�ֻ��ƣ������ض���table��һЩ����������js��prototype��Ϊ

f1 = {a = 1, b = 2} -- ��ʾһ������ a/b.  1/2
f2 = {a = 2, b = 3}

-- ����Ǵ���ģ�
-- s = f1 + f2

metafraction = {}
function metafraction.__add(f1, f2)
sum = {}
sum.b = f1.b * f2.b
sum.a = f1.a * f2.b + f2.a * f1.b
return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2 -- ������f1��Ԫ���ϵ�__add(f1, f2) ����
 print (s.a.."/"..s.b)  --7/6

-- ����ʽ��ģʽ�� -- Ԫ���__index �������ص�������Ĳ���
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal -- ���Թ�������Ҫ��лԪ���֧��

 print (eatenBy)  --gru

-- ������table��Ԫ������ȫ���嵥��
-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)


-- [[
Set = {}
mt = {} --Ԫ��

function Set.new(l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end


--================================================
function Set.tostring(set)
    local l = {}
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ",") .. "}"
end


function Set.print(s)
    print(Set.tostring(s))
end


--1 ��(__add), ����===============================
function Set.union(a, b)
--[[    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
        error("attemp to 'add' a set with a non-set value", 2)   --error�ڶ��������ĺ���P116
    end]]
    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
--print(getmetatable(s1))
--print(getmetatable(s2))
mt.__add = Set.union

s3 = s1 + s2
--Set.print(s3)

--[[Ԫ�����
s = Set.new{1, 2, 3}
s = s + 8
Set.print(s + 8)
]]

--2 ��(__mul), ����==============================
function Set.intersection(a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

mt.__mul = Set.intersection

--Set.print(s2 * s1)



--3 ��ϵ��===================================NaN�ĸ���====
mt.__le = function(a, b)
    for k in pairs(a) do
        if not b[k] then return false end
    end
return true
end

mt.__lt = function(a, b)
    return a <= b and not (b <= a)
end

mt.__eq = function(a, b)           --��Ȼ����ô�ã���----
    return a <= b and b <= a
end

g1 = Set.new{2, 4, 3}
g2 = Set.new{4, 10, 2}
print(g1 <= g2)
print(g1 < g2)
print(g1 >= g2)
print(g1 > g2)
print(g1 == g1 * g2)

--]]

--============================================
--4 table���ʵ�Ԫ����=========================
-- [[
--__index�йؼ̳еĵ���ʾ��
Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height}
Window.mt = {}

function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end

Window.mt.__index = function (table, key)
    return Window.prototype[key]
end

w = Window.new{x = 10, y = 20}
print(w.width)

--__index�޸�tableĬ��ֵ
function setDefault (t, d)
    local mt = {__index = function () return d end}
    setmetatable(t, mt)
end

tab = {x = 10, y = 20}
print(tab.x, tab.z)
setDefault(tab, 0)
print(tab.x, tab.z)

--]]

--13.4.5 ֻ����table
function readOnly(t)
    local proxy = {}
    local mt = {
    __index = t,
    __newindex = function(t, k, v)
        error("attempt to update a read-only table", 2)
    end
    }
    setmetatable(proxy, mt)
    return proxy
end

days = readOnly{"Sunday", "Monday", "Tuesday", "W", "T", "F", "S"}
print(days[1])
--days[2] = "Noday"   --ֻ����table , ���Ƹ���


------------------------------------------------- �����table�ͼ̳�---------------------------------

Dog = {} -- ��? ��ʵ��ȫ��һ��table

function Dog:new() -- ����tablename:fn(...) �뺯��tablename.fn(self, ...) ��һ����  -- ð�ţ�:��ֻ�������self��Ϊ��һ������
newObj = {sound = 'woof'} -- newObj����Dog��һ��ʵ��
self.__index = self -- selfΪ��ʼ������ʵ����ͨ��self = Dog�������̳й�ϵ���Ըı����, �����newObj��Ԫ���__index������Ϊself�� newObj�Ϳ��Եõ�self�ĺ���
return setmetatable(newObj, self) -- setmetatable�������һ������
end

function Dog:makeSound() -- ð�ţ������ڵ�2���ǹ����ģ�����������������  self��һ��ʵ������������
print('I say ' .. self.sound)
end

mrDog = Dog:new() -- ��Dog.new(Dog)���ƣ����� self = Dog in new().
mrDog:makeSound() -- 'I say woof' -- ��mrDog.makeSound(mrDog)һ��; self = mrDog.


-- �̳е�����

LoudDog = Dog:new() -- LoudDog���Dog�ķ����ͱ����б�

function LoudDog:makeSound()
s = self.sound .. ' ' -- ͨ��new()��self��һ��'sound'��key from new()
print(s .. s .. s)
end

seymour = LoudDog:new() -- ��LoudDog.new(LoudDog)һ�������ұ�ת����  Dog.new(LoudDog)����ΪLoudDogû��'new' ��key��  ����������Ԫ����Կ��� __index = Dog�����: seymour��Ԫ����LoudDog������ LoudDog.__index = LoudDog��������seymour.key =seymour.key, LoudDog.key, Dog.key, Ҫ����Ը�����key��һ��table����ǰ�档

seymour:makeSound() -- 'woof woof woof' -- ��LoudDog�����ҵ�'makeSound'��key������
-- LoudDog.makeSound(seymour)һ��.


-- �����Ҫ������Ҳ������new()�����������ƣ�
function LoudDog:new()
newObj = {}
-- ��ʼ��newObj
self.__index = self
return setmetatable(newObj, self)
end


------------------------------------------��̳�-------------------------

A = {}   --����A

function A:new(o)         --���� A:New(o)�� A.New(self,o)
    o = o or {}
    setmetatable(o,self)   --Ԫ��
    self.__index = self         --__index����������ȷ��һ�����ڱ���ΪԪ��ʱ�Ĳ��ҷ���
    return o
end

function A:funName()
    print('A')
end

--����������������һ������B����ʹ���ܴ�ӡ��������������Ҫ����һ���յ��࣬�ӻ���̳����еĲ�����
B = A:new()

s = B:new()   --B��A�м̳���new������̳���������һ�����������new��ִ��ʱ������self������ʾΪB����ˣ�s��Ԫ��ΪB��B���ֶ�__index��ֵҲ��B��s�̳���B����B�ּ̳���A


function B:funName()   --B��дfunName()����
    print('B')
end

s:funName()    --�������B




end
--]==]


--[[
do
-------------------------�๹��-------------------------

Class = {x=0,y=0}
Class.__index = Class    --�ض���Ԫ�������������Ҫ��
function Class:new(x,y)   --ģ�⹹���壬һ������Ϊnew()
        local self = {}
        setmetatable(self, Class)
        self.x = x
        self.y = y
        return self
end
function Class:test()
    print(self.x,self.y)
end

function Class:gto()  --�¶����һ������gto()
   return 100
end

function Class:gio()
   return self:gto() * 2   --���������gto()
end

function Class:plus()
    self.x = self.x + 1
        self.y = self.y + 1
end

-------------------------��ʵ��-------------------------

objA = Class:new(1,2)
objA:test()                 -->1    2
print(objA.x,objA.y)   --> 1    2

-------------------------��̳�-------------------------

Main = {z=0}   --�������µ�����Z
setmetatable(Main, Class)   --����������Class
Main.__index = Main  --���Ǻ��ඨ��һ�����������趨Ϊ����

function Main:new(x,y,z)   --�����壬������һ���µĲ���
   local self = {}  --��ʼ����������
   self = Class:new(x,y) --�����������趨Ϊ���࣬�������൱���������Ե�super
   setmetatable(self, Main)   --����������Ԫ���趨ΪMain��
   self.z= z   --�µ����Գ�ʼ�������û�н��ᰴ������=0
   return self
end

-------------------------���̬-------------------------


function Main:go()   --����һ���µķ���
   self.x = self.x + 10
end

function Main:test()   --�ض��常��ķ���
    print(self.x,self.y,self.z)
end

-------------------------�����-------------------------

c = Main:new(20,40,100)
c:test()
d = Main:new(10,50,200)
d:go()
d:plus()
d:test()
c:test()

end
--]]


-----------------------------------Url �ָ�----------------------------------------------

--[=[
do

function Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
	    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
	    break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

function parseUrl(url)
	local t1 = nil
	--,
	t1= Split(url,',')

	--?
	url = t1[1]
	t1=Split(t1[1],'?')

	url=t1[2]
	--&

	t1=Split(t1[2],'&')
	local res = {}
	for k,v in pairs(t1) do
		i = 1
		t1 = Split(v,'=')
		res[t1[1]]={}
		res[t1[1]]=t1[2]
		i=i+1
	end
	return res
end


local url = 'http://192.168.1.113:8080/openG3/m/appPanel.vm?appId=1&appkey=111111&sid=12345,game/js/'
local res = parseUrl('http://www.baidu.com')
print('appkey= '..res.appkey)
print('sid= '..res.sid)
print('appid= '..res.appId)

end

--]=]


-------------------------����������ԣ�����������ƽ����ƽ����------------------------------

--[[
--input.lua
print "������һ����"
i=io.read()
a=i^2
b=math.sqrt(i)
print(i .. "��ƽ��=" .. a)
print(i .. "ƽ����=" .. b)
--]]

------------------------------print "��Lua���Ǯ�ټ�������5Ǯ ĸ��3Ǯ ����1/3Ǯ"---------------------

--[[

-- chicken.lua
for a=1,20 do
	for b=1,33 do
		for c=1,100 do
			if a+b+c==100 and 5*a+3*b+1/3*c==100 then
				print ("����" .. a,"ĸ��" .. b,"����" .. c)
			end
		end
	end
end
print "OK"
--io.read()
--]]

------------------------------------��������--------------------------------

--[[

--luacls.lua

a={}
a={"aa","bb","cc","dd"}

for i =1, #a do
	print(a[i])
end
print ("���й���"..#a.."����Ա")

-- clear screen
if os.getenv("OS")=="Windows_NT" then
	os.execute("cls")
end

for i=1,9 do
	print ("this is line "..i)
end

--]]

----------------------д���ļ�------------------------

--[[

--inputfile.lua
--׷�ӷ�ʽ

--myfile=io.open("c:\\namelist.txt","a")
--print(myfile)


for k in myfile:lines() do
  print(k)
end
myfile:close()
--]]


--[[

file = io.open("c:\\namelist.txt","a+")
file:write("1234567890 \n")   --д�ļ�
file:close()


file = io.open("c:\\namelist.txt","r")
for l in file:lines() do   print(l)  end   --���ļ�
file:close()
--]]


--[[

while true do
  io.write("������")
  sname=io.read()
  if sname == "quit" then
    io.close(myfile)
    break
  else
    myfile:write(sname .. "\n")
    print()
  end
end
print("OK!")

--]]

---------------------------�����ı����� --����quit�˳�--------------------

--[[
--write.lua

while true do
  io.write "������������֣�"
  name=io.read()
  if name=="quit" then
    break
  else
    print("����," .. name .. "!")
    print ""
  end
end
--]]


---------------------------��������������-------------------------------------------

--[[
function fun(...)
  for i=1, arg.n do    -->���յ������в��������Զ�д��һ����arg��
    print(arg[i])       -->arg.n��ʾ���е��������
  end
end
fun(1,2,3,"hello",true)
--]]

---------------------------��ƽ����������-----------------------------------

--[[

a=3^2
b=math.sqrt(4)

--��3�η�
c=8^(1/3)   -->���=2

print(a,b,c)
--]]

------------------------------������ʽд��һ����----------------------------

--[[
a=1 b=2 c="hello"
print(a,b,c)
--]]

-------------------------�߼�����������÷�------------------------------------

--[[

x=false and 2     -->���=2,���x����1,�����2
print(x)

x=1 and 2 and 3    -->���=3,�������һ��Ϊ�ٵ�ֵ
print(x)

y=1 or 2      -->���=1,���ص�һ��Ϊ���ֵ
print(y)
--]]

-----------------------Lua ��Ϊ������������ʹ��----------------------------------

--[==[
do
-- db.lua

local entry={
title = "Tecgraf",
org = "Computer Graphics Technology Group, PUC-Rio",
url = "http://www.tecgraf.puc-rio.br/",
contact = "Waldemar Celes",
description = [[
TeCGraf is the result of a partnership between PUC-Rio,
the Pontifical Catholic University of Rio de Janeiro,
and <A HREF="http://www.petrobras.com.br/">PETROBRAS</A>,
the Brazilian Oil Company.
TeCGraf is Lua's birthplace,
and the language has been used there since 1993.
Currently, more than thirty programmers in TeCGraf use
Lua regularly; they have written more than two hundred
thousand lines of code, distributed among dozens of
final products.]]
}

print(entry.description);

function fwrite (fmt, ...)
  return io.write(string.format(fmt, unpack(arg)))
end

function BEGIN()
io.write([[
<HTML>
<HEAD><TITLE>Projects using Lua</TITLE></HEAD>
<BODY BGCOLOR="#FFFFFF">
Here are brief descriptions of some projects around the
world that use <A HREF="home.html">Lua</A>.
]])
end

function entry0 (o)
  N=N + 1
  local title = o.title or '(no title)'
 fwrite('<LI><A HREF="#%d">%s</A>\n', N, title)
end

function entry1 (o)
  N=N + 1
  local title = o.title or o.org or 'org'
 fwrite('<HR>\n<H3>\n')
  local href = ''

  if o.url then
  href = string.format(' HREF="%s"', o.url)
 end
 fwrite('<A NAME="%d"%s>%s</A>\n', N, href, title)

  if o.title and o.org then
  fwrite('\n<SMALL><EM>%s</EM></SMALL>', o.org)
 end
 fwrite('\n</H3>\n')

  if o.description then
  fwrite('%s', string.gsub(o.description,
       '\n\n\n*', '<P>\n'))
  fwrite('<P>\n')
 end

  if o.email then
  fwrite('Contact: <A HREF="mailto:%s">%s</A>\n',
    o.email, o.contact or o.email)
  elseif o.contact then
  fwrite('Contact: %s\n', o.contact)
 end
end

function END()
fwrite('</BODY></HTML>\n')
end

BEGIN()

N = 0
entry = entry0
fwrite('<UL>\n')
dofile('D:\\My Documents\\Contacts\\db.lua')
fwrite('</UL>\n')

N = 0
entry = entry1
dofile('D:\\My Documents\\Contacts\\db.lua')

END()

end
--]==]

-----------------------------�����ļ���table.lua---------------------------------------

--[==[

os.execute("dir G:\\Temp\\TV\\*.txt /b >G:\\Temp\\TV\\temp.txt")    --д���ļ�
io.input("G:\\Temp\\TV\\temp.txt")  --�����ļ�

--���ļ�����д��table

files={}
for t in io.lines() do
  table.insert(files,t)
end

--����table

for i=1,#files do
  print (files[i])
end

for i=1,#t do     --2ά ����4����
  print (t[i]["4"])
end


io.close()
--]==]


-------------------------------------CSV--------------------------

--[[

function ParseCSVLine (line,sep)
	local res = {}
	local pos = 1
	sep = sep or ','
	while true do
		local c = string.sub(line,pos,pos)
		if (c == "") then break end
		if (c == '"') then
			-- quoted value (ignore separator within)
			local txt = ""
			repeat
				local startp,endp = string.find(line,'^%b""',pos)
				txt = txt..string.sub(line,startp+1,endp-1)
				pos = endp + 1
				c = string.sub(line,pos,pos)
				if (c == '"') then txt = txt..'"' end
				-- check first char AFTER quoted string, if it is another
				-- quoted string without separator, then append it
				-- this is the way to "escape" the quote char in a quote. example:
				--   value1,"blub""blip""boing",value3  will result in blub"blip"boing  for the middle
			until (c ~= '"')
			table.insert(res,txt)
			assert(c == sep or c == "")
			pos = pos + 1
		else
			-- no quotes used, just look for the first separator
			local startp,endp = string.find(line,sep,pos)
			if (startp) then
				table.insert(res,string.sub(line,pos,startp-1))
				pos = endp + 1
			else
				-- no separator found -> use rest of string and terminate
				table.insert(res,string.sub(line,pos))
				break
			end
		end
	end
	return res
end

--]]


-----------------Used to escape "'s by toCSV----------------------


--[==[

function escapeCSV (s)
  if string.find(s, '[,"]') then
    s = '"' .. string.gsub(s, '"', '""') .. '"'
  end
  return s
end


-- Convert from CSV string to table (converts a single line of a CSV file)
function fromCSV (s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      table.insert(t, (string.gsub(f, '""', '"')))
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti-1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end


-- Convert from table to CSV string
function toCSV (tt)
  local s = ""
-- ChM 23.02.2014: changed pairs to ipairs
-- assumption is that fromCSV and toCSV maintain data as ordered array
  for _,p in ipairs(tt) do
    s = s .. "," .. escapeCSV(p)
  end
  return string.sub(s, 2)      -- remove first comma
end


local network={name="grauna",IP="210.26.30.34"}
for k, v in pairs(network) do  print(k, network.name, network.IP) end
local cs=toCSV(network)
print(cs)

file = io.open("d:\\namelist.txt","a+")
--file:write(cs)   --д�ļ�
--file:write("name", "\t", "IP","\n")
for k, v in pairs(network) do  file:write( k, "\t")  end ;  file:write("\n") ;
for k, v in pairs(network) do  file:write( network.name, "\t",network.IP,"\n") end

file:close()

--]==]


----------------------ϵ�л�----------------table ת s ----------------�� ת �ַ���---------------



--[[

function sz_T2S(_t)    --tableת�ַ���(ֻȡ��׼д�����Է�ֹ��ϵͳ�ı���������ID����)
    local szRet = "{"
    function doT2S(_i, _v)
        if "number" == type(_i) then
            szRet = szRet .. "[" .. _i .. "] = "
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        elseif "string" == type(_i) then
            szRet = szRet .. '["' .. _i .. '"] = '
            if "number" == type(_v) then
                szRet = szRet .. _v .. ","
            elseif "string" == type(_v) then
                szRet = szRet .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                szRet = szRet .. sz_T2S(_v) .. ","
            else
                szRet = szRet .. "nil,"
            end
        end
    end
    table.foreach(_t, doT2S)
    szRet = szRet .. "}"
    return szRet
end



function t_S2T(_szText)   --�ַ���תtable(�����л�,�쳣����ֱ�ӷ���nil)
    --ջ
    function stack_newStack()
        local first = 1
        local last = 0
        local stack = {}
        local m_public = {}
        function m_public.pushBack(_tempObj)
            last = last + 1
            stack[last] = _tempObj
        end
        function m_public.temp_getBack()
            if m_public.bool_isEmpty() then
                return nil
            else
                local val = stack[last]
                return val
            end
        end
        function m_public.popBack()
            stack[last] = nil
            last = last - 1
        end
        function m_public.bool_isEmpty()
            if first > last then
                first = 1
                last = 0
                return true
            else
                return false
            end
        end
        function m_public.clear()
            while false == m_public.bool_isEmpty() do
                stack.popFront()
            end
        end
        return m_public
    end
    function getVal(_szVal)
        local s, e = string.find(_szVal,'"',1,string.len(_szVal))
        if nil ~= s and nil ~= e then
            --return _szVal
            return string.sub(_szVal,2,string.len(_szVal)-1)
        else
            return tonumber(_szVal)
        end
    end

    local m_szText = _szText
    local charTemp = string.sub(m_szText,1,1)
    if "{" == charTemp then
        m_szText = string.sub(m_szText,2,string.len(m_szText))
    end
    function doS2T()
        local tRet = {}
        local tTemp = nil
        local stackOperator = stack_newStack()
        local stackItem = stack_newStack()
        local val = ""
        while true do
            local dLen = string.len(m_szText)
            if dLen <= 0 then
                break
            end

            charTemp = string.sub(m_szText,1,1)
            if "[" == charTemp or "=" == charTemp then
                stackOperator.pushBack(charTemp)
                m_szText = string.sub(m_szText,2,dLen)
            elseif '"' == charTemp then
                local s, e = string.find(m_szText, '"', 2, dLen)
                if nil ~= s and nil ~= e then
                    val = val .. string.sub(m_szText,1,s)
                    m_szText = string.sub(m_szText,s+1,dLen)
                else
                    return nil
                end
            elseif "]" == charTemp then
                if "[" == stackOperator.temp_getBack() then
                    stackOperator.popBack()
                    stackItem.pushBack(val)
                    val = ""
                    m_szText = string.sub(m_szText,2,dLen)
                else
                    return nil
                end
            elseif "," == charTemp then
                if "=" == stackOperator.temp_getBack() then
                    stackOperator.popBack()
                    local Item = stackItem.temp_getBack()
                    Item = getVal(Item)
                    stackItem.popBack()
                    if nil ~= tTemp then
                        tRet[Item] = tTemp
                        tTemp = nil
                    else
                        tRet[Item] = getVal(val)
                    end
                    val = ""
                    m_szText = string.sub(m_szText,2,dLen)
                else
                    return nil
                end
            elseif "{" == charTemp then
                m_szText = string.sub(m_szText,2,string.len(m_szText))
                local t = doS2T()
                if nil ~= t then
                    szText = sz_T2S(t)
                    tTemp = t
                    --val = val .. szText
                else
                    return nil
                end
            elseif "}" == charTemp then
                m_szText = string.sub(m_szText,2,string.len(m_szText))
                return tRet
            elseif " " ~= charTemp then
                val = val .. charTemp
                m_szText = string.sub(m_szText,2,dLen)
            else
                m_szText = string.sub(m_szText,2,dLen)
            end
        end
        return tRet
    end
    local t = doS2T()
    return t
end


function t2s(_t)    --tableת�ַ���(ֻȡ��׼д�����Է�ֹ��ϵͳ�ı���������ID����)
    local Ret = "{"
    function dot2s(_i, _v)
        if "number" == type(_i) then
            Ret = Ret .. "[" .. _i .. "]="
            if "number" == type(_v) then
                Ret = Ret .. _v .. ","
            elseif "string" == type(_v) then
                Ret = Ret .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                Ret = Ret .. t2s(_v) .. ","
            else
                Ret = Ret .. "nil,"
            end
        elseif "string" == type(_i) then
            Ret = Ret .. '["' .. _i .. '"]='
            if "number" == type(_v) then
                Ret = Ret .. _v .. ","
            elseif "string" == type(_v) then
                Ret = Ret .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                Ret = Ret .. t2s(_v) .. ","
            else
                Ret = Ret .. "nil,"
            end
        end
    end
    table.foreach(_t, dot2s)
    Ret = Ret .. "}"
    return Ret
end

local t1={1,2,{"a",3},"b", ["th"]="c", };
print(t2s(t1));

print(type(t1));



--]]


--------------------------------------����-------------------------------

-----------------------------MA--------------------------------

do

function CalcMA(closeData, step, param)

	local calc = step or #closeData;
	if #closeData < calc + param then
		return nil
	end
	--print("closeData: ",closeData);
	local ma = {}
	for i=1, calc do
		ma[i] = 0
	end
	for i=0,step-1 do
		local Sum = 0;
		for j=0,param-1 do
			Sum = closeData[#closeData - i - j] + Sum;
		end
		ma[step-i] = Sum/param
	end
	return ma
end

function Cross(data1, data2)
	return data1 ~= nil and data2 ~= nil and
		data1[#data1-1] < data2[#data2-1] and data1[#data1] > data2[#data2];
end

function QryTradingAccount()
	local Request={};
	Request['current_account'] 	= current_account;
	Request['InvestorID']		= current_account;
	local retInfo, err = trade.FutureQueryFunds(Request);
	if retInfo ~= nil then
		print("QryTradingAccount", retInfo);
	else
		print("QryTradingAccount", err);
	end
end

local tbcd={Name='300033',
Time={20131218,20131219,20131220,20131223,20131224,20131225,20131226,20131227,20131230,20131231,20140102,20140103,20140106,20140107,20140108,20140109,20140110,20140113,20140114,20140115,20140116,20140117,20140120,20140121,20140122,20140123,20140124,20140127,20140128,20140129,20140130,20140207,20140210,20140211,20140212,20140213,20140214,20140217,20140218,20140219,20140220,20140221,20140224,20140225,20140226,20140227,20140228,20140303,20140304,20140305,20140306,20140307,20140310,20140311,20140312,20140313,20140314,20140317,20140318,20140319,20140320,20140321,20140324,20140325,20140326,20140327,20140328,20140331,20140401,20140402,20140403,20140404,20140408,20140409,20140410,20140411,20140414,20140415,20140416,20140417,20140418,20140421,20140422,20140423,20140424,20140425,20140428,20140429,20140430,20140505,20140506,20140507,20140508,20140509,20140512,20140513,20140514,20140515,20140516,20140609},
Open={11.46,11.3,11.36,11.01,10.99,11.13,11.86,11.58,12.72,12.47,11.87,11.89,12.03,11.45,11.58,11.93,11.42,11.1,10.96,11.27,11.47,11.37,11.43,11.27,11.5,11.88,12,12.92,12.72,12.38,13.1,13.54,13.77,13.8,13.67,13.5,12.94,13.34,13.48,13.35,13.99,13.27,13.28,12.91,11.56,11.55,11.15,11.48,11.77,11.78,12.37,12.3,11.76,11.35,11.42,11.65,11.49,11.46,11.82,11.86,11.85,11.47,11.67,11.7,11.65,11.73,11.27,10.8,10.63,11.06,11.15,11.47,11.48,11.12,11.33,11.61,11.52,11.53,11.97,12.24,12.17,12.46,13.42,13.32,12.97,13.12,12.67,11.52,11.27,11.66,11.98,12.33,12.08,12.66,12.63,12.38,12.97,13.27,12.84,13.78},
High={11.46,11.45,11.36,11.29,11.32,11.85,11.95,12.82,12.72,12.47,12.21,12.32,12.12,11.8,12.25,12.2,11.62,11.21,11.27,11.56,11.62,11.51,11.5,12.18,11.97,12.35,13.32,13.11,12.88,13.37,14.36,14.01,14.07,14.32,13.72,13.92,13.35,13.84,13.71,14.52,14.12,13.47,13.38,13.24,11.7,11.85,11.62,11.74,12.12,12.72,12.66,12.37,11.87,11.6,11.67,11.65,11.67,11.81,12.07,11.95,11.92,11.65,12,11.89,11.85,11.77,11.42,11.06,11.19,11.06,11.62,11.82,11.55,11.35,11.91,11.86,11.72,12.46,12.37,12.33,12.75,13.48,13.95,13.47,13.81,13.62,12.67,12.03,11.8,12.14,12.73,12.61,13.02,12.76,13.12,13.32,13.22,13.72,13.41,13.78},
Low={11.24,11.22,10.77,10.73,10.99,11.13,11.55,11.55,12.43,11.77,11.74,11.85,11.3,11.42,11.58,11.62,10.89,10.93,10.91,11.17,11.31,11.23,11.07,11.22,11.47,11.77,11.99,12.49,12.18,12.38,13.06,13.47,13.48,13.42,13.17,12.88,12.77,13.22,13.34,13.07,13.35,13.17,12.76,11.62,11.04,11.22,11.09,11.36,11.51,11.78,12.18,11.88,11.23,11.22,11.22,11.47,11.39,11.33,11.76,11.65,11.37,10.96,11.59,11.53,11.53,11.23,10.77,10.52,10.62,10.73,11.13,11.28,10.92,11.12,11.2,11.41,11.47,11.52,11.87,12.01,11.98,12.38,12.93,12.97,12.97,12.73,11.83,11.07,11.22,11.56,11.95,11.99,12.02,12.12,12.61,12.38,12.88,12.72,11.8,13.78},
Close={11.3,11.23,11.3,11.03,11.22,11.82,11.67,12.81,12.47,11.85,12.08,12.17,11.47,11.58,12.07,11.67,11.1,10.96,11.27,11.55,11.37,11.5,11.3,11.6,11.93,12.17,12.88,12.71,12.37,13.25,13.56,13.74,13.93,13.54,13.67,12.95,13.17,13.47,13.4,13.97,13.37,13.39,12.91,11.72,11.56,11.22,11.52,11.71,11.94,12.42,12.3,12.01,11.35,11.5,11.51,11.59,11.59,11.8,11.86,11.75,11.48,11.63,11.77,11.6,11.73,11.32,10.78,10.8,11.08,10.81,11.4,11.58,11.13,11.29,11.85,11.62,11.59,12.19,12.2,12.07,12.49,13.48,13.37,13.02,13.33,12.8,11.88,11.27,11.67,11.95,12.46,12.16,12.66,12.37,12.7,13.02,13.21,12.86,12.49,13.78},
Volume={460940,409390,868242,304560,545424,1381486,854432,4885342,2317778,3172790,2703254,2531752,2906142,993468,3767374,3136014,2473774,1079716,1224924,2025622,1582998,1394442,1214666,4055256,3641432,4774380,8829678,6160638,3010974,5705368,8627592,6678006,6198676,5751578,3505316,4162260,3943478,4836316,3786452,9633372,6613920,3802196,3970772,6602922,3227956,3791132,2446392,2265630,2794162,4068048,2567218,2163372,2099214,1098580,1161420,1216700,1017686,2220170,1739452,1376504,1664300,1738906,1715056,1249046,1044570,1780954,2749416,1259522,2236046,1791796,4507168,4968324,8262372,3564744,6726214,5048050,2099790,9079268,4503520,3019110,5292396,9567366,8870928,3486200,5944328,4857974,4576814,7633000,4462754,3086054,4797280,3078718,4012382,2920860,4811484,6333502,3499082,7006026,8264128,0},
Amount={5207639,4639566.5,9622944,3361051.75,6125999,16022356,10019326,61007192,29059926,37968820,32436236,30671970,33786040,11494554,45404700,37276556,27766370,11952068,13637747,23038346,18095026,15918905,13774463,47413844,42797352,57956864,111937872,78768008,37402000,73857248,119357208,91915528,85710776,79580488,47221056,55942560,51636592,65499164,51284800,133716920,90527648,50694364,51552992,82448744,36697632,43896264,27621322,26372626,33184998,49950120,31777406,26143792,24092378,12599457,13332614,14075254,11724511,25935010,20696754,16202013,19440812,19701296,20236638,14606954,12258778,20290838,30153604,13490177,24649758,19362276,51176628,57680720,91563744,40108388,77665736,58685056,24335824,109772952,54597660,36495308,66035852,125757008,119281624,45986492,80049888,63531272,55268052,86825976,51731540,36674148,59519984,37819020,50307508,36127516,61551284,82752296,45749748,93176056,102288112,0},
}

--for k=1,#tbcd.Close do   print(tbcd.Close[k])  end   --�������
--for k=1,#tbcd["High"] do   print(tbcd["High"][k])  end   --�������

tbma=tbcd.Close
tbmb=CalcMA(tbcd.Close,30,5)

tbmc= tbmb or  {4,5,6,7,8}
for k=1,#tbmc do   print(k,'\t', tbmc[k])  end   --�������

end










--------------------------------------ģ��-------------------------------



function QueryCC(nowAccount)      --��ѯ�ֲ�
	local retMsg,msgErr = trade.StockQueryPosition(nowAccount);
	if retMsg ~= nil then
--		print('�ֲ���')
--		print(retMsg["RetData"]);
		SendToControl(retMsg["RetData"] or {}, 'cc_ret'); --���ͳֲ���main.lua cc_ret����
		return retMsg["RetData"];  --���سֲ�
	else
		SendToControl('�ֲֲ�ѯʧ��'..msgErr, 'ERROR');
		return {};
	end
end


function QueryCJ(nowAccount)      --��ѯ�ɽ�(����)
	local time = os.date("%Y%m%d");
	local retMsg,msgErr = trade.StockQueryExecution(nowAccount, nil, nil, nil, time, time);
	if retMsg ~= nil then
--		print('----�ɽ�-----')
--		print(retMsg);
		SendToControl(retMsg["RetData"] or {}, 'cj_ret');	--���ͳɽ���main.lua cj_ret����
		return retMsg["RetData"];  --���سɽ�
	else
		SendToControl('�ɽ���ѯʧ��'..msgErr, 'ERROR');
	end
end


function QueryWT(nowAccount)      --��ѯί��(����)
	local time = os.date("%Y%m%d");
	local retMsg,msgErr = trade.StockQueryEntrust(nowAccount,nil,nil,nil,time,time);
	if retMsg ~= nil then
--		print('ί�в�ѯ�ɹ���:::::::');
--		print(retMsg);
		SendToControl(retMsg["RetData"] or {}, 'entrust_ret');	--����ί����main.lua entrust_ret����
	else
		print('QueryWT',msgErr);
		SendToControl('ί�в�ѯʧ��'..msgErr, 'ERROR');
	end
end




--��ʽ������
function FormatDate(olddate)
	local year = string.sub(olddate, 1, 4);
	local month = string.sub(olddate, 6, 7);
	local day = string.sub(olddate, 9, 10);
	local newdate = year .. month .. day;
	return newdate;
end


--����N������߼�
function  Highest(M,N,Price)                  --����M��ʾ����ĵ�һ��K������ǰ�ĸ�����N�Ǽ�������һK������ǰ�ĸ���(���Ƚ�)��
	local hest=0;
	for i=N,M,1 do                            --ѭ������(�Ƚ�K����): M-N+1 , N<M<=#-1  NΪ0ʱ, ������ 1,ǰһ��(�ź�K��)
		hest=math.max(hest,Price[#Price-i]);   --����ѭ��, ��#-M��#-N�����ֵ, �����N�ڲ��Ƚ�, �����N-1�ڽ�ֹ,
--@		print(i,Price[#Price-i],#Price-i);     --@
	end
	return hest;
end

--����N������ͼ�
function  Lowest(M,N,Price)                     --����M��ʾ����ĵ�һ��K������ǰ�ĸ�����N�Ǽ�������һK������ǰ�ĸ�����
	local lest=Price[#Price-M];                 --M > N
	for i=N,M,1 do                              --��-M��-N��
		lest=math.min(lest,Price[#Price-i]);
	end
	return lest;
end

--��ʱ��ת��Ϊ��
function timetosec(time)

	local day1 = {};
	day1.year,day1.month,day1.day,day1.hour,day1.sec = string.match(time,"(%d%d%d%d)(%d%d)(%d%d)(%d%d)(%d%d)");
	local lasttimesec = os.time(day1);
	return lasttimesec;
end

--��ӡ��Ϣ--�м䲿--------
function SendInfoLog(msgtype, message)
	local msginfo = string.format("[%s]", message);
	local InfoLog = {};
	InfoLog["MsgInfo"] = msginfo;
	InfoLog["MsgType"] = msgtype;
	SendToControl(InfoLog,"InfoLog");
end

----------------------------------�������� init()------------------------------------------

function init()
	page.callAsy('onStart', {});                --< ��� cl.lua onStart����
	page.setPageRecvCallBack(onRecvCb);         --�ص�����onRecvCb
end
init();


----------------------------------���ܲ��Ժ��� ��ʾlog.html------------------------------------------

function ConsolePrint(lMsgType,lMsg,lTitle)
	local lCurTime = string.format("[%s]", os.date("%Y-%m-%d %H:%M:%S"));
	local lPrint   = string.format("%s[%s]%s: %s\r\n", lCurTime, lMsgType, lTitle, lMsg);
	div_log:append_html(lPrint);
end

--ConsolePrint("lMsgType","lMsg","lTitle") ; --P

function logPrint(logMsg)                       --��־��Ϣ��ӡ logmsg���� .index .msg
	if messageList == nil then messageList = {};  end
	table.insert(messageList, logMsg);
	local function sortIndex(a,b) return a.index>b.index; end
	table.sort(messageList, sortIndex);
	local tbhtml={};
	for k,v in pairs(messageList) do
		table.insert(tbhtml,string.format([[<tr><td>--&lt;%s</td></tr>]],v.msg));  -- &lt; html�ַ�<
	end
	log.html = table.concat(tbhtml,'');
end


function t2s(_t)    --tableת�ַ���(ֻȡ��׼д�����Է�ֹ��ϵͳ�ı���������ID����)  ���Ƹ�д��print
    local Ret = "{"
    function dot2s(_i, _v)
        if "number" == type(_i) then
            Ret = Ret .. "[" .. _i .. "]="
            if "number" == type(_v) then
                Ret = Ret .. _v .. ","
            elseif "string" == type(_v) then
                Ret = Ret .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                Ret = Ret .. t2s(_v) .. ","
            else
                Ret = Ret .. "nil,"
            end
        elseif "string" == type(_i) then
            Ret = Ret .. '["' .. _i .. '"]='
            if "number" == type(_v) then
                Ret = Ret .. _v .. ","
            elseif "string" == type(_v) then
                Ret = Ret .. '"' .. _v .. '"' .. ","
            elseif "table" == type(_v) then
                Ret = Ret .. t2s(_v) .. ","
            else
                Ret = Ret .. "nil,"
            end
        end
    end
    table.foreach(_t, dot2s)
    Ret = Ret .. "}"
    return Ret
end

function test(Var,vName)                                   --test("123"); --> 123 �����鿴����ֵ������, ���ڴ�
	if type(Var)=="table" then Var=t2s(Var); end;
	local test={index=0, msg="", }                         --�������Ա���
	local daySec = os.date("*t", os.time())                --����ʱ����ϸ
	daySec.hour=0; daySec.min=0; daySec.sec=0;             --����ʱ������0, �����ֵ, ��Ϊ��������
	local dSec=os.time()-os.time(daySec);                  --�������� 86400(��) --��ʱ��ת��Ϊ��
	for i=1,10^7 do    end;                                --��ѭ��, ȡcpu����ʱ���
	test.index= 86400*10^4-(dSec*10^4+os.clock()*10^2) ;   --�Ƚ��ȳ�
	if vName==nil then vName="Var"; end
	test.msg=string.format("[%s]:[%s]:[%s]", os.date("%H:%M:%S"), vName, Var);
	logPrint(test);
end

--	test("-------------------aTion 20140630----------------------");
--	local t1={1,2,{"a",3},"b", ["th"]="c", };
--	test(t1,"t1");  --> {[1]=1,[2]=2,[3]={[1]="a",[2]=3,},[4]="b",["th"]="c",}






