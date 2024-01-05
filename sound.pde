import processing.sound.*;

SoundFile curSound;
SoundFile spaceSound;
SoundFile dgnSound;
SoundFile footstepsSound;

void loadSounds()
{
    spaceSound = new SoundFile(this, "assets/music/space_shooter.wav");
    dgnSound = new SoundFile(this, "assets/music/dungeon002.wav");
    dgnSound.loop();
    footstepsSound = new SoundFile(this, "assets/music/running-shoes-1.wav");
    footstepsSound.loop();
}
