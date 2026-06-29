
window_width = 854
window_height = 480

virtual_width = 432
virtual_height = 243

paddle1x = virtual_width/2-215
paddle1y = virtual_height/2-5

paddle2x = virtual_width/2+210
paddle2y = virtual_height/2-5
ball= {x = virtual_width/2-2, y = virtual_height/2-2, width = 5, height = 5}
ballx = ball.x
bally = ball.y

balldx = -100
balldy = 100

pontosPlayer1 = 0
pontosPlayer2 = 0


estadoJogo = 'start'

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

    --  Movimentação das raquetes 
    if love.keyboard.isDown('w') then
        paddle1y = paddle1y - 200 * dt
    end
    if love.keyboard.isDown('s') then
        paddle1y = paddle1y + 200 * dt
    end

    if love.keyboard.isDown('up') then
        paddle2y = paddle2y - 200 * dt
    end
    if love.keyboard.isDown('down') then
        paddle2y = paddle2y + 200 * dt
    end

    --  Delimitadores verticais das raquetes 
    if paddle1y < 0 then
        paddle1y = 0
    elseif paddle1y > virtual_height - 25 then
        paddle1y = virtual_height - 25
    end

    if paddle2y < 0 then
        paddle2y = 0
    elseif paddle2y > virtual_height - 25 then
        paddle2y = virtual_height - 25
    end

    --  Delimitador vertical da bola 
    if bally <= 0 then 
        bally = 0
        balldy = balldy * -1
    elseif bally >= virtual_height - 5 then
        bally = virtual_height - 5
        balldy = balldy * -1
    end

    -- movimentação da bola
    if estadoJogo == 'play' then
        ballx = ballx + balldx * dt
        bally = bally + balldy * dt
    end

    function checkColisao(ball, paddle)
        if ball.x < paddle.x + paddle.width and
           ball.x + ball.width > paddle.x and
           ball.y < paddle.y + paddle.height and
           ball.y + ball.height > paddle.y then
            return true
        end
        return false
    end

    -- Colisão com Raquete 1 (Esquerda)
    if checkColisao({x = ballx, y = bally, width = 5, height = 5}, {x = paddle1x, y = paddle1y, width = 5, height = 25}) then
        balldx = balldx * -1
        ballx = paddle1x + 5 
    end

    -- Colisão com Raquete 2 (Direita)
    if checkColisao({x = ballx, y = bally, width = 5, height = 5}, {x = paddle2x, y = paddle2y, width = 5, height = 25}) then
        balldx = balldx * -1
        ballx = paddle2x - 5 
    end


    function resetBall()
        ballx = virtual_width / 2 - 2
        bally = virtual_height / 2 - 2
        balldx = -balldx 
        balldy = 100
    end

    --  Pontuação
    if ballx < 0 then
        pontosPlayer2 = pontosPlayer2 + 1
        resetBall()
    end

    if ballx > virtual_width then
        pontosPlayer1 = pontosPlayer1 + 1
        resetBall()
    end

end



function love.draw()
    
    push.start()
    love.graphics.printf("PONG", 0, virtual_height/2-110,virtual_width , 'center')
    love.graphics.rectangle('fill', ballx, bally, 5, 5)
    love.graphics.rectangle('fill', paddle1x, paddle1y, 5, 25)
    love.graphics.rectangle('fill', paddle2x, paddle2y, 5, 25)
    love.graphics.printf("Player 1", -150, 20, virtual_width, 'center')
    love.graphics.printf("Player 2", 150, 20, virtual_width, 'center')
    push.finish()
end




function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if estadoJogo == 'start' then
            estadoJogo = 'play'
        else
            estadoJogo = 'start'
            pontosPlayer1 = 0
            pontosPlayer2 = 0
            resetBall()
        end
    end
end