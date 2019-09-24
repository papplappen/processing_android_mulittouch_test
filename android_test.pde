import android.view.MotionEvent;

final float SPEED = 128;

float posX, posY;
int dirX, dirY;

void setup() {
  orientation(LANDSCAPE);

  posX = width/2;
  posY = height/2;
}

int prevTime;

void draw() {
  background(0xcc);

  int deltaTime = millis() - prevTime;
  prevTime += deltaTime;
  float dt = deltaTime/1000.0;

  posX += constrain(dirX, -1, 1) * SPEED * dt;
  posY += constrain(dirY, -1, 1) * SPEED * dt;

  noStroke();
  fill(#00aaaa);
  ellipse(posX, posY, 64, 64);

  stroke(0, 32);
  strokeWeight(4);
  line(0, 0, width, height);
  line(width, 0, 0, height);
}

boolean surfaceTouchEvent(MotionEvent event) {
  int pointerIndex = event.getActionIndex();
  int maskedAction = event.getActionMasked();

  int up_down = 0;

  if (maskedAction == MotionEvent.ACTION_DOWN || maskedAction == MotionEvent.ACTION_POINTER_DOWN) {
    up_down = 1;
  } else if (maskedAction == MotionEvent.ACTION_UP || maskedAction == MotionEvent.ACTION_POINTER_UP || maskedAction == MotionEvent.ACTION_CANCEL) {
    up_down = -1;
  } else if (maskedAction == MotionEvent.ACTION_MOVE) {
  }

  float triggerX = event.getX(pointerIndex);
  float triggerY = event.getY(pointerIndex);

  float xx = triggerX/width - 0.5, yy = triggerY/height - 0.5;
  if (abs(xx) < abs(yy)) {
    if (xx < yy) {
      dirY+=up_down;
    } else {
      dirY-=up_down;
    }
  } else {
    if (xx < yy) {
      dirX-=up_down;
    } else {
      dirX+=up_down;
    }
  }

  if (maskedAction == MotionEvent.ACTION_UP) {
    dirX = 0; 
    dirY = 0;
  }
  return true;
}
