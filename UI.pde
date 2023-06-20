void mainScreen() {
  textSize(50);
  if (backImage) {
    image(loadImage("bounceball.png"), 0, 0, width, height);
    backImage = false;
  }
  if (mouseX > width/2 - width/4 - width/4/2 && mouseX < width/2 - width/4/2 && mouseY > height/2 - height/4/2 && mouseY < height/2 + height/4/2) {
    fill(50, 255, 50);
    if (mousePressed) {
      mainUI = 1;
      stageMode = true;
    }
  } else {
    fill(100, 255, 100);
  }
  rect(width/2 - width/4 - width/4/2, height/2 - height/4/2, width/4, height/4);
  fill(0);
  text("STAGE", width/2 - width/4 - width/4/2, height/2 - height/4/2, width/4, height/4);
  if (mouseX > width/2 + width/4/2 && mouseX < width/2 + width/4 + width/4/2 && mouseY > height/2 - height/4/2 && mouseY < height/2 + height/4/2) {
    fill(50, 50, 255);
    if (mousePressed) {
      mainUI = 2;
    }
  } else {
    fill(100, 100, 255);
  }
  rect(width/2 + width/4/2, height/2 - height/4/2, width/4, height/4);
  fill(255);
  text("MAP\nMAKING", width/2 + width/4/2, height/2 - height/4/2, width/4, height/4);
  if (lowQuality) {
    fill(70);
  } else {
    fill(185);
  }
  rect(width - xSize * 5, 0, xSize * 3, ySize);
  fill(255);
  textSize(30);
  text("Low-Quality", width - 3.5 * xSize, ySize/2);
  stageUIAvailable = false;
  userEditUIAvailable = false;
}

void stageUI() {
  background(#005BA4);
  stroke(0);
  strokeWeight(1);
  textSize(width/20);
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 3; j++) {
      float x = width / 10 + i * width * 2 / 15;
      float y = height / 2 - width * 2 / 15 + j * width * 2 / 15;
      if (stage >= j*7+i+1) {
        if (mouseX > x - width / 20 && mouseX < x + width / 20 && mouseY > y - width / 20 && mouseY < y + width / 20) {
          fill(#5DA2F1);
          if (mousePressed && stageUIAvailable && stageButtonAvailable) {
            stageList = j*7 + i+1;
            mapDraw();
            start = true;
          }
        } else {
          fill(#007BFF);
        }
      } else {
        fill(170);
      }
      rectMode(CENTER);
      rect(x, y, width / 10, width / 10);
      rectMode(CORNER);
      fill(255);
      text(str(j*7+i+1), x, y);
    }
  }
}

void gameClearedUI() {
  rectMode(CENTER);
  fill(255);
  rect(width/2, height/2, width/2, height/2);
  fill(0);
  textSize(100);
  text("CLEAR!", width/2, height/2);
  if (mouseX > width/2 - width/8 && mouseX < width/2 + width/8 && mouseY > height*5/8 - height/16 && mouseY < height*5/8 + height/16) {
    fill(130);
    if (mousePressed) {
      if (mainUI == 1) {
        stageButtonAvailable = false;
        backSpace();
      }
      if (mainUI == 2) {
        backSpace();
        modify = -1;
      }
    }
  } else {
    fill(170);
  }
  rect(width/2, height*5/8, width/4, height/8);
  fill(0);
  textSize(50);
  text("LEFT", width/2, height*5/8);
  rectMode(CORNER);
}

void userEditUI() {
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      float x = i * xSize;
      float y = (j+1) * ySize;
      fill(255);
      strokeWeight(1);
      rect(x, y, xSize, ySize);
    }
  }
  if (lowQuality) {
    fill(80, 80, 180);
    rect(0, 0, xSize, ySize);
    fill(70);
    rect(xSize, 0, xSize, ySize);
    fill(#FFFF00);
    triangle(xSize * 3.5, 0, xSize * 3, ySize, xSize * 4, ySize);
  } else {
    image(eraser, 0, 0, xSize, ySize);
    image(block1, xSize, 0, xSize, ySize);
    image(starImage, xSize * 3, 0, xSize, ySize);
  }
  fill(#FFDA00);
  stroke(0);
  strokeWeight(1);
  ellipse(xSize*5/2, ySize/2, xSize/2, ySize/2);
  fill(#FF0000);
  rect(width - xSize * 2, 0, xSize * 2, ySize);
  fill(0);
  textSize(30);
  text("PLAY", width - 1.4 * xSize, ySize/2);
  triangle(width - xSize * 0.7, ySize * 0.3, width - xSize * 0.7, ySize * 0.7, width - xSize * 0.3, ySize * 0.5);
}
