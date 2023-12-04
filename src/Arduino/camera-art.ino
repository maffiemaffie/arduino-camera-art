const int TOP_RIGHT = A3;
const int TOP_LEFT = A0;
const int BOTTOM_RIGHT = A2;
const int BOTTOM_LEFT = A1;

void setup() {
  pinMode(TOP_RIGHT, INPUT);
  pinMode(TOP_LEFT, INPUT);
  pinMode(BOTTOM_RIGHT, INPUT);
  pinMode(BOTTOM_LEFT, INPUT);

  Serial.begin(9000);
}

void loop() {
  String string = "";
  String splitter = ",";
  string += analogRead(TOP_LEFT);
  string += splitter;
  string += analogRead(TOP_RIGHT);
  string += splitter;
  string += analogRead(BOTTOM_RIGHT);
  string += splitter;
  string += analogRead(BOTTOM_LEFT);
  Serial.println(string);
  delay(50);
}
