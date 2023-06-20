class Star implements Cloneable {
  int x, y;
  Star(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Star clone() {
    try {
      Star cloneStar = (Star) super.clone();
      cloneStar.x = this.x;
      cloneStar.y = this.y;
      return cloneStar;
    }
    catch (CloneNotSupportedException e) {
      return null;
    }
  }

  void display() {
    if (lowQuality) {
      fill(#FFFF00);
      triangle((x + 0.5) * xSize, (y + 1) * ySize, x * xSize, (y + 2) * ySize, (x + 1) * xSize, (y + 2) * ySize);
    } else {
      image(starImage, x * xSize, (y + 1) * ySize, xSize, ySize);
    }
  }
}
