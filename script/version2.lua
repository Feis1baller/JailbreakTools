local function getTime()
    local date = os.date("*t")
    return ("%02d:%02d:%02d"):format(date.hour, date.min, date.sec)
end
rconsoleclear()
rconsolename("Jailbreak Tools ~ Made by K1ko")
local function printTime()
    local T = string.split(getTime(), ":")
    rconsoleprint("@@WHITE@@")
    rconsoleprint("[")
    for I, V in next, T do
        rconsoleprint("@@DARK_GRAY@@")
        rconsoleprint(V)
        rconsoleprint("@@WHITE@@")
        if I ~= #T then
            rconsoleprint(":")
        end
    end
    rconsoleprint("@@WHITE@@")
    rconsoleprint("] ")
end
local function print(...)
    local arguments = {...}
    rconsoleprint("@@WHITE@@")
    for _, V in next, arguments do
        V = tostring(V)
        if V:find("color") then
            V = V:gsub("color%(", "")
            V = V:gsub("%)", "")
            rconsoleprint("@@" .. string.upper(V) .. "@@")
        elseif V:find("time") then
            printTime()
        elseif V:find("separate") then
            V = V:gsub("separate%(", "")
            V = V:gsub("%)", "")
            if string.upper(V) == "NEWLINE" then
                rconsoleprint("\n")
            else
                local CHAR1 = V:sub(1, 1)
                local CHAR2 = V:sub(2, 2)
                local AMOUN = 50
                for I = 1, AMOUN do
                    rconsoleprint(CHAR1 .. CHAR2)
                end
            end
        elseif V:find(":") then
            rconsoleprint("@@WHITE@@")
            rconsoleprint("[")
            for I2, V2 in next, string.split(V, ":") do
                rconsoleprint("@@DARK_GRAY@@")
                rconsoleprint(V2)
                rconsoleprint("@@WHITE@@")
                if I2 ~= #string.split(V, ":") then
                    rconsoleprint("->")
                end
            end
            rconsoleprint("@@WHITE@@")
            rconsoleprint("]: ")
        else
            if V ~= "..." then
                rconsoleprint(tostring(V))
            end
        end
    end
    if arguments[#arguments] ~= "..." then
        rconsoleprint("\n")
    end
    rconsoleprint("@@WHITE@@")
end

function convert(closure)
	return ((tostring(closure)):gsub("(.+):", "")):gsub(" ", ""):gsub("00000000", "fffffff"):upper()
end

print(
"#", "Author: K1ko", "\n",
"#", "Version: v2", "\n",
"#", "Release date: 2021-02-19", "\n",
"[-------] PROJECT [-------]", "\n",
"#", "Project:Description", "Equip/UnEquip items that are currently in your inventoru without firing any remote keys by yourself. Supports Jailbreak v800-822 and probably even further back.\n",
"This exploitment of the inventory system may get patched in the next few updates.\n",
"I am not planning on unpatching this script, but there is still a small chance I do!",
"\n\n[-------] LOGS [-------]"
)
function convert(closure)
	return ((tostring(closure)):gsub("(.+):", "")):gsub(" ", ""):gsub("00000000", "fffffff"):lower()
end

local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Hotbar__3 = game:GetService("ReplicatedStorage").Game.Hotbar
local u2 = require(l__ReplicatedStorage__2.Game.Inventory);
local u3 = require(l__Hotbar__3)
local GetEquipped
for _,k in pairs(getgc(true)) do
    if typeof(k) == "function" and islclosure(k) then
        if getinfo(k).name == "GetEquipped" then
            GetEquipped = k
			print("GetEquipped ", "color(light_red)", "<closure>", "color(white)", " -> ", convert(k))
        end
    end
end

local function getNameFromId(p1)
    local l__Bypass__4
    for k,v in next, u2.ItemStacks do
        if v.i == p1 then
            return v, v.Name
        end
    end
end

function UnEquip()
	print("Beginning 'UnEquip'..")
    local slot_idx = 0
    for k,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HotbarGui.Container:GetChildren()) do
        if getNameFromId(v.Name) and type(getNameFromId(v.Name)) == "table" and GetEquipped(game:GetService("Players").LocalPlayer) then
            local array, name = getNameFromId(v.Name)
            slot_idx = slot_idx + 1
            game:GetService("VirtualInputManager"):SendKeyEvent(true,  48 + slot_idx, false, game)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, 48 + slot_idx, false, game)
            wait(.5)
            print((not GetEquipped(game:GetService("Players").LocalPlayer) and "Successfully UnEquipped your item!") or "Failed to UnEquip your item!")
            return
        elseif not GetEquipped(game:GetService("Players").LocalPlayer) then
        	print("color(red)", "Please Equip the item you're holding before attempting to UnEquip.")
        	return
        end
    end
    print("color(red)", "Something went wrong while UnEquipping!")
end
function Equip(item)
	print("Beginning 'Equip'..")
    local slot_idx = 0
    for k,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HotbarGui.Container:GetChildren()) do
        if getNameFromId(v.Name) and type(getNameFromId(v.Name)) == "table" and not GetEquipped(game:GetService("Players").LocalPlayer) then
            local array, name = getNameFromId(v.Name)
            slot_idx = slot_idx + 1
            if name == item then
                game:GetService("VirtualInputManager"):SendKeyEvent(true,  48 + slot_idx, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, 48 + slot_idx, false, game)
            	wait(.5)
            	print((GetEquipped(game:GetService("Players").LocalPlayer) and "Successfully Equipped your item!") or "Failed to Equip your item!")
            	return
            end
        elseif GetEquipped(game:GetService("Players").LocalPlayer) then
        	print("color(red)", "Please UnEquip the item you're holding before attempting to hold another one.")
        	return
        end
    end
    print("color(red)", "Couldn't find the item you was looking for!")
end
Equip("Pistol")
