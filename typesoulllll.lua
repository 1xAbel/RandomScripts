getgenv().autoWebhook = true

local sent = {}
local HttpService = game:GetService("HttpService")

local function webHook(item)
    local data = {
        ["username"] = "lazy hub | type soul",
        ["embeds"] = {
            {
                ["title"] = "**afk drop**",
                ["description"] = "**User** : ||"..game.Players.LocalPlayer.Name.."||\n**Drop** : "..item,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
            }
        }
    }
    local newdata = HttpService:JSONEncode(data)
    local headers = {["content-type"] = "application/json"}
    local requestFunc = http_request or request or HttpPost or syn.request
    requestFunc({Url = getgenv().disc_url, Body = newdata, Method = "POST", Headers = headers})
end

while getgenv().autoWebhook do task.wait()
    local pg = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    for _, obj in ipairs(pg:GetDescendants()) do -- might be laggy!!! 
        if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and obj.Text:match("obtained%.") then
            if not sent[obj] then
                sent[obj] = true
                webHook(obj.Text)
            end
        end
    end
end

