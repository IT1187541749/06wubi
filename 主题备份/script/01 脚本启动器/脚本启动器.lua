
--[[
--无障碍版专用脚本
--脚本启动器
--版本号: 1.4
--制作日期
▂▂▂▂▂▂▂▂
日期: 2020年05月07日🗓️
农历: 鼠(庚子)年四月十五
时间: 15:25:05🕒
星期: 周四
--用途：用于启动指定目录下相关脚本,生成键盘,点击使用相关脚本功能
--制作者: 风之漫舞
--首发qq群: 同文堂(480159874)
--邮箱: bj19490007@163.com(不一定及时看到)

]]


require "import"
import "java.io.File"
import "android.os.*"

import "script.包.其它.主键盘"

local 参数=(...)
local 编号=1

local 脚本目录=tostring(service.getLuaExtDir("script"))
local 脚本名=debug.getinfo(1,"S").source:sub(2)--获取Lua脚本的完整路径

local 脚本相对路径=string.sub(脚本名,#脚本目录+1)
local 纯脚本名=File(脚本名).getName()
local 纯脚本名无后缀=File(脚本名).getName():sub(1,-5)
local 目录=string.sub(脚本名,1,#脚本名-#纯脚本名).."脚本库"




import "script.包.文件操作.递归查找文件"
local 文件组=递归查找文件(File(目录),".lua$")
--取脚本相对路径
for i=1,#文件组 do
 文件组[i]=string.sub(文件组[i],#脚本目录+1)
end





if string.sub(参数,1,1)=="<" && string.sub(参数,3,3)==">" then
 编号=tonumber(string.sub(参数,2,2))
end

table.sort(文件组)--数组排序

local 按键组={}

--写编号提示
local 总序号=math.ceil(#文件组/25)
local 按键={}
 按键["width"]=100
-- 按键["height"]=25
 按键["click"]=""
 按键["label"]=string.sub(纯脚本名,1,#纯脚本名-4).."("..编号.."/"..总序号..")"
 按键组[#按键组+1]=按键




if 编号==1 then
 if #文件组<25 then
  for i=1,#文件组 do
   local 按键={}
   按键["label"]=File(文件组[i]).getName():sub(1,-5)
   按键["click"]={label=按键["label"], send="function",command= 文件组[i],option= "1"}
   按键组[#按键组+1]=按键
   
   
  end--for i=1,#文件组
  local 按键={}
  按键["width"]=20
  for i=1,24-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  按键组[#按键组+1]=主键盘()
 else
  for i=1,23 do
   local 子编号=i
   if #文件组>子编号-1 then
    local 按键={}
   按键["label"]=File(文件组[子编号]).getName():sub(1,-5)
   按键["click"]={label=按键["label"], send="function",command= 文件组[子编号],option= "1"}
   按键组[#按键组+1]=按键
   end--if
  end--for

 local 按键={}
 按键["click"]={label="▶", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 按键组[#按键组+1]=按键
 按键组[#按键组+1]=主键盘()

 end--if #文件组<25
end--if 编号==1

if 编号>1 then
if #文件组<编号*23 then
  for i=1,22 do
   local 子编号=i
   local 位置=子编号+(编号-1)*23
   if #文件组>位置 then
    local 按键={}
    按键["label"]=File(文件组[位置]).getName():sub(1,-5)
    按键["click"]={label=按键["label"], send="function",command= 文件组[位置],option= "1"}
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
  按键["width"]=20
  for i=1,23*编号-#文件组 do
   按键组[#按键组+1]=按键
  end--for
  local 按键={}
  按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 按键组[#按键组+1]=按键
 按键组[#按键组+1]=主键盘()
else
  for i=1,22 do
   local 子编号=i
   local 位置=子编号+(编号-1)*23
   if #文件组>位置 then
    local 按键={}
    按键["label"]=File(文件组[位置]).getName():sub(1,-5)
    按键["click"]={label=按键["label"], send="function",command= 文件组[位置],option= "1"}
    按键组[#按键组+1]=按键
   end--if
  end--for
  local 按键={}
 按键["click"]={label="◀", send="function",command= 脚本相对路径,option= "<"..(编号-1)..">"}
 按键组[#按键组+1]=按键
 local 按键={}
 按键["click"]={label="▶", send="function",command= 脚本相对路径,option= "<"..(编号+1)..">"}
 
 按键组[#按键组+1]=按键
 
 
 按键组[#按键组+1]=主键盘()

end--if #文件组>编号*22
end--if 编号>1 


--print(8%5)

for i=1,#按键组 do
 if i%2==1 then
--  按键组[i]["key_back_color"]="#ffd7dade"
 end
end



service.setKeyboard{
  name=纯脚本名无后缀,
  ascii_mode=0,
  width=20,
  height=62.5,
  keys=按键组
  }





















