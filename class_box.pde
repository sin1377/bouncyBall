class Box implements Cloneable {
  int x, y;
  Box(int x, int y) {
    this.x = x;
    this.y = y;
  }

  Box clone() {
    try {
      Box cloneBox = (Box) super.clone();
      cloneBox.x = this.x;
      cloneBox.y = this.y;
      return cloneBox;
    }
    catch (CloneNotSupportedException e) {
      return null;
    }
  }

  void display() {
    if (lowQuality) {
      fill(70);
      rect(x * xSize, (y + 1) * ySize, xSize, ySize);
    } else {
      image(block1, x * xSize, (y + 1) * ySize, xSize, ySize);
    }
  }

  void ballCollision() {
    ballxr = xSize/4;
    ballyr = ySize/4;
    if (mainUI == 1) {
      ballx = balls.get(0).position.x;
      bally = balls.get(0).position.y;
      if (ballx < (x + 1) * xSize && ballx > x * xSize && bally + ballyr > (y + 1) * ySize && bally - ballyr < (y + 2) * ySize) {
        balls.get(0).position.y = (bally + ballyr < (y + 1.5) * ySize)
          ? (y + 1) * ySize - ballyr
          : (y + 2) * ySize + ballyr;
        balls.get(0).velocity.y = (bally + ballyr < (y + 1.5) * ySize)
          ? -10
          : 0;
      } else if (bally < (y + 2) * ySize && bally > (y + 1) * ySize && ballx - ballxr < (x + 1) * xSize && ballx + ballxr > x * xSize) {
        balls.get(0).position.x = (ballx - ballxr > (x + 0.5) * xSize)
          ? (x + 1) * xSize + ballxr
          : x * xSize - ballxr;
        balls.get(0).velocity.x *= -1;
      }
    }
    if (mainUI == 2) {
      ballx = ballsEditMode.get(0).position.x;
      bally = ballsEditMode.get(0).position.y;
      if (ballx < (x + 1) * xSize && ballx > x * xSize && bally + ballyr > (y + 1) * ySize && bally - ballyr < (y + 2) * ySize) {
        ballsEditMode.get(0).position.y = (bally + ballyr < (y + 1.5) * ySize)
          ? (y + 1) * ySize - ballyr
          : (y + 2) * ySize + ballyr;
        ballsEditMode.get(0).velocity.y = (bally + ballyr < (y + 1.5) * ySize)
          ? -10
          : 0;
      } else if (bally < (y + 2) * ySize && bally > (y + 1) * ySize && ballx - ballxr < (x + 1) * xSize && ballx + ballxr > x * xSize) {
        ballsEditMode.get(0).position.x = (ballx - ballxr > (x + 0.5) * xSize)
          ? (x + 1) * xSize + ballxr
          : x * xSize - ballxr;
        ballsEditMode.get(0).velocity.x *= -1;
      }
    }
  }
}
