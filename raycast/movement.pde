
boolean moveUp = false, moveDown = false, turnLeft = false, turnRight = false;
boolean lookUp = false, lookDown = false;
boolean sprint = false;

float SPEED = 0.02;
float BACK_SPEED_SCALE = 0.5;
float SPRINT_SPEED_SCALE = 2;
float ROT_SPEED = 2;

void move()
{
    if (turnLeft) 
    {
        playerTheta -= ROT_SPEED; 
        if (playerTheta < 0)   playerTheta += 360;
    }
    if (turnRight) 
    {
        playerTheta += ROT_SPEED; 
        if (playerTheta > 360) playerTheta -= 360;
    }
    
    if (lookUp)
    {
        playerThetaY -= 0.01;
    }
    if (lookDown)
    {
        playerThetaY += 0.01;
    }
    
    float dx = SPEED*cos(radians(playerTheta));
    float dy = SPEED*sin(radians(playerTheta));
    
    if (moveUp) 
    {
        if (sprint) dx *= SPRINT_SPEED_SCALE;
        if (sprint) dy *= SPRINT_SPEED_SCALE;
        
        if (isEmptySpace(playerX + dx, playerY))
        {  
            playerX += dx;
        }
        if (isEmptySpace(playerX, playerY + dy))
        {  
            playerY += dy;
        }
    }
    if (moveDown)
    {
        dx *= BACK_SPEED_SCALE;
        dy *= BACK_SPEED_SCALE;
        
        if (isEmptySpace(playerX +- dx, playerY))
        {  
            playerX -= dx;
        }
        if (isEmptySpace(playerX, playerY - dy))
        {  
            playerY -= dy;
        }
    }
    
    if ((moveUp || moveDown) && !footstepsSound.isPlaying()) footstepsSound.play(0.5, 0.5);
    if (!moveUp && !moveDown && footstepsSound.isPlaying()) footstepsSound.pause();

}

void keyPressed()
{
  if (key == 'A' || key == 'a' || keyCode == LEFT) turnLeft = true;
  if (key == 'D' || key == 'd' || keyCode == RIGHT) turnRight = true;
  if (key == 'W' || key == 'w') moveUp = true;
  if (key == 'S' || key == 's') moveDown = true;
  if (keyCode == SHIFT) sprint = true;
  if (keyCode == UP) lookUp = true;
  if (keyCode == DOWN) lookDown = true;
}

void keyReleased()
{
  if (key == 'A' || key == 'a' || keyCode == LEFT) turnLeft = false;
  if (key == 'D' || key == 'd' || keyCode == RIGHT) turnRight = false;
  if (key == 'W' || key == 'w') moveUp = false;
  if (key == 'S' || key == 's') moveDown = false;
  if (keyCode == SHIFT) sprint = false;
  if (keyCode == UP) lookUp = true;
  if (keyCode == DOWN) lookDown = true;
}
