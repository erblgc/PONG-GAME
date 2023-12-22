local love = require("love")
local Ball = require("object/Ball")
local Bracket = require("object/Bracket")
local Conf = require("conf")
local Menu = require("object/Menu")
local Wall = require("object/Wall")

math.randomseed(os.time())

function love.load()
    Conf()
    bracket1 = Bracket() -- create brackets
    bracket2 = Bracket() -- create brackets
    font = love.graphics.newFont("font/superglue.ttf" , 24)
    menu = Menu()
    custom_cursor = love.mouse.newCursor("images/cursor.png", 0, 0)
    love.mouse.setCursor(custom_cursor)
    button_click = love.audio.newSource("audio/button_click.wav","static")
    menu_music = love.audio.newSource("audio/menu_music.wav","stream")
    inGame_music = love.audio.newSource("audio/inGame_music.wav","stream")
    currentMusic = nil
    ball = Ball()
    wall = Wall()
end

-- hover checker for menu buttons
local start_hover = false 
local options_hover = false
local exit_hover = false

local player1Score = 0
local player2Score = 0

local states = {
    running = false,
    paused = false,
    menu = true,
    options = false,
    check_paused = false,
    hardness = false,
    gameover = false
}


function playMusic(source)
    love.audio.stop()  -- Önceki müziği durdur
    currentMusic = source
    currentMusic:setLooping(true)
    love.audio.play(currentMusic)
    
end

function hideMouse () -- hides mouse when game is running
    if states.running then
        love.mouse.setVisible(false)
    elseif not states.running then
        love.mouse.setVisible(true)
    end    
end

function love.keypressed(key) 
    if states.running then 
        if key == "escape" then -- pause game
            love.audio.play(button_click)
            love.audio.setVolume(1)
            states.paused = true
            states.running = false
            states.check_paused = true
        end

    elseif states.paused then -- unpause game 
        if key == "escape" then
            love.audio.play(button_click)
            love.audio.setVolume(1)
            states.paused = false
            states.running = true
            states.check_paused = false
        end
    elseif states.options then
        if states.check_paused then
            if key == "escape" then
                love.audio.play(button_click)
                love.audio.setVolume(1)
                states.options = false
                states.paused = true
                states.check_paused = false
            end
        end
    elseif states.options then
        if not states.check_paused then
            if key == "escape" then
                love.audio.play(button_click)
                love.audio.setVolume(1)
                states.options = false
                states.menu = true
                states.check_paused = false
            end
        end
    end
end


function love.mousepressed(x, y, button)
    if button == 1 then
        if menu:checkPressed( -- start game
            love.graphics.getWidth()/2 - menu.button_width/2,
            love.graphics.getHeight()/2 - menu.button_height/2 - 60,
            menu.button_width,
            menu.button_height
        ) then
            if states.menu then -- start game
                love.audio.play(button_click) -- play button click sound
                states.menu = false
                states.hardness = true -- hardness menu
                states.paused = false
            elseif states.paused then
                love.audio.play(button_click)
                love.audio.setVolume(1)
                states.paused = false
                states.running = true
                states.check_paused = false
            
            elseif states.hardness then
                love.audio.play(button_click)
                love.audio.setVolume(1)
                states.hardness = false
                states.running = true
                states.check_paused = false
                ball.xVelocity = -675
            end

        end

        if menu:checkPressed(
            love.graphics.getWidth() / 2 - menu.button_width / 2,
            love.graphics.getHeight() / 2 - menu.button_height / 2,
            menu.button_width,
            menu.button_height
        ) then
            love.audio.play(button_click)
            love.audio.setVolume(1)

            if states.options then
                states.options = false
                states.menu = true
                states.running = false
                states.check_paused = false
            elseif states.paused then
                states.options = true
                states.paused = false
                states.running = false
            elseif states.hardness then
                states.hardness = false
                states.running = true
                states.check_paused = false
                states.options = false
                ball.xVelocity = -850
            end
        end


        if menu:checkPressed( -- exit button
            love.graphics.getWidth()/2 - menu.button_width/2,
            love.graphics.getHeight()/2 - menu.button_height/2 + 60,
            menu.button_width,
            menu.button_height
        ) then
            love.audio.play(button_click)
            love.audio.setVolume(1)
            if states.menu then
                love.event.quit()
            elseif states.paused then
                states.paused = false
                states.menu = true
            elseif states.hardness then
                states.hardness = false
                states.running = true
                ball.xVelocity = -1125
            end
        end
    end
end


function hover_checker() -- checks if mouse is hovering over buttons
    if menu:checkPressed(
        love.graphics.getWidth()/2 - menu.button_width/2,
        love.graphics.getHeight()/2 - menu.button_height/2 - 60,
        menu.button_width,
        menu.button_height
    ) then
        start_hover = true
    else 
        start_hover = false
    end
    if menu:checkPressed(
        love.graphics.getWidth()/2 - menu.button_width/2,
        love.graphics.getHeight()/2 - menu.button_height/2 + 60,
        menu.button_width,
        menu.button_height
    ) then
        exit_hover = true
    else
        exit_hover = false
    end
    if menu:checkPressed(
        love.graphics.getWidth()/2 - menu.button_width/2,
        love.graphics.getHeight()/2 - menu.button_height/2,
        menu.button_width,
        menu.button_height
    ) then
        options_hover = true
    else
        options_hover = false
    end
end

function gameover_check()
    if player1Score == 5 then
        states.gameover = true
        states.running = false
        states.paused = false
        states.menu = false
        states.options = false
        states.hardness = false
        states.check_paused = false
    elseif player2Score == 5 then
        states.gameover = true
        states.running = false
        states.paused = false
        states.menu = false
        states.options = false
        states.hardness = false
        states.check_paused = false
    end
end

function love.update(dt)
    if states.running then
        if love.keyboard.isDown("w") then
            bracket1:moveUp(dt)
        end
        if love.keyboard.isDown("s") then
            bracket1:moveDown(dt)
        end
        if love.keyboard.isDown("up") then
            bracket2:moveUp(dt)
        end
        if love.keyboard.isDown("down") then
            bracket2:moveDown(dt)
        end
        ball:update(dt)
        if ball:checkCollision(bracket1.x_p1,bracket1.y,BRACKET_WIDTH,BRACKET_HEIGHT) then
            ball:bounce(bracket1)
        end
        if ball:checkCollision(bracket2.x_p2,bracket2.y,BRACKET_WIDTH,BRACKET_HEIGHT    ) then
            ball:bounce(bracket2)
        end
        if ball.x < - 500 then
            player2Score = player2Score + 1
            ball:reset()
            bracket1:reset()
            bracket2:reset()
        end
        if ball.x > love.graphics.getWidth() + 500 then
            player1Score = player1Score + 1
            ball:reset()
            bracket1:reset()
            bracket2:reset()
        end
        if ball.y < 0 then
            ball.yVelocity = -ball.yVelocity
        end
        if ball.y > love.graphics.getHeight() - ball.width then
            ball.yVelocity = -ball.yVelocity
        end
        bracket1:checkGrounded()
        bracket2:checkGrounded()
        
        gameover_check()
    end

    hideMouse()
    hover_checker()
    if states.menu and currentMusic ~= menu_music then
        playMusic(menu_music)
        love.audio.setVolume(0.1)
    end
    if states.running and currentMusic ~= inGame_music then
        playMusic(inGame_music)
        love.audio.setVolume(0.1)
    end
    if states.paused and currentMusic ~= menu_music then
        playMusic(menu_music)
        love.audio.setVolume(0.1)
    end
    if states.menu and currentMusic == menu_music then
        love.audio.setVolume(0.1)
    end
end

function love.draw()
    if states.running then
        bracket1:draw(bracket1.x_p1,bracket1.y,COLOR_RUNNING)
        bracket2:draw(bracket2.x_p2,bracket2.y,COLOR_RUNNING)
        ball:draw(COLOR_RUNNING)
        wall:draw()
        love.graphics.setColor(1,1,1)
        love.graphics.print("Player 1: " .. player1Score, 20, 20)
        local player2ScoreWidth = font:getWidth("Player 2: " .. player2Score)
        love.graphics.print("Player 2: " .. player2Score, love.graphics.getWidth() - player2ScoreWidth - 20, 20)
    
    elseif states.paused then
        bracket1:draw(bracket1.x_p1,bracket1.y,COLOR_PAUSED)
        bracket2:draw(bracket2.x_p2,bracket2.y,COLOR_PAUSED)
        ball:draw(COLOR_PAUSED)
    end
    if states.paused then
        if not start_hover then
            menu:resume_button()
        
        elseif start_hover then
            menu:hover_resume()
        end
        if not options_hover then
            menu:options_button()
        elseif options_hover then
            menu:hover_options()
        end
        if not exit_hover then
            menu:back_button()
        elseif exit_hover then
            menu:hover_back()
        end
    end
    if states.menu then
        if not start_hover then
            menu:start_button()

        elseif start_hover then
            menu:hover_start()
        end
        if not options_hover then

            menu:options_button()

        elseif options_hover then
            menu:hover_options()
        end
        if not exit_hover then
            menu:exit_button()

        elseif exit_hover then
            menu:hover_exit()
        end
    end

    if states.options then
        -- TODO
    end
    if states.hardness then
        if not start_hover then
            menu:slow_button()

        elseif start_hover then
            menu:hover_slow()
        end
        if not options_hover then

            menu:medium_button()

        elseif options_hover then
            menu:hover_medium()
        end
        if not exit_hover then
            menu:fast_button()

        elseif exit_hover then
            menu:hover_fast()
        end
    end
    winner = nil
    function setWinnter()
        if player1Score == 5 then
            winner = "Player 1"
        elseif player2Score == 5 then
            winner = "Player 2"
        end
    end
    if states.gameover then
        love.graphics.setColor(1,1,1)
        love.graphics.print("Game Over", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 - 100)
        setWinnter()
        love.graphics.print(winner .. " wins!", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 - 50)
        love.graphics.print("Press ESC to return to menu", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2)
        if love.keyboard.isDown("escape") then
            states.gameover = false
            states.menu = true
            states.running = false
            states.paused = false
            states.options = false
            states.hardness = false
            states.check_paused = false
            player1Score = 0
            player2Score = 0

        end
    end
end