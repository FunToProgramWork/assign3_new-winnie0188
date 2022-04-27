final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int time,groundhog;
boolean cabStat;
final int BLOCK = 80;
final int groundhog_IDLE = 0,groundhog_DOWN = 1,groundhog_LEFT = 2,groundhog_RIGHT = 3;
float soldierX,soldierY,cabX,cabY,groundhog_X,groundhog_Y,offsetY=0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage bg;
PImage heartImg;
PImage title;
PImage gameover;
PImage startNormal;
PImage startHovered;
PImage restartNormal;
PImage restartHovered;
PImage soil8x24;
PImage soil0;
PImage soil1;
PImage soil2;
PImage soil3;
PImage soil4;
PImage soil5;
PImage stone1;
PImage stone2;
PImage groundhogIdleImg;
PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;
PImage soldierImg;
PImage cabImg;

int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  heartImg = loadImage("img/life.png");
  soldierImg = loadImage("img/soldier.png");
  cabImg = loadImage("img/cabbage.png");
  
  gameState = GAME_START;
}

void draw() {
    
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }

    
	switch (gameState) {

    case GAME_START: 
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        
        mousePressed = false;

        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        cabStat=true;
      
        playerHealth = 2;
        groundhog_X = 4*BLOCK;
        groundhog_Y = BLOCK;
  
        groundhog=groundhog_IDLE;
        offsetY=0;
        gameState = GAME_RUN;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: 

		
		image(bg, 0, 0);//BG

   
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);
    
    pushMatrix();
    translate(0, offsetY);

    
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);


    for(int i=0;i<8;i++){
      for(int j=0;j<24;j++){
        if(j<4){
        image(soil0,i*80,160+j*80);
        }else if(j<8){
        image(soil1,i*80,160+j*80);
        }else if(j<12){
        image(soil2,i*80,160+j*80);
        }else if(j<16){
        image(soil3,i*80,160+j*80);
        }else if(j<20){
        image(soil4,i*80,160+j*80);
        }else if(j<24){
        image(soil5,i*80,160+j*80);
        }
      }
    }
    
    for(int i=0;i<8;i++){
      image(stone1,i*80,160+i*80);
    }
    for(int i=0;i<8;i++){
      for(int j=8;j<16;j++){
        if(j==8 || j==11||j==12||j==15){
          if(i==1 || i==2||i==5||i==6){
          image(stone1,i*80,160+j*80);
          }
        }else{
          if(i==0 || i==3||i==4||i==7){
          image(stone1,i*80,160+j*80);
          }
        }
      }
    }
    
    for(int i=0;i<8;i++){
      for(int j=16;j<24;j++){
        if(i+j==17||i+j==18||i+j==20||i+j==21||i+j==23||i+j==24||i+j==26||i+j==27||i+j==29||i+j==30){
          image(stone1,i*80,160+j*80);
          if(i+j==18||i+j==21||i+j==24||i+j==27||i+j==30){
          image(stone2,i*80,160+j*80);
          }
        }
      }
    }
    

    switch(groundhog){
      case groundhog_IDLE:
        image(groundhogIdleImg,groundhog_X,groundhog_Y);
        break;
      case groundhog_DOWN:
        image(groundhogDownImg,groundhog_X,groundhog_Y);
        time+=1;
        groundhog_Y+=80.0/15;
        break;
      case groundhog_RIGHT:
        image(groundhogRightImg,groundhog_X,groundhog_Y);
        time+=1;
        groundhog_X+=80.0/15;
        break;
      case groundhog_LEFT:
        image(groundhogLeftImg,groundhog_X,groundhog_Y);
        time+=1;
        groundhog_X-=80.0/15;
        break;
    }
    
    if(offsetY>-20*BLOCK){
      offsetY=BLOCK-groundhog_Y;
    }
    
    if(time==15){
      groundhog=groundhog_IDLE;
      if(groundhog_Y%BLOCK<10){
        groundhog_Y=groundhog_Y-groundhog_Y%BLOCK;
      }else{
        groundhog_Y=groundhog_Y-groundhog_Y%BLOCK+BLOCK;
      }
      if(groundhog_X%BLOCK<10){
        groundhog_X=groundhog_X-groundhog_X%BLOCK;
      }else{
        groundhog_X=groundhog_X-groundhog_X%BLOCK+BLOCK;
      }
      time=0;
    }
    
    image(soldierImg,soldierX-80,soldierY);
    soldierX+=3;
    soldierX%=720;
    
    if(cabStat){
      image(cabImg,cabX,cabY);
    
      if(groundhog_X<cabX+BLOCK && groundhog_X+BLOCK>cabX && groundhog_Y<cabY+BLOCK && groundhog_Y+BLOCK>cabY){
        cabStat=false;
        playerHealth++;
      }
    }
    
    if(groundhog_X<soldierX-80+BLOCK && groundhog_X+BLOCK>soldierX-80 && groundhog_Y<soldierY+BLOCK && groundhog_Y+BLOCK>soldierY){
      playerHealth--;
      groundhog=groundhog_IDLE;
      
      groundhog_X=4*BLOCK;
      groundhog_Y=BLOCK; 
    }
    

    if(playerHealth==0){
      gameState=GAME_OVER;
    }
    
    popMatrix();
      
    for(int i=0;i<playerHealth;i++)
    {
      image(heartImg,10+i*70,10);
    }
		break;

		case GAME_OVER:
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				mousePressed = false;
        
        soldierX=0;
        soldierY=BLOCK*(int(random(4)+2));
        
        cabX=BLOCK*int(random(8));
        cabY=BLOCK*(int(random(4))+2);
        
        cabStat=true;

        playerHealth=2;
        groundhog_X=4*BLOCK;
        groundhog_Y=BLOCK;
        groundhog=groundhog_IDLE;
        
        offsetY=0;
        
        gameState = GAME_RUN;

			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
    if(key ==CODED){
          switch(keyCode){
            case DOWN:
              if(groundhog_Y+BLOCK<26*BLOCK && groundhog == groundhog_IDLE){
                groundhog=groundhog_DOWN;
                time=0;
              }
              break;
            case RIGHT:
              if(groundhog_X+BLOCK<width && groundhog == groundhog_IDLE){
                groundhog=groundhog_RIGHT;
                time=0;
              }
              break;
            case LEFT:
              if(groundhog_X>0 && groundhog == groundhog_IDLE){
                groundhog=groundhog_LEFT;
                time=0;
              }
              break;
          }
        }
  
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
   }

}
