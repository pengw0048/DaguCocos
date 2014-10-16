//
//  GameScene.h
//  DaguCocos
//
//  Created by Tiancai HB on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <stdio.h>
#import "SimpleAudioEngine.h"
@interface GameScene : CCLayer {
	bool started,ltMiss,waitForStart,forTouch,ended,bgmove;
	int level,bLen,bTime[100],course,xjLen,xjyfLen[500],xjyf[500][50],xjMs[500][2],cms1[2];
	int currXj,gogoInfo[500],pjStage;
	int pan1,pan2,pan3,yfs,lianda;
	int cLiang,cKe,cBuke;
	double offset,bpm,scroll,tBase,jf,xjScr[500];
	NSDate *tStart,*xjStart;
	char wave[100];
	CCSprite *bg1,*bg1a,*bg2,*dong[50],*ka[50],*bazi,*exp1[4][4],*judge[3],*exp2a[4][4],*bar[5],*white,*gauge,*gu,*gbar1[60],*gbar2[30];
	CCSprite *bg1c,*bg1ca,*bg1m,*bg1ma,*soul[9],*mtaiko,*mb1,*mb2,*mr1,*mr2,*selSong,*aleft,*aright;
	CCSprite *dig[3][10];
	int bgPos,soulStg,mb1s,mb2s,mr1s,mr2s;
	int lx,ly;
	int dp,kp,ndLen,curSongNum,guStg;
	NSDictionary *nd;
	CGSize screen;
	CCLabelTTF *lbl1,*prompt,*rt1;
}
+ (id) scene;
-(void) load1;
-(void) load2;

@end
