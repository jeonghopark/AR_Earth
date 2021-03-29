#pragma once

#include "ofxiOS.h"

#include <ARKit/ARKit.h>
#include "ofxARKit.h"


struct PathPoint {
    ofVec2f points;
    string constellation;
    string io;
};

struct StarPosition {
    ofVec2f points;
    string io;
};


struct Star {
    ofVec3f starPoints;
    float starBrightness;
};



class ofApp : public ofxiOSApp {
    
public:
    
    ofApp (ARSession * session);
    ofApp();
    ~ofApp ();
    
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    void touchCancelled(ofTouchEventArgs &touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    vector < matrix_float4x4 > mats;
    vector<ARAnchor*> anchors;
    ofCamera camera;
    ofTrueTypeFont font;
    vector<ofImage> images;
    
    // ====== AR STUFF ======== //
    ARSession * session;
    ARRef processor;
    
    map<string, ofImage> imageMessages;
            
    // billboard particles
    ofShader billboardShader;
//    ofTexture texture;
    
    bool arStart;
    float movingFactor;
    float movingSpeed;
    float rotationFactor;

    ofEasyCam cam;
    
    void audioOut(float * output, int bufferSize, int nChannels);
                    
    bool markerOnOff;

    ofPlanePrimitive plane;
    ofSpherePrimitive sphere;
    float sphereRotation;
    
    ofSpherePrimitive earth;
    ofImage earthTextureImg;
    
    float rotationPlanet;
};


