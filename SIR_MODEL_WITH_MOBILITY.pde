int numAgents = 100;
Agent[] agents = new Agent[numAgents];
color susceptibleColor, infectedColor, recoveredColor, trailColor;
int agentSize = 10;
int infectionDistance = 30;
int frameRate = 5;

void setup() {
  size(800, 800);
  frameRate(frameRate);
  
  susceptibleColor = color(0, 255, 0);    // Green
  infectedColor = color(255, 0, 0);       // Red
  recoveredColor = color(0, 0, 255);      // Blue
  trailColor = color(255, 0, 0, 100);    // Semi-transparent red
  
  for (int i = 0; i < numAgents; i++) {
    float x = random(width);
    float y = random(height);
    agents[i] = new Agent(x, y);
  }
  
  int initialInfected = int(random(numAgents));
  agents[initialInfected].infect();
}

void draw() {
  background(255);
  
  for (Agent agent : agents) {
    agent.move();
    agent.display();
    agent.checkInfection();
  }
}

class Agent {
  float x, y;
  float angle, jumpDistance;
  boolean infected = false;
  ArrayList<PVector> trail = new ArrayList<PVector>();
  int trailLength = 1000;
  
  Agent(float x, float y) {
    this.x = x;
    this.y = y;
    setRandomMovement();
  }
  
  void move() {
    x += cos(angle) * jumpDistance;
    y += sin(angle) * jumpDistance;
    
    // Wrap around screen
    x = (x + width) % width;
    y = (y + height) % height;
    
    if (infected) {
      trail.add(new PVector(x, y));
      if (trail.size() > trailLength) {
        trail.remove(0);
      }
    }
  }
  
  void display() {
    noStroke();
    if (infected) {
      fill(infectedColor);
      ellipse(x, y, agentSize, agentSize);
      
      stroke(trailColor);
      noFill();
      beginShape();
      for (PVector pos : trail) {
        vertex(pos.x, pos.y);
      }
      endShape();
    } else {
      fill(susceptibleColor);
      ellipse(x, y, agentSize, agentSize);
    }
  }
  
  void infect() {
    infected = true;
  }
  
  void checkInfection() {
    if (!infected) {
      for (Agent other : agents) {
        if (other.infected) {
          float distance = dist(x, y, other.x, other.y);
          if (distance < infectionDistance) {
            if (random(1) < 0.5) {
              infect();
              break;
            }
          }
        }
      }
    }
  }
  
  void setRandomMovement() {
    angle = random(TWO_PI);
    jumpDistance = random(1, 5);  // Adjust the range for desired jump distances
  }
}
