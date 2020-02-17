import java.util.*;
import g4p_controls.*;
import org.gicentre.utils.stat.*;

// Filters
String taskPackage = "Reference Tests";
int playerId;

// Global
GTextField inTaskPackage;
BarChart taskTime, taskErrors;
XYChart lineChart;
ArrayList<TestData> allTests;

void setup() {
  // Window
  size(800, 600);

  // JSON
  JSONArray jsonArrayFile = loadJSONArray("testdata.json");

  allTests = new ArrayList<TestData>();
  for (int i = 0; i < jsonArrayFile.size(); i++) {
    JSONObject test = jsonArrayFile.getJSONObject(i);
    allTests.add(new TestData(test));
  }

  //Collections.sort(allTests, (a, b) -> a.getAttempt() > b.getAttempt() ? 1 : -1);
  for (TestData data : allTests) {
    println(data.attempt);
  }

  smooth(4);
  noLoop(); 
  taskTime = new BarChart(this);
  taskErrors = new BarChart(this);
  inTaskPackage = new GTextField(this, 0, 0, 150, 20);
  inTaskPackage.tag = "inTaskPackage";
  inTaskPackage.setPromptText("Player ID");
  inTaskPackage.setFocus(true);
}

void keyPressed() {
  redraw();
}

public void handleTextEvents(GEditableTextControl textControl, GEvent event) { 
  if (textControl.tag.equals("inTaskPackage") && event == GEvent.CHANGED) {
    taskPackage = textControl.getText();
    redraw();
  }
}

void draw() {
  stroke(0);
  strokeWeight(.5);
  background(255);

  // Global parameters
  int totalTesters = 0;
  String currentTaskName = "xxx";
  ArrayList<String> taskNames = new ArrayList<String>();
  ArrayList<Float> timesToComplete = new ArrayList<Float>();
  ArrayList<Integer> attempts = new ArrayList<Integer>();

  for (int i = 0; i < allTests.size(); i++) {
    TestData data = allTests.get(i);

    if (!taskPackage.equals(data.taskPackage))
      continue;

    /* Start Calculations */
    if (data.userID > totalTesters)
      totalTesters ++;

    if (!data.taskName.equals(currentTaskName)) {
      currentTaskName = data.taskName;
      taskNames.add(data.taskName);
    }

    if (data.taskSuccessful) {
      timesToComplete.add(data.timeToCompletion);
      attempts.add(data.attempt);
    } else if (data.attempt >= 5) {
      timesToComplete.add(0f);
      attempts.add(data.attempt);
    }

    // Visualize Player movement
    //colorMode(HSB, totalData);
    //stroke(i, totalData, totalData);
    //drawPath(levelOrigin, farthestPos, endPos);

    // Analysis
    // Combine to average data
  }

  colorMode(RGB, 255);

  String[] labels = new String[taskNames.size()];
  taskNames.toArray(labels);

  float[] times = new float[timesToComplete.size()];
  int i = 0;
  for (Float f : timesToComplete) {
    times[i++] = (f != null ? f : Float.NaN);
  }

  float[] errors = new float[attempts.size()];
  i = 0;
  for (Integer in : attempts) {
    errors[i++] = (in != null ? (float)in - 1 : -1);
  }
  taskTime.setData(times);
  taskTime.setMinValue(0);
  taskTime.setMaxValue(3);
  taskTime.showValueAxis(true);
  taskTime.setBarLabels(labels);
  taskTime.showCategoryAxis(true);
  taskTime.draw(15, 15, width-30, height-30);

  taskErrors.setData(errors);
  taskErrors.setMinValue(0);
  taskErrors.setMaxValue(3);
  taskErrors.showValueAxis(true);
  taskErrors.setBarLabels(labels);
  taskErrors.showCategoryAxis(true);
  taskErrors.setBarColour(color(200, 80, 80, 150));
  taskErrors.draw(15, 15, width-30, height-30);

  // Stats:
  fill(0);
  textSize(16);
  textAlign(RIGHT, TOP);
  text("Total Testsubjects: " + totalTesters, width, 0);

  // Input field
  inTaskPackage.draw();
}
