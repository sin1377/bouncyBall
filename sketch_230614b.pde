int[][] grid = new int[25][15];
PImage block1, eraser, starImage;
ArrayList<Box> boxes = new ArrayList<>();
ArrayList<Ball> balls = new ArrayList<>();
ArrayList<Star> stars = new ArrayList<>();
ArrayList<Box> boxesEditMode = new ArrayList<>();
ArrayList<Ball> ballsEditMode = new ArrayList<>();
ArrayList<Star> starsEditMode = new ArrayList<>();
ArrayList<Box> boxClones = new ArrayList<>();
ArrayList<Ball> ballClones = new ArrayList<>();
ArrayList<Star> starClones = new ArrayList<>();
int xIndex = -1, yIndex = -1, stage = 21;
boolean erase, block, ball, star, start, clear, restart, mapload, lowQuality, backImage, stageMode, stageUIAvailable, userEditUIAvailable, stageButtonAvailable;
float xSize, ySize;
int mainUI, modify;
int stageList;
float ballx, bally, ballxr, ballyr;
boolean isStar, isBall;
int countdown;

void setup() {
  fullScreen();
  block1 = loadImage("Block1.png");
  eraser = loadImage("eraser.png");
  starImage = loadImage("star.png");
  backImage = true;
  mapload = true;
  textAlign(CENTER, CENTER);
  xSize = width / 25.0;
  ySize = height / 16.0;
}

void draw() {
  if (mainUI == 0) {
    mainScreen();
  }
  if (mainUI == 1) {
    if (start) {
      gameStart();
    } else {
      stageUI();
    }
  }
  if (mainUI == 2) {
    background(255);
    if (start) {
      gameStart();
    } else {
      mapEditFunc();
      userEditUI();
      for (Box box : boxesEditMode) {
        box.display();
      }
      for (Ball ball : ballsEditMode) {
        ball.display();
      }
      for (Star star : starsEditMode) {
        star.display();
      }
      if (!isStar || !isBall) {
        textSize(30);
        fill(0);
        if (millis() - countdown <= 3000) {
          if (!isStar) {
            text("There is no star.", width/2, height*5/6);
          } else if (!isBall) {
            text("There is no ball.", width/2, height*5/6);
          }
        }
      }
    }
  }
}

void mousePressed() {
  if (mainUI == 0) {
    if (mouseX > width - xSize * 5 && mouseX < width - xSize * 2 && mouseY > 0 && mouseY < ySize && !start) {
      lowQuality = !lowQuality;
    }
  }
}

void keyPressed() {
  if (key == BACKSPACE) {
    if (mainUI == 1 || mainUI == 2) {
      if (start) {
        backSpace();
      } else {
        mainUI = 0;
        backImage = true;
        stageMode = false;
      }
    }
  }
  if (key == ENTER) {
    for (Box box : boxesEditMode) {
      println("boxAdd("+box.x+", "+box.y+");");
    }
    for (Ball ball : ballsEditMode) {
      println("ballAdd("+ball.x+", "+ball.y+");");
    }
    for (Star star : starsEditMode) {
      println("starAdd("+star.x+", "+star.y+");");
    }
  }
}

void mouseReleased() {
  if (mainUI == 1) {
    stageUIAvailable = true;
    if (!stageButtonAvailable) {
      stageButtonAvailable = true;
    }
  }
  if (mainUI == 2) {
    userEditUIAvailable = true;
  }
}
