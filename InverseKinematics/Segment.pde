
class Segment {
    
    Segment parent;
    
    PVector a;
    float len;
    float angle;
    
    PVector b;
    
    float weight;
    
    Segment(float x, float y, float len_, float angle_) {
        parent = null;
        
        a = new PVector(x, y);
        len = len_;
        angle = angle_;
        b = new PVector();
        calculateB();
        
        weight = 4;
    }
    
    Segment(Segment parent_, float len_, float angle_) {
        parent = parent_;
        
        a = parent.b.copy();
        len = len_;
        angle = angle_;
        b = new PVector();
        calculateB();
        
        weight = parent.weight/2;
    }
    
    void changeAngleToMouse(float xPos, float yPos) {
        float x = xPos - a.x;
        float y = yPos - a.y;
        
        angle = atan2(y, x);
    }
    
    void changeAngle(float angle_, boolean referenceParent) {
        if (parent != null) {
            if (referenceParent) {
                angle = angle_ + parent.angle;
            }
            else {
                angle = angle_;
            }
        }
        else {
            angle = angle_;
        }
    }
    
    void changeAngle(float angle_) {
        if (parent != null) {
            angle = angle_ + parent.angle;
        }
        else {
            angle = angle_;
        }
    }
    
    void calculateB() {
        float dx = len * cos(angle);
        float dy = len * sin(angle);
        
        b.set(a.x + dx, a.y + dy);
    }
    
    void update() {
        if (parent != null) {
            a = parent.b.copy();
        }
        calculateB();
    }
    
    void show() {
        stroke(255);
        strokeWeight(weight);
        line(a.x, a.y, b.x, b.y);
    }
    
}
