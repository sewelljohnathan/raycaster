
float playerX = 2, playerY = 2, playerTheta = 0, playerThetaY = 0;
int FOV = 60;

void setup()
{
    size(600, 600);
    
    loadTextures("test");
    loadSounds();

    dgnSound.play();
}

void draw() 
{
    background(0);
    
    loadPixels();
        renderMain();
    updatePixels();
    
    renderMiniMap();
    move();
  
}
