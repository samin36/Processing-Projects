import processing.sound.*;
class SimonToneGenerator {

  SqrOsc tone; //'Saw' is a square wave oscillator: check on procesing, sound reference
  int maxDuration;
  float playMillis; //playMillis is the time when play button was pressed
  boolean isPlaying;

  //'p' refers to 'this' instance. Since the tone generator is used in an object class,
  // a reference of the main class: Simon_Says must be passed as a PApplet  
  SimonToneGenerator(PApplet p, int maxDuration_) {
    tone = new SqrOsc(p);
    maxDuration = maxDuration_;
    isPlaying = false;
  }

  void playTone(float frequency) {
    tone.amp(1);     
    tone.freq(frequency);
    tone.play();
    isPlaying = true;

    playMillis = millis();
  }


  void checkMillis() {
    int currMillis = millis();
    if (isPlaying && currMillis - playMillis > maxDuration) {
      stopTone();
      for (Button b : buttons) b.setLight(false);
      isPlaying = false;
    }
  }

  void stopTone() {
    tone.stop();
    // playMillis = 0;
  }
  
  void setDuration(int duration_) {
   maxDuration = duration_; 
  }
}