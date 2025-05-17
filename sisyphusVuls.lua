local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "aha",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}
local Tab = GUI:Tab{
	Name = "Main",
	Icon = "rbxassetid://8569322835"
}

Tab:Toggle{
	Name = "Auto Win",
	StartingState = false,
	Description = nil,
	Callback = function(t) 
        getgenv().win = t
        while win do task.wait()
            game:GetService("ReplicatedStorage").Remote.Event.Game["[C-S]PlayerEnd"]:FireServer("Fight20")
        end
	end
}
Tab:Toggle{
	Name = "Fast Auto Train",
	StartingState = false,
	Description = nil,
	Callback = function(t) 
        getgenv().train = t
        while train do task.wait()
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Train"):WaitForChild("[C-S]PlayerTryClick"):FireServer(true)
        end
	end
}
Tab:Toggle{
	Name = "Fast Auto Eat",
	StartingState = false,
	Description = nil,
	Callback = function(t)
		getgenv().eat = t
		while eat do task.wait()
			game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Food"):WaitForChild("[C-S]TryEatFood"):FireServer()
		end
	end	
}
Tab:Toggle{
	Name = "Inf ForeverPack",
	StartingState = false,
	Description = nil,
	Callback = function(t)
		getgenv().ba = t
		
		while ba do task.wait()
			game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("ForverPack"):WaitForChild("[C-S]TryClaimForverPack"):FireServer(1)
		end
	end
}
Tab:Toggle{
	Name = "Auto Open Chest",
	StartingState = false,
	Description = nil,
	Callback = function(t)
		getgenv().chest = t
		
		while chest do task.wait()
			local args = {
                "Wooden Chest"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("Event"):WaitForChild("Chest"):WaitForChild("[C-S]TryOpenChest"):FireServer(unpack(args))
		end
	end
}
