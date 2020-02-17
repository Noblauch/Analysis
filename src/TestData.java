import processing.core.PApplet;
import processing.data.JSONObject;

public class TestData extends PApplet{
    // User Data
    public int userID;

    // Task Data
    public String taskPackage;
    public String taskName;
    public int samplesPerSqm;
    public float sampleSize;
    public float sampleTilt;

    // Filter Data
    public float eyeWeight;
    public float easeTime;

    // Performance Data
    public int attempt;
    public boolean taskSuccessful;
    public float timeToCompletion;
    public int preSelectionHighlights;
    public float handToTargetDistance;
    public float gazeToTargetDistance;

    public TestData(JSONObject data) {
        userID = data.getInt("userID");
        taskPackage = data.getString("taskPackage");
        taskName = data.getString("taskName");
        samplesPerSqm = data.getInt("samplesPerSqm");
        sampleSize = data.getFloat("sampleSize");
        sampleTilt = data.getFloat("sampleTilt");
        eyeWeight = data.getFloat("eyeWeight");
        easeTime = data.getFloat("easeTime");
        attempt = data.getInt("attempt");
        taskSuccessful = data.getBoolean("taskSuccessful");
        timeToCompletion = data.getFloat("timeToCompletion");
        preSelectionHighlights = data.getInt("preSelectionHighlights");
        handToTargetDistance = data.getFloat("handToTargetDistance");
        gazeToTargetDistance = data.getFloat("gazeToTargetDistance");
    }

    public int getAttempt() {
        return attempt;
    }
}
