-- 罗技LUA压枪脚本（仅适用罗技系列鼠标）

-- 关键 压枪参数配置
local recoilStrength = 1    -- 压枪力度（像素）
local fireInterval = 3     -- 射击间隔(ms)

-- 压枪开关状态（默认）
local recoilEnabled = false
-- 启用左键事件检测
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    -- 侧键4：开启压枪并切换武器
    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 then
        recoilEnabled = true
        -- 切换武器2号位
        PressKey("2")
        Sleep(50)
        ReleaseKey("2")
        OutputLogMessage("压枪功能已开启\n")
    
    -- 侧键5：关闭压枪并模拟G键长按
    elseif event == "MOUSE_BUTTON_PRESSED" and arg == 5 then
        recoilEnabled = false
        PressKey("g")
        OutputLogMessage("压枪功能已关闭\n")
    
    -- 侧键5释放：释放G键
    elseif event == "MOUSE_BUTTON_RELEASED" and arg == 5 then
        ReleaseKey("g")
    
    -- 左键按下：开始射击
    elseif event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
        if recoilEnabled then
            OutputLogMessage("开始压枪射击\n")
            -- 使用循环进行持续压枪
            while IsMouseButtonPressed(1) do
                MoveMouseRelative(0, recoilStrength)  -- 向下压枪
                Sleep(fireInterval)                   -- 控制压枪频率
            end
            OutputLogMessage("压枪结束\n")
        else
            OutputLogMessage("普通射击模式\n")
            -- 普通射击模式，不进行压枪
            repeat
                Sleep(10)
            until not IsMouseButtonPressed(1)
        end
    end
end