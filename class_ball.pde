class Ball implements Cloneable {
  PVector position, velocity, acceleration;
  int x, y;
  Ball(int x, int y) {
    position = new PVector((x + 0.5) * xSize, (y + 1.5) * ySize);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0.5);
    this.x = x;
    this.y = y;
  }

  Ball clone() {
    try {
      Ball cloneBall = (Ball) super.clone();
      cloneBall.position = new PVector((x + 0.5) * xSize, (y + 1.5) * ySize);
      cloneBall.velocity = new PVector(0, 0);
      cloneBall.acceleration = new PVector(0, 0.5);
      cloneBall.x = this.x;
      cloneBall.y = this.y;
      return cloneBall;
    }
    catch (CloneNotSupportedException e) {
      return null;
    }
  }

  void display() {
    fill(#FFDA00);
    strokeWeight(1);
    stroke(0);
    ellipse(position.x, position.y, xSize/2, ySize/2);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    velocity.x = constrain(velocity.x, -4, 4);
    velocity.x *= abs(velocity.x) < 0.1 ? 0 : 1;
    acceleration.x = (keyPressed && keyCode == LEFT) ? -1
      : (keyPressed && keyCode == RIGHT) ? 1
      : 0;
    velocity.x *= (acceleration.x == 0) ? 0.95 : 1;
  }

  void starGet() {
    if (mainUI == 1) {
      for (int i = 0; i < stars.size(); i++) {
        Star s = stars.get(i);
        if ((position.x < (s.x + 1) * xSize
          && position.x > s.x * xSize
          && position.y + ySize / 4 > (s.y + 1) * ySize
          && position.y - ySize / 4 < (s.y + 2) * ySize)
          || (position.y < (s.y + 2) * ySize
          && position.y > (s.y + 1) * ySize
          && position.x - xSize / 4 < (s.x + 1) * xSize
          && position.x + xSize / 4 > s.x * xSize)) {
          stars.remove(i);
        }
      }
    }
    if (mainUI == 2) {
      for (int i = 0; i < starsEditMode.size(); i++) {
        Star s = starsEditMode.get(i);
        if ((position.x < (s.x + 1) * xSize
          && position.x > s.x * xSize
          && position.y + ySize / 4 > (s.y + 1) * ySize
          && position.y - ySize / 4 < (s.y + 2) * ySize)
          || (position.y < (s.y + 2) * ySize
          && position.y > (s.y + 1) * ySize
          && position.x - xSize / 4 < (s.x + 1) * xSize
          && position.x + xSize / 4 > s.x * xSize)) {
          starsEditMode.remove(i);
        }
      }
    }
  }
}
