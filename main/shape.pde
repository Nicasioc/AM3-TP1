void drawVertexShape(PGraphics imageBuffer, PImage texture, float height_, float width_) {

  imageBuffer.pushStyle();
  imageBuffer.strokeWeight(0);
  imageBuffer.stroke(0, 255, 0);
  imageBuffer.beginShape();
  imageBuffer.texture(texture);
  imageBuffer.vertex(-5, 0, 0, 0);
  imageBuffer.vertex(5, 0, width_, 0);
  imageBuffer.vertex(5, height_, width_, 500);
  imageBuffer.vertex(-5, height_, 0, 500);
  imageBuffer.endShape(CLOSE);
  imageBuffer.popStyle();

}

void drawVertexShapeXY(PGraphics imageBuffer, PImage texture, float x, float y, float width_, float height_) {
  imageBuffer.pushStyle();
  imageBuffer.strokeWeight(0);
  imageBuffer.stroke(0, 255, 0);
  imageBuffer.beginShape();
  imageBuffer.texture(texture);
  imageBuffer.vertex(x, y, 0, 0);
  imageBuffer.vertex(x+5, y, width_, 0);
  imageBuffer.vertex(x+5, y+height_, width_, 500);
  imageBuffer.vertex(x, y+height_, 0, 500);
  imageBuffer.endShape(CLOSE);
  imageBuffer.popStyle();

}