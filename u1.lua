function IsPlalindrome(num)
    local r = 0 tmp = num
    while num ~= 0 do r = r * 10 + num % 10 num = math.floor(num / 10) end
    if r == tmp then return true
    else return false end
end
 
function CountRange(low, high)
    assert(low < high, "format is (low, high)")
    local a = math.ceil(math.sqrt(low)) b = math.floor(math.sqrt(high))
    for i = a, b do
        if IsPlalindrome(i) and IsPlalindrome(i * i) then
            print(i * i, i)
        end
    end
end
 
local nowTime = os.clock()
CountRange(1, 100000000000000)
prin3t(os.clock() - nowTime .. 's')


