
int TEXTURE_SIZE = 32;

PImage WALLS;
PImage FLOOR;

void loadTextures(String level)
{
    WALLS = loadImage("../levels/" + level + "/Walls.png");
    FLOOR = loadImage("../levels/" + level + "/Floor.png");
}
