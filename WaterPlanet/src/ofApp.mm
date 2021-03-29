#include "ofApp.h"

using namespace ofxARKit::common;

void logSIMD(const simd::float4x4 &matrix) {
    std::stringstream output;
    int columnCount = sizeof(matrix.columns) / sizeof(matrix.columns[0]);
    for (int column = 0; column < columnCount; column++) {
        int rowCount = sizeof(matrix.columns[column]) / sizeof(matrix.columns[column][0]);
        for (int row = 0; row < rowCount; row++) {
            output << std::setfill(' ') << std::setw(9) << matrix.columns[column][row];
            output << ' ';
        }
        output << std::endl;
    }
    output << std::endl;
}

//--------------------------------------------------------------
ofApp :: ofApp (ARSession * session){
    this->session = session;
    cout << "creating ofApp" << endl;
}

ofApp::ofApp(){}


//--------------------------------------------------------------
ofApp :: ~ofApp () {
    cout << "destroying ofApp" << endl;
}


//--------------------------------------------------------------
void ofApp::setup() {
    
    ofBackground(127);
    
    ofEnableAlphaBlending();
    
    glLineWidth(1);
    glEnable(GL_POINT_SMOOTH);
    glPointSize(0.0001);
    
    billboardShader.load("shader.vert", "shader.frag");
    
    ofDisableArbTex();
    ofEnableAlphaBlending();
    
    int fontSize = 8;
    if (ofxiOSGetOFWindow()->isRetinaSupportedOnDevice()) {
        fontSize *= 2;
    }
    font.load("fonts/mono0755.ttf", fontSize);
    
    processor = ARProcessor::create(session);
    processor->setup();
    
    arStart = false;
    movingFactor = 0;
    movingSpeed = 0.05;
    
    glLineWidth(4);
    
    plane.set(0.16, 0.04 * 3);
    sphere.set(0.05, 32);
    
    earth.set(0.048, 32);
    earthTextureImg.load("2k_earth_daymap.jpg");
    
    camera.setNearClip(0.0001);
    
    rotationPlanet = 0;
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    processor->update();
    processor->updateImages();
    
    if (arStart) {
        movingFactor += movingSpeed;
        
        if (movingFactor > 0.3) {
            movingSpeed = 0;
        }
    }
    
}

//--------------------------------------------------------------
void ofApp::draw() {
    
    //    glEnable(GL_CULL_FACE); // Cull back facing polygons
    //    glCullFace(GL_FRONT); // might be GL_FRONT instead
    
    
    //    glDisable( GL_CULL_FACE );
    //    ofPushMatrix();
    ofDisableDepthTest();
    processor->draw();
    ofEnableDepthTest();
    //    ofPopMatrix();
    //    glEnable( GL_CULL_FACE );
    
    
    if(processor->isValidFrame()){
        camera.begin();
        
        processor->setARCameraMatrices();
        
        auto imageAnchors = processor->getImages();
        
        if (imageAnchors.size() > 0 && arStart) {
            markerOnOff = true;
            
            ofPushMatrix();
            ofMultMatrix(imageAnchors[0].transform);
            
            ofRotateYDeg(180);
            ofTranslate(0, 0.1, 0);
            
            rotationPlanet += 0.5;
            ofRotateYDeg(rotationPlanet);
            
            ofPushMatrix();
            ofPushStyle();
            ofSetColor(255, 255);
            
            
            ofPushMatrix();
            earthTextureImg.bind();
            earth.draw();
            earthTextureImg.unbind();
            ofPopMatrix();
            
            billboardShader.begin();
            billboardShader.setUniform1f("u_time", ofGetElapsedTimef());
            //            billboardShader.setUniform2f("offsetAudioSignal", buffGain[0][0] * 0.04, buffGain[0][0] * 0.04);
            sphere.draw();
            billboardShader.end();
            
            ofPopStyle();
            ofPopMatrix();
            
            ofPopMatrix();
            
        } else {
            markerOnOff = false;
        }
        camera.end();
    }
    
    // ========== DEBUG STUFF ============= //
    //    processor->debugInfo.drawDebugInformation(font);
        
}

//--------------------------------------------------------------
void ofApp::exit() {
    
}

//--------------------------------------------------------------
void ofApp::audioOut(float * output, int bufferSize, int nChannels) {
    
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs &touch){
    
    arStart = !arStart;
    if (!arStart) {
        movingFactor = 0;
        movingSpeed = 0.05;
    }
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    processor->restartSession();
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
    
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
    
    processor->deviceOrientationChanged(newOrientation);
    
}


//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs& args){
    
}
