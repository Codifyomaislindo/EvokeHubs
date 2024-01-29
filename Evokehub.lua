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

-- Adicionando uma nova seção "Mainx
local MainSection = AddSection(MainTab, {"Main"})

-- Adicionando um botão na nova seção "Main"
local MainButton = AddButton(MainSection, {
  Name = "auto parry",
  Callback = function()
    print("Botão Main clicado!")
    -- Adicione a lógica desejada aqui
  end
})

-- Adicionando uma nova aba chamada "Settings"
local SettingsTab = MakeTab({Name = "Settings"})

-- Adicionando uma nova seção "ESP Settings" na aba "Settings"
local ESPSettingsSection = AddSection(SettingsTab, {"ESP Settings"})

-- Adicionando um botão na nova seção "ESP Settings"
local ESPButton = AddButton(ESPSettingsSection, {
  Name = "Ativar ESP",
  Callback = function()
    local targetGameName = "Blox Fruits"
    local targetsNames = {["Fruit"] = true, ["Fruit "] = true}

    local gameName = string.sub(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, 1, #targetGameName)
    local playerGui = game.Players.LocalPlayer.PlayerGui

    -- Creates a screen gui for our script stuff
    local function createGui()
        local gui = Instance.new("ScreenGui")
        gui.Name = "scrGui"
        gui.Parent = playerGui
    end

    -- The switch to turn the ESP on/off
    local function createSwitch()
        local switch

        if (gameName == "Blox Fruits") then
            -- The settings image button at the right on Blox Fruits
            local settings = playerGui.Main.Settings

            -- Creates the ESP switch by making a copy of an existent one
            switch = settings.DmgCounterButton:Clone()
            switch.Notify.Text = "Shows where targets are located"
            switch.Position = UDim2.new(-1.2, 0, -4.03, 0) -- Above counter switch
            switch.Size = UDim2.new(5, 0, 0.8, 0) -- Similar size to the other switches
            switch.Parent = settings

            -- Shows/hide the switch when settings image button is clicked
            settings.Activated:Connect(function()
                if (switch.Visible) then
                    switch.Visible = false
                else
                    switch.Visible = true
                end
            end)
        else
            switch = Instance.new("TextButton")
            switch.Text = ""
            switch.BackgroundColor3 = Color3.fromRGB(255, 255, 55)
            switch.Position = UDim2.new(0.5, 0, 0, 2)
            switch.AnchorPoint = Vector2.new (0.5, 0)
            switch.Size = UDim2.fromOffset(70, 25)
            switch.Parent = playerGui.scrGui

            local label = Instance.new("TextLabel")
            label.BorderSizePixel = 0
            label.Position = UDim2.new(0.5, 0, 0.5, 0)
            label.AnchorPoint = Vector2.new (0.5, 0)
            label.Parent = switch
        end

        switch.Name = "espSwitch"
        switch.TextLabel.Text = "ESP (OFF)"

        return switch
    end

    -- Shows temporarily text at the middle of the screen
    local function toScreen(text, time, color)
        local time = time or 10
        local color = color or Color3.fromRGB(255, 255, 255)

        local label = Instance.new("TextLabel")
        label.Text = text
        label.TextColor3 = color
        label.FontSize = Enum.FontSize.Size14
        label.RichText = true
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0.5, 0, 0.7, 0)
        label.AnchorPoint = Vector2.new (0.5, 0)
        label.Size = UDim2.fromOffset(100, 25)
        label.Parent = playerGui.scrGui

        wait(time)

        label.Text = ""
    end

    -- Adds text to thing, you can see it through walls (ESP)
    local function addLabel(thing, name, color)
        local name = name or thing.Name
        local color =
