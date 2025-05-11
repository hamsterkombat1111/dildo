-- Создаем главный GUI объект
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DildoMenu"
gui.Parent = player:WaitForChild("PlayerGui")

-- Основной фрейм меню
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

-- Заголовок меню
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
title.Text = "Дилдо"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = mainFrame

-- Таймер
local timerLabel = Instance.new("TextLabel")
timerLabel.Name = "TimerLabel"
timerLabel.Size = UDim2.new(1, -40, 0, 60)
timerLabel.Position = UDim2.new(0, 20, 0, 50)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "00:00"
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.TextSize = 40
timerLabel.Parent = mainFrame

-- Кнопки управления таймером
local startButton = Instance.new("TextButton")
startButton.Name = "StartButton"
startButton.Size = UDim2.new(0, 80, 0, 30)
startButton.Position = UDim2.new(0, 20, 0, 130)
startButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
startButton.Text = "Старт"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.Font = Enum.Font.SourceSans
startButton.TextSize = 18
startButton.Parent = mainFrame

local resetButton = Instance.new("TextButton")
resetButton.Name = "ResetButton"
resetButton.Size = UDim2.new(0, 80, 0, 30)
resetButton.Position = UDim2.new(0.5, -40, 0, 130)
resetButton.BackgroundColor3 = Color3.fromRGB(150, 150, 50)
resetButton.Text = "Сброс"
resetButton.TextColor3 = Color3.new(1, 1, 1)
resetButton.Font = Enum.Font.SourceSans
resetButton.TextSize = 18
resetButton.Parent = mainFrame

local stopButton = Instance.new("TextButton")
stopButton.Name = "StopButton"
stopButton.Size = UDim2.new(0, 80, 0, 30)
stopButton.Position = UDim2.new(1, -100, 0, 130)
stopButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
stopButton.Text = "Стоп"
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.Font = Enum.Font.SourceSans
stopButton.TextSize = 18
stopButton.Parent = mainFrame

-- Логика таймера
local isRunning = false
local startTime = 0
local elapsedTime = 0

local function formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = math.floor(seconds % 60)
    return string.format("%02d:%02d", minutes, remainingSeconds)
end

local function updateTimer()
    while isRunning do
        local currentTime = os.time() - startTime + elapsedTime
        timerLabel.Text = formatTime(currentTime)
        wait(0.1)
    end
end

startButton.MouseButton1Click:Connect(function()
    if not isRunning then
        isRunning = true
        startTime = os.time()
        spawn(updateTimer)
    end
end)

stopButton.MouseButton1Click:Connect(function()
    if isRunning then
        isRunning = false
        elapsedTime = os.time() - startTime + elapsedTime
    end
end)

resetButton.MouseButton1Click:Connect(function()
    isRunning = false
    elapsedTime = 0
    timerLabel.Text = "00:00"
end)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
