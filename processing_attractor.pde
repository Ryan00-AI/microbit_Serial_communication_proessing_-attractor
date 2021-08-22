import processing.serial.*;
Serial microbit;
int pointNum = 10000;
int scale = 50;
float a = 1.1;
float b = 1.3;
float c = 1.8;
float d = 1.3;
int colorR = 70;
int colorB = 75;
int colorG = 100;

void setup() {
  size(800, 800);
  String portName = Serial.list()[0];
  println(portName);
  microbit = new Serial(this, "COM3", 115200);
  microbit.bufferUntil(10);
}

void draw() {
  background(0, 0, 0);
  translate(width / 2, height / 2);
  drawCliffordAttractor(a, b, c, d, colorR, colorG, colorB);
}

void drawCliffordAttractor(float a, float b, float c, float d, float colorR, float colorG, float colorB) {
  blendMode(ADD);
  stroke(colorR, colorB, colorG);
  float x = 0;
  float y = 0;
  String str = microbit.readStringUntil('\n');
  if (str != null) {
    str = trim(str);
    float[] sensors = float(split(str, ','));
    if (sensors.length > 3) {
      a = map(sensors[0], -2500, 2500, 1, 2);
      b = map(sensors[1], -2500, 2500, 1, 2);
      c = map(sensors[2], -2500, 2500, 1, 2);
      d = map(sensors[3], -2500, 2500, 1, 2);
      colorR = map(sensors[0], -2500, 2500, 0, 255);
      colorG = map(sensors[1], -2500, 2500, 0, 255);
      colorB = map(sensors[2], -2500, 2500, 0, 255);
    }
    for (int i = 0; i < pointNum; i++) {
      point(scale * x, scale * y);
      float newX = sin(a * y) + c * cos(a * x);
      float newY = sin(b * x) + d * cos(b * y);
      x = newX;
      y = newY;
    }
  }
}
