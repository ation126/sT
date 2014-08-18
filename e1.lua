
Class = {x=0,y=0} --声明，这里声明了类名还有属性，并且给出了属性的初始值。
Class.__index = Class   --这句是重定义元表的索引，就是说有了这句，这个才是一个类。具体的解释，请百度。
function Class:new(x,y) --构造体，构造体的名字是随便起的，习惯性改为new()
        local self = {}  --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
        setmetatable(self, Class)  --将self的元表设定为Class
        self.x = x   --属性值初始化
        self.y = y
        return self  --返回自身
end
function Class:test()  --这里定义类的其他方法
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

--声明了新的属性Z
Main = {z=0}
--设置类型是Class
setmetatable(Main, Class)
--还是和类定义一样，表索引设定为自身
Main.__index = Main
--这里是构造体，看，加上了一个新的参数
function Main:new(x,y,z)
   local self = {}  --初始化对象自身
   self = Class:new(x,y) --将对象自身设定为父类，这个语句相当于其他语言的super
   setmetatable(self, Main) --将对象自身元表设定为Main类
   self.z= z --新的属性初始化，如果没有将会按照声明=0
   return self
end
--定义一个新的方法
function Main:go()
   self.x = self.x + 10
end
--重定义父类的方法
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
--新定义的一个函数gto()
function Class:gto()
   return 100
end
--这里会引用gto()
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
--重新定义了gto()
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










