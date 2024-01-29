loadstring(game:HttpGet(("https://raw.githubusercontent.com/REDzHUB/LibraryV2/main/redzLib")))()

MakeWindow({
  Hub = {
    Title = "EvoHub",
    Animation = "créditos da animação : redz9999"
  },
  Key = {
    KeySystem = false,
    Title = "Key System",
    Description = "",
    KeyLink = "",
    Keys = {"1234"},
    Notifi = {
      Notifications = true,
      CorrectKey = "Running the Script...",
      Incorrectkey = "The key is incorrect",
      CopyKeyLink = "Copied to Clipboard"
    }
  }
})

-- Substituindo a imagem do MinimizeButton
MinimizeButton({
  Image = "https://cdn.discordapp.com/attachments/1200464764116144196/1201376271456809010/20240129_005636_0000.png?ex=65c997d7&is=65b722d7&hm=87b66c4f1a8f773a64bc7eb5c60e4dcbb45cb8ae53a71f12ecb33c9851e4e4d2&",
  Size = {40, 40},
  Color = Color3.fromRGB(10, 10, 10),
  Corner = true,
  Stroke = false,
  StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- Adicionando uma nova aba chamada "Main"
local MainTab = MakeTab({Name = "Main"})

-- Adicionando uma nova seção "Main"
local MainSection = AddSection(MainTab, {"Main"})

-- Adicionando um botão na nova seção "Main"
local MainButton = AddButton(MainSection, {
  Name = "Auto Parry",
  Callback = function()
    print("Auto Parry ativado!")

    local workspace = game:GetService("Workspace")
    local players = game:GetService("Players")
    local runService = game:GetService("RunService")
    local vim = game:GetService("VirtualInputManager")

    local ballFolder = workspace.Balls
    local indicatorPart = Instance.new("Part")
    indicatorPart.Size = Vector3.new(5, 5, 5)
    indicatorPart.Anchored = true
    indicatorPart.CanCollide = false
    indicatorPart.Transparency = 1
    indicatorPart.BrickColor = BrickColor.new("Bright red")
    indicatorPart.Parent = workspace

    local lastBallPressed = nil
    local isKeyPressed = false

    local function calculatePredictionTime(ball, player)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local relativePosition = ball.Position - rootPart.Position
            local velocity = ball.Velocity + rootPart.Velocity 
            local a = (ball.Size.magnitude / 2) 
            local b = relativePosition.magnitude
            local c = math.sqrt(a * a + b * b)
            local timeToCollision = (c - a) / velocity.magnitude
            return timeToCollision
        end
        return math.huge
    end

    local function updateIndicatorPosition(ball)
        indicatorPart.Position = ball.Position
    end

    local function checkProximityToPlayer(ball, player)
        local predictionTime = calculatePredictionTime(ball, player)
        local realBallAttribute = ball:GetAttribute("realBall")
        local target = ball:GetAttribute("target")
        
        local ballSpeedThreshold = math.max(0.4, 0.6 - ball.Velocity.magnitude * 0.01)

        if predictionTime <= ballSpeedThreshold and realBallAttribute == true and target == player.Name and not isKeyPressed then
            vim:SendKeyEvent(true, Enum.KeyCode.F, false, nil)
            wait(0.005)
            vim:SendKeyEvent(false, Enum.KeyCode.F, false, nil)
            lastBallPressed = ball
            isKeyPressed = true
        elseif lastBallPressed == ball and (predictionTime > ballSpeedThreshold or realBallAttribute ~= true or target ~= player.Name) then
            -- Adicione qualquer lógica adicional aqui, se necessário
        end
    end

    -- Adicione aqui o código para verificar a proximidade do jogador com as bolas no Workspace
    -- Exemplo:
    for _, ball in ipairs(ballFolder:GetChildren()) do
        if ball:IsA("BallClass") then
            checkProximityToPlayer(ball, players.LocalPlayer)
        end
    end
  end
})

-- Adicionando uma nova aba chamada "FPS"
local FPSTab = MakeTab({Name = "FPS"})

-- Adicionando uma nova seção "ESP" na aba "FPS"
local ESPSection = AddSection(FPSTab, {"ESP"})

-- Adicionando um botão na nova seção "ESP"
local ESPButton = AddButton(ESPSection, {
  Name = "Ativar ESP",
  Callback = function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Enabled = false

    local function DrawPlayers()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local HumanoidRootPart = player.Character.HumanoidRootPart
                local BillboardGui = Instance.new("BillboardGui", ScreenGui)
                BillboardGui.Adornee = HumanoidRootPart
                BillboardGui.Size = UDim2.new(0, 5, 0, 5)
                BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                BillboardGui.AlwaysOnTop = true
                BillboardGui.Enabled = true

                local ImageLabel = Instance.new("ImageLabel", BillboardGui)
                ImageLabel.BackgroundTransparency = 1
                ImageLabel.Size = UDim2.new(1, 0, 1, 0)
                ImageLabel.Image = "rbxassetid://3570695787"
                ImageLabel.ImageColor3 = Color3.new(0, 1, 0)
            end
        end
    end

    DrawPlayers()
  end
})

-- ... (código existente)
