
Class = {x=0,y=0} --���������������������������ԣ����Ҹ��������Եĳ�ʼֵ��
Class.__index = Class   --������ض���Ԫ�������������˵������䣬�������һ���ࡣ����Ľ��ͣ���ٶȡ�
function Class:new(x,y) --�����壬������������������ģ�ϰ���Ը�Ϊnew()
        local self = {}  --��ʼ��self�����û����䣬��ô���������Ķ���ı䣬�������󶼻�ı�
        setmetatable(self, Class)  --��self��Ԫ���趨ΪClass
        self.x = x   --����ֵ��ʼ��
        self.y = y
        return self  --��������
end
function Class:test()  --���ﶨ�������������
    print(self.x,self.y)
end
function Class:plus()
    self.x = self.x + 1
    self.y = self.y + 1
end


a = Class:new(10,20)
a:test()
b = Class:new(11,23)
b:test()
b:plus()
b:test()

--�������µ�����Z
Main = {z=0}
--����������Class
setmetatable(Main, Class)
--���Ǻ��ඨ��һ�����������趨Ϊ����
Main.__index = Main
--�����ǹ����壬����������һ���µĲ���
function Main:new(x,y,z)
   local self = {}  --��ʼ����������
   self = Class:new(x,y) --�����������趨Ϊ���࣬�������൱���������Ե�super
   setmetatable(self, Main) --����������Ԫ���趨ΪMain��
   self.z= z --�µ����Գ�ʼ�������û�н��ᰴ������=0
   return self
end
--����һ���µķ���
function Main:go()
   self.x = self.x + 10
end
--�ض��常��ķ���
function Main:test()
    print(self.x,self.y,self.z)
end


c = Main:new(20,40,100)
c:test()
d = Main:new(10,50,200)
d:go()
d:plus()
d:test()
c:test()


Class = {x=0,y=0}
Class.__index = Class
function Class:new(x,y)
        local self = {}
        setmetatable(self, Class)
        self.x = x
        self.y = y
                     return self
end
function Class:test()
    print(self.x,self.y)
end
--�¶����һ������gto()
function Class:gto()
   return 100
end
--���������gto()
function Class:gio()
   return self:gto() * 2
end
function Class:plus()
    self.x = self.x + 1
        self.y = self.y + 1
end

Main = {z=0}
setmetatable(Main, Class)
Main.__index = Main
function Main:new(x,y,z)
   local self = {}
   self = Class:new(x,y)
   setmetatable(self, Main)
   self.z= z
   return self
end
--���¶�����gto()
function Main:gto()
   return 50
end
function Main:go()
   self.x = self.x + 10
end
function Main:test()
    print(self.x,self.y,self.z)
end


a = Class:new(10,20)
print(a:gio())
d = Main:new(10,50,200)
print(d:gio())
print(a:gio())










