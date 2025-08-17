getgenv().disc_url = ''

local function webHook(url, item)
    local url = url

    local data = {
        ["username"] = "lazy hub | type soul",
        ["content"] = "",
        ["embeds"] = {
            {
                ["title"] = "afk drop",
                ["description"] = "User : ||"..game.Players.LocalPlayer.Name.."||\nDrop : "..item,
                ["type"] = "rich",
                ["color"] = tonumber(0x7269da),
            }
        }
    }

    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {["content-type"] = "application/json"}
    request = http_request or request or HttpPost
    local webhook = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(webhook)
end

getgenv().outputWebhooks = true
local lp = game.Players.LocalPlayer
repeat task.wait() until lp.PlayerGui.ScreenEffects:WaitForChild("TextScroller")
local textScrolling = lp.PlayerGui.ScreenEffects:WaitForChild("TextScroller")
textScrolling.ChildAdded:Connect(function(v)
    if getgenv().outputWebhooks then else return end
    if v.Name == "Notification" and v.Text:match("obtained") then
        webHook(getgenv().disc_url, v.Text)
    end
end)
