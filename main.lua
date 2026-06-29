
window_width = 854
window_height = 480

virtual_width = 432
virtual_height = 243

paddle1x = virtual_width/2-215
paddle1y = virtual_height/2-5

paddle2x = virtual_width/2+210
paddle2y = virtual_height/2-5

ballx = virtual_width/2-2
bally = virtual_height/2-2

balldx = -100
balldy = 100

push = require 'push'

function love.load()

    love.window.setMode(window_width, window_height,{
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    push.setupScreen(virtual_width, virtual_height, {upscale='normal'})
end


function love.update(dt)

    if love.keyboard.isDown('w') and paddle1y ~= virtual_height-1 then
        paddle1y = paddle1y - 200 * dt
    end
    if love.keyboard.isDown('s') and paddle1y ~= 0 then
        paddle1y = paddle1y + 200 * dt
    end

    if love.keyboard.isDown('up') and paddle2y ~= virtual_height-1 then
        paddle2y = paddle2y - 200 * dt
    end
    if love.keyboard.isDown('down') and paddle2y ~= 0 then
        paddle2y = paddle2y + 200 * dt
    end



    --delimitador vertical do paddle1 and paddle2
    if paddle1y < 0 then
        paddle1y = 0 -200 * dt
    end

    if paddle1y > 216 then
        paddle1y = 216 + 200 * dt
    end

    if paddle2y < 0 then
        paddle2y = 0 -200 * dt
    end

    if paddle2y > 216 then
        paddle2y = 216 + 200 * dt
    end

    --ball movement
    ballx = ballx + balldx * dt
    bally = bally + balldy * dt

    --delimitador vertical bally
    
    if bally<= 0 then 
        balldy = balldy * -1
    end

    if bally >= virtual_height then
        balldy = balldy * -1
    end

    --delimitador horizontal ballx    --delimitador horizontal ballx
if ballx <= paddle1x and balldx < 0 then
    print("BATEU NA RAQUETE 1!") -- Isto vai escrever na sua consola de comandos
    balldx = balldx * -1
end


    if ballx >= paddle2x and balldx > 0 then
        print("BATEU NA RAQUETE 2!")
        balldx = balldx * -1
    end

end


function love.draw()
    
    push.start()
    love.graphics.printf("hello pong", 0, virtual_height/2-110,virtual_width , 'center')
    love.graphics.rectangle('fill', ballx, bally, 5, 5)
    love.graphics.rectangle('fill', paddle1x, paddle1y, 5, 25)
    love.graphics.rectangle('fill', paddle2x, paddle2y, 5, 25)
    push.finish()
end




function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end