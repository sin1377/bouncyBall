void gameStart() {
  background(255);
  mapload();
  restart();
  if (mainUI == 1) {
    for (Box box : boxes) {
      box.display();
      box.ballCollision();
    }
    for (Star star : stars) {
      star.display();
    }
    balls.get(0).display();
    balls.get(0).update();
    balls.get(0).starGet();
    if (stars.size() == 0) {
      if (stageMode && !clear && stageList == stage) {
        stage ++;
      }
      clear = true;
      gameClearedUI();
    }
  }
  if (mainUI == 2) {
    for (Box box : boxesEditMode) {
      box.display();
      box.ballCollision();
    }
    for (Star star : starsEditMode) {
      star.display();
    }
    ballsEditMode.get(0).display();
    ballsEditMode.get(0).update();
    ballsEditMode.get(0).starGet();
    if (starsEditMode.size() == 0) {
      if (stageMode && !clear && stageList == stage) {
        stage ++;
      }
      clear = true;
      gameClearedUI();
    }
  }
}

void mapload() {
  if (mainUI == 1) {
    if (mapload) {
      for (Box box : boxes) {
        Box clone = box.clone();
        boxClones.add(clone);
      }
      for (Ball ball : balls) {
        Ball clone = ball.clone();
        ballClones.add(clone);
      }
      for (Star star : stars) {
        Star clone = star.clone();
        starClones.add(clone);
      }
      mapload = false;
    }
  }
  if (mainUI == 2) {
    if (mapload) {
      for (Box box : boxesEditMode) {
        Box clone = box.clone();
        boxClones.add(clone);
      }
      for (Ball ball : ballsEditMode) {
        Ball clone = ball.clone();
        ballClones.add(clone);
      }
      for (Star star : starsEditMode) {
        Star clone = star.clone();
        starClones.add(clone);
      }
      mapload = false;
    }
  }
}

void restart() {
  if (mainUI == 1) {
    if (restart) {
      boxes.clear();
      balls.clear();
      stars.clear();
      for (Box boxClone : boxClones) {
        Box box = boxClone.clone();
        boxes.add(box);
      }
      for (Ball ballClone : ballClones) {
        Ball ball = ballClone.clone();
        balls.add(ball);
      }
      for (Star starClone : starClones) {
        Star star = starClone.clone();
        stars.add(star);
      }
      restart = false;
    }
    if (balls.get(0).position.y > height + height/20 && !clear) {
      restart = true;
    }
  }
  if (mainUI == 2) {
    if (restart) {
      boxesEditMode.clear();
      ballsEditMode.clear();
      starsEditMode.clear();
      for (Box boxClone : boxClones) {
        Box box = boxClone.clone();
        boxesEditMode.add(box);
      }
      for (Ball ballClone : ballClones) {
        Ball ball = ballClone.clone();
        ballsEditMode.add(ball);
      }
      for (Star starClone : starClones) {
        Star star = starClone.clone();
        starsEditMode.add(star);
      }
      restart = false;
    }
    if (ballsEditMode.get(0).position.y > height + height/20 && !clear) {
      restart = true;
    }
  }
}

void mouseDetect() {
  xIndex = -1;
  yIndex = -1;
  for (int i =0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      float x = i * xSize;
      float y = (j + 2) * ySize;
      if (mouseX < x + xSize&& mouseX > x && mouseY < y && mouseY > y - ySize) {
        xIndex = i;
        yIndex = j;
        return;
      }
    }
  }
}

void eraser() {
  for (Box box : boxesEditMode) {
    if (box.x == xIndex && box.y == yIndex) {
      boxesEditMode.remove(box);
      break;
    }
  }
  for (Ball ball : ballsEditMode) {
    if (ball.x == xIndex && ball.y == yIndex) {
      ballsEditMode.remove(ball);
      break;
    }
  }
  for (Star star : starsEditMode) {
    if (star.x == xIndex && star.y == yIndex) {
      starsEditMode.remove(star);
      break;
    }
  }
}

void mapEditFunc() {
  if (mousePressed && userEditUIAvailable) {
    for (int i = 0; i < 4; i++) {
      if (mouseX < (i + 1) * xSize && mouseX > i * xSize && mouseY < ySize && mouseY > 0 && modify != i) {
        modify = i;
      }
    }
    if (modify == 0) {
      mouseDetect();
      if (xIndex != -1 && yIndex != -1) {
        eraser();
      }
    }
    if (modify == 1) {
      mouseDetect();
      if (xIndex != -1 && yIndex != -1) {
        eraser();
        Box boxEdit = new Box(xIndex, yIndex);
        for (Box box : boxesEditMode) {
          if (box.x == boxEdit.x && box.y == boxEdit.y) {
            boxesEditMode.remove(box);
            break;
          }
        }
        boxesEditMode.add(boxEdit);
      }
    }
    if (modify == 2) {
      mouseDetect();
      if (xIndex != -1 && yIndex != -1) {
        eraser();
        Ball ball = new Ball(xIndex, yIndex);
        ballsEditMode.add(ball);
      }
    }
    if (ballsEditMode.size() > 1) {
      ballsEditMode.remove(0);
    }
    if (modify == 3) {
      mouseDetect();
      if (xIndex != -1 && yIndex != -1) {
        eraser();
        Star starEdit = new Star(xIndex, yIndex);
        for (Star star : starsEditMode) {
          if (star.x == starEdit.x && star.y == starEdit.y) {
            starsEditMode.remove(star);
            break;
          }
        }
        starsEditMode.add(starEdit);
      }
    }
    if (mouseX > width - xSize * 2 && mouseX < width && mouseY > 0 && mouseY < ySize) {
      if (ballsEditMode.size() > 0) {
        isBall = true;
      } else {
        isBall = false;
        countdown = millis();
      }
      if (starsEditMode.size() > 0) {
        isStar = true;
      } else {
        isStar = false;
        countdown = millis();
      }
      if (isBall && isStar) {
        start = true;
      }
    }
  }
}

void backSpace() {
  if (mainUI == 1) {
    boxes.clear();
    balls.clear();
    stars.clear();
    for (Box boxClone : boxClones) {
      Box box = boxClone.clone();
      boxes.add(box);
    }
    for (Ball ballClone : ballClones) {
      Ball ball = ballClone.clone();
      balls.add(ball);
    }
    for (Star starClone : starClones) {
      Star star = starClone.clone();
      stars.add(star);
    }
  }
  if (mainUI == 2) {
    boxesEditMode.clear();
    ballsEditMode.clear();
    starsEditMode.clear();
    for (Box boxClone : boxClones) {
      Box box = boxClone.clone();
      boxesEditMode.add(box);
    }
    for (Ball ballClone : ballClones) {
      Ball ball = ballClone.clone();
      ballsEditMode.add(ball);
    }
    for (Star starClone : starClones) {
      Star star = starClone.clone();
      starsEditMode.add(star);
    }
  }
  boxClones.clear();
  ballClones.clear();
  starClones.clear();
  start = false;
  clear = false;
  mapload = true;
}
