Class={};
Class.classList={}; --���������Ѿ����������

--�������: ��ͽӿ�, �ӿ�Ҳ��һ����
Class.TYPE_CLASS="Class";
Class.TYPE_INTERFACE="Interface";

function Class.isExist(className)
	return Class.classList[className] ~= nil;
end

--���������ע��,��ֹ�ظ�����
function Class.register(className,clazz)
	if(Class.isExist(className)) then return end;
	Class.classList[className]=clazz;
end
function Class.getDefinedClass(className)
	return Class.classList[className];
end

-- ��������Ϣ���ض�����ֱ��error, �����������ͨ��error��level2 �׳��쳣,���ܸ���ȷ��λ��������
function Class._checkValid(class, clsType)
	clsType = clsType or Class.TYPE_CLASS;
	if(class==nil) then
		return clsType .. " δ����!!";
	end
	if(type(class)~="table") then
		return "\""..tostring(class).."\" ����һ��" .. clsType .."!!";
	end
	local b = false;
	for k, v in pairs(Class.classList) do
		if(v == class) then
			b = true;
		end
	end
	if(not b) then
		return clsType .. " ".. tostring(class) .. " δ����!!";
	end

	if (clsType==Class.TYPE_CLASS and class.__classType~=Class.TYPE_CLASS) or (clsType==Class.TYPE_INTERFACE and class.__classType~=Class.TYPE_INTERFACE) then
		return "\"" .. class.className .. "\" ����һ�� "..clsType.."!!";
	end

	return nil;
end

--����һ����. �����޷�������û�д���extendsCls���Ǵ�����һ�������extendsCls,�����ṩ��define2���Զ��̳���Object. ���������ǿ�ƴ���Object����
--@param className ����.�ַ���.
--@param ... ��һ�������� extends ����,����Ҫʵ�ֵ�һ��ӿ�.
function Class.define(className, ...)
	local cls = Class._define(Class.TYPE_CLASS, className, ...)
	if (type(cls)=="string") then
		error(cls, 2);
	end
	return cls;
end

function Class._define(clsType, className, ...)
	if(type(className)~="string") then
		return clsType.." ���� \""..tostring(className).."\" ��Ч!!";
	end
	if(Class.isExist(className)) then
		return clsType.." \""..tostring(className).."\" �ظ�����!!";
	end

	local clazz={className=className, __classType=Class.TYPE_CLASS};

	--���汾����Ҫʵ�ֵĽӿ�,�Ҳ����ظ�ʵ��ͬһ�ӿ�
	local extendsCls;
	local arglen = select("#", ...);
	local err = nil;

	-- ˵��û����ʾ����̳е���
	if(arglen<1) then
		if(className=="Object") then
			extendsCls = nil;
		else
			extendsCls = Object;
		end
	else
		extendsCls = select(1,...);

		err = Class._checkValid(extendsCls,clsType);

		if(err) then
			return err;
		end
	end

	clazz.parentClass=extendsCls;

	clazz.__implements={};
	local _impl;
	for i=2, arglen do
		_impl = select(i, ...);
		--��֤�ӿ���Ч��
		err = Class._checkValid(_impl, Class.TYPE_INTERFACE);
		if(err) then
			return err;
		end

		--���ӿ��Ƿ��ظ��̳�
		for _,v in ipairs(clazz.__implements) do
			if(v==_impl) then
				return Class.TYPE_INTERFACE.." \"".._impl.className.."\" �ظ��̳�!!";
			end
		end

		table.insert(clazz.__implements, _impl);
	end

	if(className=="Object") then
		Class.register(className,clazz);
		return clazz;
	end

	Class.register(className,clazz);

	return clazz;
end

--��⵱ǰ���Լ������Ƿ�ʵ������ؽӿڵķ���
function Class._checkImplements(cls, interfaces)
	if(#interfaces<1) then return end;

	local pInterface;
	for k,v in ipairs(interfaces) do
		--���ҵ�ǰ�ӿڵ����з����Ƿ�ʵ��
		Class.__checkImplements(cls, v);

		--���ҵ�ǰ�ӿڵĸ����ӿڵ����з����Ƿ�ʵ��
		pInterface=v.parentClass;
		while(pInterface) do
			Class.__checkImplements(cls, pInterface);
			pInterface=pInterface.parentClass;
		end
	end
end
--��⵱ǰ��͸����Ƿ�ʵ����һ���ӿڵ����з���
function Class.__checkImplements(cls, interface)
	local b=true;
	local pcls;
	for name, func in pairs(interface) do
		if(type(func)=="function") then
			if(cls[name] and type(cls[name]=="function")) then return end

			--�������в��������,���ڸ����в���
			pcls=cls.parentClass;
			while(pcls) do
				if(pcls[name] and type(pcls[name]=="function")) then return end
				pcls=pcls.parentClass;
			end

			--����͸����ж�û�ҵ�,˵��û��ʵ��
			error("\""..cls.className.."\" δ���� \""..interface.className.."\" �еĳ��󷽷� "..name.."()");
		end
	end
end

function Class.createObjectFromClass(class)
	local o={};
	o.class=class;
	setmetatable(o,class);

	--���÷���ʱ�Ĳ���
	class.__index=function(t,k) --���Ժͷ����ӱ��࿪ʼ����������

		local v = nil;
		local pcls = t.class;
		while(pcls) do
			v = rawget(t.class, k);
			if(v) then return v end;

			pcls = pcls.parentClass;
		end

		return nil;
	end

	return o;
end

--��֤��������Ϸ���
function Class.checkCtor(class, ...)
	if(class==Object or class.parentClass==nil) then
		return;
	end

	--����һ���޲ι���.
	if(class._ctor == nil and class.ctor == nil) then
		class._ctor = function() end;
	end

	Class.checkCtor(class.parentClass);
end

--newһ�������ʵ��
function Class.new(class, ...)
	Class._checkValid(class);

	--���ӿڵ�ʵ�����
	Class._checkImplements(class, class.__implements);

	--�����û��ʾָ���޲ι��캯��,����checkCtor()������һ���޲εĹ��캯��
	Class.checkCtor(class, ...);

	-- ��ȡ��������ʵ����, �������ִ���Ĳ�����Ϊnilʱ,�����ǵ�������д��nil����ϵͳĬ�ϵ�nil
	local arglen = select("#", ...);
	--�����ǰ��û���вι���,���������Ϊ��
	if(class.ctor == nil and arglen ~= 0) then
		error("���캯������,�������вι��캯��. Class "..class.className);
	elseif(class._ctor == nil and arglen == 0) then
		error("���캯������,�������޲ι��캯��. Class "..class.className);
	end

	-- ����������ж���������ó����ŵ�һ��ӳ�����
	local attributes = {}; -- Map<����, Map<����,value> >

	-- ���������ж���ķ��������б�������. ÿ�����Լ�����ķ���������������,��ҪΪsuper�ṩ
	local functionsMap = {}; -- Map<����, Map<������,func> >
	--�������ʵ�ֵ���Щ����. ʵ�ֶ�̬.
	functionsMap.lastFuncs = {};

	--��������
	local _clsListTemp = {};
	local pcls=class;
	while(pcls~=nil) do
		table.insert(_clsListTemp, pcls);
		pcls = pcls.parentClass;
	end

	--�ȴ����������ε��������е����з���.
	local _cls = nil;
	for i = #_clsListTemp, 1, -1 do
		_cls = _clsListTemp[i];

		functionsMap[_cls] = {};

		--�ҳ�����,���浽�����б���
		for k,v in pairs(_cls) do
			--����Ӧ�ü�鷽�������Ƿ�����������ظ�. java�п����������������������ظ�, ��lua����,�Ḳ��.

			--Ĭ�ϵ��޲ι��캯����������,��Ϊ���Զ�������һ��.
			if(type(v)=="function" and k~="_ctor" and k~="__index" and k~="__newindex") then
				if(k=="getter_ctor" or k=="setter_ctor" or k=="getter__ctor" or k=="setter__ctor") then
					error("���ܽ����췽������Ϊgetter��setter����!!");
				end

				--�����Ӧ�ķ����б�. Ĭ��ָ������ʵ����,��Ҳ����ÿ�������Լ����Ǹ�����,�Ա�ͨ��super���õ�ʱ���ҵ���Ӧ�ķ���.
				functionsMap[_cls][k] = v;

				--�����Ǵ������µ���,�������า�ǵķ����ᱻ��ȷָ��. �вι��첻�ܸ��Ǳ���.
				if(k~="ctor") then
					functionsMap.lastFuncs[k] = v;
				end
			end
		end
	end

	local obj = {};
	-- obj ����new֮�󷵻ص�һ���յĴ������, �����Ķ��������meta,���б����Ͽ����������Եķ��ʺ��޸�Ҳ���������meta.
	-- ����Ҳ�����ģ��ʵ���� getter �� setter
	local meta = {class = class, __attributes = attributes, __functionsMap = functionsMap};

	setmetatable(obj, meta);
	--���ü�Ϊ������.
	meta.__mode="k";

	--�������Ժͷ���
	meta.__index = function(t, k)
		if(k=="_ctor") then return nil end

		local m = getmetatable(t);
		if(k=="class") then return m.class end

		local attr,func;

		--�ȴ����Բ���
		attr = m.__attributes[k];

		if(attr~=nil) then return attr end

		-- �ж��Ƿ���getter����,�����getter����,���ȵ���getter����
		func = m.__functionsMap.lastFuncs["getter_"..k];
		if(func~=nil) then
			return func(t);
		end

		--����.
		func = m.__functionsMap.lastFuncs[k];
		if(func ~= nil) then return func end

		--���Ԫ��������Ҳ���,��������в���. ��java�еı���Ϊ��ʵ��������ȥ����������ľ�̬���Ի򷽷�.
		local pcls = m.class;
		while(pcls~=nil) do
			attr = pcls[k];

			if(attr~=nil) then
				--����Ƿ���, ����һ�δ�����ʷ���, ���������������س�ȥ.
				--��Ϊ�ⲿ������ð�ŷ���, ����ľ�̬����ֻ���ǵ�ŷ���, ��������Щ�����ڲ�ʹ��self�����. �������������
				if(type(attr) == "function") then
					return attr();
				end

				return attr;
			end

			pcls = pcls.parentClass;
		end
		return nil;
	end

	--�޸����Ժͷ���
	meta.__newindex = function(t, k, v)
		if(k=="class") then
			error("class ��ֻ������. \""..m.class.classNa.."\" !!");
		end

		if(k=="ctor" or k=="_ctor") then
			error("���ܽ����췽������Ϊ����!!");
		end

		local m = getmetatable(t);

		if(m.__functionsMap.lastFuncs[k] and v~=nil) then
			--�ж���������Ƿ���һ��getter,setter����. �����,�����������Դ����ظ�����
			local stind,endind = string.find(k,"getter_");
			local subname = nil;
			if(stind~=nil) then
				subname = string.sub(k,endind+1);
			else
				stind,endind = string.find(k,"setter_");
				if(stind~=nil) then
					subname = string.sub(k,endind+1);
				end
			end

			if(subname) then
				error("�������¶���Class \"".. m.class.className .."\" ��getter, setter���� \""..subname.."\" !!");
			--else
			--	error("�������¶���Class \"".. m.class.className .."\" �ķ��� \""..k.."\" !!");
			end
		end

		--�ı��ֵ����һ������. ����ӵ������б���
		if(type(v)~="function") then

			-- �ж��Ƿ���setter����,�����setter����,���ȵ���setter����
			local func = m.__functionsMap.lastFuncs["setter_"..k];
			if(func~=nil) then
				return func(t, v);
			end

			m.__attributes[k] = v;
			return;
		else
			-- error("����ΪClass \"".. m.class.className .."\" ��ʵ����̬��ӷ��� \""..k.."\" !!");
			m.__functionsMap.lastFuncs[k] = v;
		end
	end

	--���������Ѿ��ҳ������з���, �����ڹ��캯���оͿ��Է�����Щ������. Ҳ�����ڹ��캯����ִ��һЩ�߼�.
	for i = #_clsListTemp, 1, -1 do
		_cls = _clsListTemp[i];

		--����_cls����ʱ����
		local __o = Class.createObjectFromClass(_cls);

		--�����õ�ŷ���,�������˴����obj����,������_ctor��������Ծͻᱣ�浽objԪ�����meta�� attributes��(ͨ�������__newindex����).
		--�����_ctor�г�ʼ�����߼�����,Ҳ����objԪ��meta��functionsMap ����ȷ���ʵ�.
		--��������ظ���������, ����û��ʹ����javaһ���ķ�ʽ�����ڲ�ͬ���ж������ͬ���Եĸ���.
		--�е���actionscript��һ�������ظ�����(as�и�������Կɼ���Ҫ������С,����ͱ��ظ�����ı��뼶����).
		--������û��ʵ�� private �����Ŀɼ���, ����ȫ����Ϊ public. ����Ȼ�������ظ���������.
		--������Ӧ����һ�μ��,����ظ�����Ҫ����.��luaû��������Ԥ�������ԵĶ������Եĸ���,
		--�������޷�֪�������ڹ��췽���ڲ�дself.xx=value ʱ�����Ƕ���������Ի��Ǹ�������ֵ(������Ѿ��ڸ����ж�����)
		--��������ͳһ����,�����ھͶ���,���ھ͸���.
		--��������ctor ���ܱ�����,������洢����ʱ�Ѿ�������ctor����,��_ctor�����п��ܻ����ctor����,�Ҵ�ʱֻ�ܷ����Լ�������е�ctor����,
		--�Ǿ�Ҫ��������ڵ�ctor��__o��ȡ�����ŵ�obj��Ԫ������ʱ��������,�ٵ���_ctorʱ,����ڲ���Ҫ����ctor�Ų������,������ȷ���õ������ж�Ӧλ�õ�ctor.
		if(__o.ctor~=nil) then
			getmetatable(obj).__functionsMap.lastFuncs.ctor=__o.ctor;
		end

		--�Զ�������һ��ÿ������޲ι��캯��.
		--�����java��һ��, java�ǵ�newʱ��������ʱ,�Ż�����޲ι���,���������޲ι�����û����ʾдsuper,�ֻ��Զ����ø�����޲ι���.
		--�����������޷�֪��������û���ڴ����ڲ���ʾдsuper, �Ͳ�֪���Ƿ���Զ����ø�����޲ι���.
		--������Զ�ͳһ����,��ÿ�����඼Ҫ��ʾд���޲ι��캯�������ڲ�дself:super(class,"_ctor").
		--Ϊ��ҵ��ͳһ����,�����Զ�����, �������޲ι��캯���ﾡ����Ҫ���������������ĵ���,����߼��ظ�.
		if(__o._ctor~=nil) then
			__o._ctor(obj);
		end

		--�������û�ж������Լ���ctor,�������_ctor����дself:ctor()���������,�Ϳ��ܻ���õ������ctor����.���Ǵ����.
		--���Բ���_ctor�ڲ��Ƿ���ù���ctor,֮��Ҫ����ʱ�����ctor�����
		if(__o.ctor~=nil) then
			getmetatable(obj).__functionsMap.lastFuncs.ctor=nil;
		end
	end

	--������ڲ����͵��ñ�����вεĹ���ctor(). ������вι��첻�ᱻ�Զ�����,ֻ��������ʾдself:super(class, k, ...);
	local arglen = select("#", ...); -- ֻ�е�����������д�˲���,��ʹ��nil,���ܵ����вι���
	local ctorFunc = arglen~=0 and getmetatable(obj).__functionsMap[class].ctor;
	if(ctorFunc) then
		ctorFunc(obj, ...);
	end

	return obj;
end

--�������super��һ����ʵ��,û�е�һ��class��Ϊ����,���ֵ������:
--������ A <- B <- C <- D ������A���ж�����func1, ��C���и�����func1,���ڷ��������ڲ���дsuper(self,"walk").
--����Class.new(D),��ͨ��D��ʵ������func1. ��ȷ���߼�Ӧ���Ƿ��ʵ�C ��func1,Ȼ���ַ��ʵ�A ��func1.
--����������ð�ŷ���, ������C ���е�func1���super(self,"walk")���self������ʵ������D ��ʵ��. ����������ж�,�ͻ�������ѭ��.
--���ﴫ��cls������ȷ�����ҵ�ǰ����walk�����������ĸ�, �ٴ�cls�ĸ�������ҵ�A.
--���������cls, �����޷�֪����ǰsuper����λ���ĸ�������, �Ϳ��ܵ�������ѭ��(B��C��walk�����ﶼд��superʱ�ͻ�������ѭ��)
--���Ե�һ������classֻ��ͨ���ⲿ��ʾ����.
function super(cls, t, k, ...)
	Class._checkValid(cls);

	if(instanceof(t,Object)==false) then
		error("�������ʹ���. ����һ����ȷ��Objectʵ��!!");
	end

	Class._checkValid(t.class);

	if(type(k)~="string") then
		error("�������ʹ���. ʹ�� super ����ʱ,ֻ�ܴ������Ի򷽷����ַ�������!!");
	end
	local m = getmetatable(t);

	local pcls = cls.parentClass;
	local func = nil;
	if(pcls==nil) then
		error("���� Class \""..cls.className.."\" �ĸ��಻����!!");
	end
	if(k=="ctor") then
		func = m.__functionsMap[pcls][k];
		if(func~=nil) then
			return func(t, ...);
		else
			error("���� Class \""..t.class.className.."\" super�ķ��� \""..k.."\" ������!!");
		end
	end

	--����. ����û����javaһ��Ҳ�����˸������ͬ���Ƶ����Եĸ���. ����superʱҲ��õ����������󱻸Ĺ����Ǹ�ֵ
	local attr = m.__attributes[k];
	if(attr~=nil) then
		return attr;
	end

	--���t��class���Ƿ���k����
	while(pcls~=nil)do
		func = m.__functionsMap[pcls][k];
		if(func~=nil) then
			return func(t, ...);
		end

		pcls = pcls.parentClass;
	end

	error("���� Class \""..t.class.className.."\" super�ķ��� \""..k.."\" ������!!");
end


local _instanceof;
-- һ�������Ƿ���һ�����ӿڵ�ʵ��
function instanceof(obj,class)
	if(obj==nil or type(obj)~="table" or obj.class==nil) then
		-- print("�������� 1, ����һ������!!");
		return false;
	end

	Class._checkValid(class);

	if(rawget(class,"__classType")==nil) then
		error("�������� 2,����һ����!!");
	end
	if(class==Object) then return true end

	local ocls=obj.class;
	if(ocls==class) then return true end
	local pcls,b=nil,false;
	--����Ǹ���,����Ҹ���
	if(class.__classType == Class.TYPE_CLASS) then
		pcls=ocls.parentClass;
		while(pcls~=nil) do
			if(pcls==class) then return true end
			pcls=pcls.parentClass;
		end
	--����Ǹ��ӿ�,���ڱ���͸�������нӿ��в���
	elseif(class.__classType == Class.TYPE_INTERFACE) then

		b=_instanceof(ocls,class);
		if(b) then return true end
		pcls=ocls.parentClass;

		while(pcls~=nil) do
			b=_instanceof(pcls,class);
			if(b) then return true end
			pcls=pcls.parentClass;
		end
	end

	return false;
end

_instanceof=function(cls,class)
	local interfaces,pInterface,b=cls.__implements,nil,false;
	if(#interfaces<1) then return false end

	--���ܻ��ظ�������ؽӿ�
	for k,v in ipairs(interfaces) do
		if(class==v) then return true end

		--���ҵ�ǰ�ӿڵĸ����ӿڵ����з����Ƿ�ʵ��
		pInterface=v.parentClass;
		while(pInterface~=nil) do
			if(class==pInterface) then return true end
			pInterface=pInterface.parentClass;
		end
	end

	return false;
end

-----------------------------------------
--Object
Object=Class.define("Object");
function Object:_ctor()
	--print("Object _ctor");
end

--�ṩһ����ݷ���. ÿ�����ʵ���Ϳ���ͨ�� self:super(cls,k,...)������
function Object:super(cls, k, ...)
	super(cls, self, k, ...);
end


Class.define("Class"); --����class����

--�ӿ�
Interface=Class.define("Interface");
function Interface.define(interfaceName, ...)

	local arglen, cls,extendsInterface;
	arglen = select("#", ...);

	if(arglen<1) then

		cls = Class._define(Class.TYPE_INTERFACE, interfaceName);

	else
		if(arglen>1) then
			error(Class.TYPE_INTERFACE.." ֻ�ܼ̳�һ���ӿ�!!", 2);
		end

		extendsInterface = select(1, ...);
		Class._checkValid(extendsInterface, Class.TYPE_INTERFACE);

		cls = Class._define(Class.TYPE_INTERFACE, interfaceName, extendsInterface);
	end

	if (type(cls)=="string") then
		error(cls, 2);
	end

	cls.__classType=Class.TYPE_INTERFACE;
	return cls;
end

--=============== ģ����� =================
--[[���Լ̳кͽӿ�
IPerson = Interface.define("IPerson");
function IPerson.walk() end

Role = Class.define("Role", Object, IPerson);
function Role:walk()
	print("walk");
end

Monster = Class.define("Monster", Role);
Class.new(Monster):walk();
--]]
--[[���Թ��캯��
Role = Class.define("Role");
function Role:_ctor()
	self:ctor("defName");
end
function Role:ctor(name)
	self.name=name;
	self:walk();
end
function Role:walk()
	print(self.name .." walk");
end

Monster = Class.define("Monster", Role);

--����monsterû�ж����κι��캯��,���Զ�����һ���޲ι��캯��. ���Class.checkCtor()����.
Class.new(Monster);
--]]
--[[���Թ��캯��2 (����һ��ע��ĵط�)
Role = Class.define("Role");
function Role:_ctor()
	self:ctor("defName");
end
function Role:ctor(name)
	self.name=name;
	self:walk();
end
function Role:walk()
	print(self.name .." walk");
end

Monster = Class.define("Monster", Role);
function Monster:ctor(name)
	self:super(Monster,"ctor",name);
end

Class.new(Monster,"m1");

�����ӡ�Ľ����:
defName walk
m1 walk
����һ�������java��˵����Ľ��. ��java��,ֻ���ӡ��m1 walk. ��Ϊ������Ĭ���Զ������������е�ÿ���޲ι���
--]]
--[[���Է�������д��super
Role = Class.define("Role");
function Role:ctor(name)
	self.name=name;
end
function Role:walk()
	print(self.name .." role walk");
	self:speak();
end
function Role:speak()
	print("role speak");
end

Monster = Class.define("Monster", Role);
function Monster:ctor(name)
	self:super(Monster,"ctor",name);
end
function Monster:walk()
	print("monster walk");
	self:super(Monster,"walk");
end
function Monster:speak()
	print("monster speak");
end

Class.new(Monster,"m1"):walk();

�������:
monster walk
m1 role walk
monster sepak
��,�ڸ����е��õ�speak()��������ȷ��ָ��������, ͨ��superҲ����ȷ�ķ��ʵ������walk����
--]]
--[[����getter, setter(����as3,c#,vb.net�������е� get,set ����)
--�����ҹ涨����,��getter_,setter_��ͷ�ķ�������Ϊgetter��setter����������
Role = Class.define("Role");
function Role:_ctor()
	self._name=nil;
end
function Role:setter_name(v)
	self._name=v;
end
function Role:getter_name()
	return self._name;
end

local r = Class.new(Role);
r.name="r1";
print(r.name);

�������:
setter_name
getter_name
r1
˵����ȷ�ķ��ʵ���getter��setter,Ϊ���Եķ����ṩ�˸�����߼�����
--]]
--[[����Ĳ���
Role = Class.define("Role");
Role.name="static name";
Role.age=10;
function Role:_ctor()
	print("role self: ",self);
	self.age=20;
end

Monster = Class.define("Monster", Role);
function Monster:_ctor()
	print("monster self: ",self);
end

local m = Class.new(Monster);
print(m.name, Role.name, m.age, Role.age);

�������:
role self: table: 00437678
monster self: table: 00437678
static name	static name	20	10
���Կ�����Role�е�self��Monster��һ������.java��Ҳ�����.���358��
ͨ��ʵ������Ҳ�ܷ��ʵ�Role�ľ�̬����name,Ҳ��ӡ������ȷ�Ľ��,����javaһ��.
������ageȴ��һ��, java�лᱨһ������,��Ϊ�ظ�������age, ����Ϊ�˽�Լ����,��û����������ظ�����ļ��.���Կ����Ľ����self���ʵ�ʵ���е�age.�����������ֻ���Լ�����ȥд.
--]]

