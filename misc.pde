
boolean isEmptySpace(float x, float y)
{
    return WALLS.get(floor(x)*32, floor(y)*32) == 0;
}

float distance(float x1, float y1, float x2, float y2)
{
    return sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1));
}

boolean isInBounds(float x, float y)
{
    x = floor(x);
    y  = floor(y);
    return x >= 0 && x < WORLD_SIZE && y >= 0 && y < WORLD_SIZE;
}

float VISIBILITY = 7;
int shadowColor(color c, float distance)
{
    int a = 255;
    int r = (c >> 16) & 0xFF;
    int g = (c >> 8) & 0xFF;
    int b = (c >> 0) & 0xFF;
    
    float scale = 1 - distance/VISIBILITY;
    if (scale < 0) scale = 0;
    
    return (a << 24) | (int(r*scale) << 16) | (int(g*scale) << 8) | (int(b*scale) << 0);
}
