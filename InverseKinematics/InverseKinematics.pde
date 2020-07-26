import java.util.Arrays;

Segment seg1;
Segment seg2;
Segment seg3;
Segment seg4;

Segment[] segmentArray = new Segment[4];

void setup() {
    size(600,400);
    seg1 = new Segment(300, 0, 50, PI/2);
    seg2 = new Segment(seg1, 50, PI/6);
    seg3 = new Segment(seg2, 50, -PI/3);
    seg4 = new Segment(seg3, 50, PI/12);
    segmentArray[0] = seg1;
    segmentArray[1] = seg2;
    segmentArray[2] = seg3;
    segmentArray[3] = seg4;
    
}

void draw() {
    background(51);    
    if (mousePressed) {
        reArrange(segmentArray, mouseX, mouseY);
    }
    
    for (int i = 0; i < segmentArray.length; i++) {
        segmentArray[i].update();
        segmentArray[i].show();
    }
    
}

void reArrange(Segment[] segments, float x, float y) {
    
    float dx = x - segments[0].a.x;
    float dy = y - segments[0].a.y;
    
    float angleToPoint = atan2(dy, dx);
    
    float totalDistance = sqrt(pow(dx, 2) + pow(dy, 2));
    float totalLength = 0;
    
    for (int i = 0; i < segments.length; i++) {
        
        totalLength += segments[i].len;
        
    }
    
    if (totalDistance >= totalLength) {
        
    
        segments[0].changeAngle(angleToPoint);
        
        for (int i = 1; i < segments.length; i++) {
            
            segments[i].changeAngle(0, true);
        
        }
    
    }
    else {    
        if (segments.length > 2) {
            
            float xUnit = dx/segments.length;
            float yUnit = dy/segments.length;
            
            Segment[] firstHalf = Arrays.copyOfRange(segments, 0, segments.length/2);
            Segment[] secondHalf = Arrays.copyOfRange(segments, segments.length/2, segments.length);
            
            float newX = xUnit * firstHalf.length;
            float newY = yUnit * firstHalf.length;
            
            secondHalf[0].a.set(newX, newY);
            
            reArrange(firstHalf, newX, newY);
            reArrange(secondHalf, x, y);
            
        }
        
        if (segments.length == 1) {
            segments[0].changeAngle(angleToPoint, false);
        }
        else {
        
            float l = sqrt(pow(dx, 2) + pow(dy, 2));
            float sideA = segments[1].len;
            float sideB = segments[0].len;
            
            float angleA = acos(l / (2 * sideB));
            
            println("l: ", l, " Side A: ", sideA, " Side B: ", sideB, " Angle A: ", angleA);
            
            segments[0].changeAngle(angleToPoint - angleA, false);
            segments[1].changeAngle(2 * angleA, true);            
        }
        
    }
    
}
