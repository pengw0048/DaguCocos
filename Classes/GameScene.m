//
//  GameScene.m
//  DaguCocos
//
//  Created by Tiancai HB on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
-(void) addJf:(double)v {
	jf+=v;
	if (jf>1.0) jf=1.0;
	if (jf<0.0) jf=0.0;
	if (v>0.0) lianda++;
	if (v<0.0) lianda=0;
	if (lianda>999) lianda=999;
}
+(id) scene {
	CCScene *scene = [CCScene node]; 
	CCLayer *layer = [GameScene node];
	[scene addChild:layer]; 
	return scene;
}
-(id) init {
	if ((self = [super init])) {
		CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	}
	self.isTouchEnabled=YES;
	
	NSString *fn=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"songs.plist"];
	CCLOG(@"%@",fn);
	if ([[NSFileManager defaultManager] fileExistsAtPath:fn]) {
		nd=[[NSDictionary alloc] initWithContentsOfFile:fn];
		ndLen=[(NSString *)[nd valueForKey:@"NumSongs"] intValue];
		bgmove=(NSString *)[nd valueForKey:@"BGMove"]==@"YES";
		curSongNum=1;
	}
	prompt=[CCLabelTTF labelWithString:@"请按画面左下角" fontName:@"Arial" fontSize:50];
	prompt.position=CGPointMake(240, 160);
	[self addChild:prompt z:250];
	prompt.visible=FALSE;
	NSString *dd=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
	NSString *fn2=[dd stringByAppendingPathComponent:@"settings.plist"];
	if ([[NSFileManager defaultManager] fileExistsAtPath:fn2]) {
		FILE *f2=fopen([fn2 UTF8String], "r");
		int a;
		fscanf(f2, "%d", &a);
		fclose(f2);
		forTouch=(a==1);
	} else {
		prompt.visible=TRUE;
	}
	
	screen=[[CCDirector sharedDirector] winSize];
	bg1=[CCSprite spriteWithFile:@"bg_upper.png"];
	bg1a=[CCSprite spriteWithFile:@"bg_upper.png"];
	bg1c=[CCSprite spriteWithFile:@"bg1_clear.png"];
	bg1ca=[CCSprite spriteWithFile:@"bg1_clear.png"];
	bg1m=[CCSprite spriteWithFile:@"bg1_miss.png"];
	bg1ma=[CCSprite spriteWithFile:@"bg1_miss.png"];
	bg2=[CCSprite spriteWithFile:@"bg_lower.png"];
	[self addChild:bg1];
	[self addChild:bg1a];
	[self addChild:bg1c];
	[self addChild:bg1ca];
	[self addChild:bg1m];
	[self addChild:bg1ma];
	[self addChild:bg2];
	bg1.position=CGPointMake(240, 281);
	bg1a.position=CGPointMake(720, 281);
	bg1c.position=CGPointMake(240, 281);
	bg1ca.position=CGPointMake(720, 281);
	bg1m.position=CGPointMake(240, 281);
	bg1ma.position=CGPointMake(720, 281);
	bg1c.visible=FALSE;
	bg1ca.visible=FALSE;
	bg1m.visible=FALSE;
	bg1ma.visible=FALSE;
	bg2.position=CGPointMake(240, 75);
	
	mtaiko=[CCSprite spriteWithFile:@"mtaiko.png"];
	[self addChild:mtaiko z:125];
	mtaiko.position=CGPointMake(52, 210);
	mb1=[CCSprite spriteWithFile:@"mtaikoflash_blue1.png"];
	[self addChild:mb1 z:126];
	mb1.position=CGPointMake(52, 210);
	mb2=[CCSprite spriteWithFile:@"mtaikoflash_blue2.png"];
	[self addChild:mb2 z:126];
	mb2.position=CGPointMake(52, 210);
	mr1=[CCSprite spriteWithFile:@"mtaikoflash_red1.png"];
	[self addChild:mr1 z:126];
	mr1.position=CGPointMake(52, 210);
	mr2=[CCSprite spriteWithFile:@"mtaikoflash_red2.png"];
	[self addChild:mr2 z:126];
	mr2.position=CGPointMake(52, 210);
	CGRect r1=CGRectMake(0, 0, 48, 48);
	CGPoint p1=CGPointMake(130, 206);
	CCTexture2D *txt1=[[CCTextureCache sharedTextureCache] addImage:@"notes.png"];
	CCTexture2D *txt2=[[CCTextureCache sharedTextureCache] addImage:@"soul.png"];
	CCTexture2D *txt3=[[CCTextureCache sharedTextureCache] addImage:@"combonumber.png"];
	for (int i=0;i<3;i++)
		for (int j=0;j<10;j++) {
			dig[i][j]=[CCSprite spriteWithTexture:txt3 rect:CGRectMake(17*j, 0, 17, 30)];
			dig[i][j].visible=FALSE;
			[self addChild:dig[i][j] z:210];
		}
	bazi=[CCSprite spriteWithTexture:txt1 rect:r1];
	[self addChild:bazi z:100];
	bazi.position=p1;
	white=[CCSprite spriteWithFile:@"white.png"];
	[self addChild:white z:100];
	white.position=CGPointMake(240, 164);
	gauge=[CCSprite spriteWithFile:@"gauge4.png"];
	[self addChild:gauge z:120];
	gauge.position=CGPointMake(315, 280);
	gu=[CCSprite spriteWithFile:@"gu.png"];
	[self addChild:gu];
	gu.position=CGPointMake(240, 65);
	for (int i=0; i<8; i++) {
		soul[i]=[CCSprite spriteWithTexture:txt2 rect:CGRectMake(i*80+80, 0, 80, 80)];
		[self addChild:soul[i] z:119];
		soul[i].position=CGPointMake(440, 280);
		soul[i].visible=FALSE;
	}
	for (int i=0; i<48; i++) {
		gbar1[i]=[CCSprite spriteWithFile:@"gbar1.png"];
		[self addChild:gbar1[i] z:121];
		gbar1[i].position=CGPointMake(177+i*4, 273);
		gbar1[i].visible=FALSE;
	}
	for (int i=0; i<15; i++) {
		gbar2[i]=[CCSprite spriteWithFile:@"gbar2.png"];
		[self addChild:gbar2[i] z:121];
		gbar2[i].position=CGPointMake(177+192+i*4, 276);
		gbar2[i].visible=FALSE;
	}
	p1=CGPointMake(-30, 0);
	r1=CGRectMake(48, 0, 48, 48);
	for (int i=0;i<5;i++) {
		bar[i]=[CCSprite spriteWithFile:@"bar.png"];
		[self addChild:bar[i] z:90];
	}
	for (int i=0;i<50;i++) {
		dong[i]=[CCSprite spriteWithTexture:txt1 rect:r1];
		[self addChild:dong[i] z:120];
		dong[i].position=p1;
		dong[i].visible=FALSE;
	}
	r1=CGRectMake(96, 0, 48, 48);
	for (int i=0;i<50;i++) {
		ka[i]=[CCSprite spriteWithTexture:txt1 rect:r1];
		[self addChild:ka[i] z:120];
		ka[i].position=p1;
		ka[i].visible=FALSE;
	}
	selSong=[CCSprite spriteWithFile:@"songselectbg.png"];
	[self addChild:selSong z:200];
	selSong.position=CGPointMake(240, 160);
	selSong.visible=FALSE;
	aleft=[CCSprite spriteWithFile:@"arrleft.png"];
	[self addChild:aleft z:201];
	aleft.position=CGPointMake(30, 160);
	aleft.visible=FALSE;
	aright=[CCSprite spriteWithFile:@"arrright.png"];
	[self addChild:aright z:201];
	aright.position=CGPointMake(450, 160);
	aright.visible=FALSE;
	p1=CGPointMake(130, 206);
	txt1=[[CCTextureCache sharedTextureCache] addImage:@"exp1.png"];
	for (int i=0;i<4;i++)
		for(int j=0;j<4;j++) {
			r1=CGRectMake(j*48, i*48, 48, 48);
			exp1[i][j]=[CCSprite spriteWithTexture:txt1 rect:r1];
			[self addChild:exp1[i][j] z:105];
			exp1[i][j].position=p1;
			exp1[i][j].visible=FALSE;
		}
	txt1=[[CCTextureCache sharedTextureCache] addImage:@"exp2.png"];
	for (int i=0;i<4;i++)
		for(int j=0;j<4;j++) {
			r1=CGRectMake(j*140, i*140, 140, 140);
			exp2a[i][j]=[CCSprite spriteWithTexture:txt1 rect:r1];
			[self addChild:exp2a[i][j] z:104];
			exp2a[i][j].position=p1;
			exp2a[i][j].visible=FALSE;
		}
	txt1=[[CCTextureCache sharedTextureCache] addImage:@"judge.png"];
	for (int i=0;i<3;i++){
		r1=CGRectMake(0, i*25, 63, 25);
		judge[i]=[CCSprite spriteWithTexture:txt1 rect:r1];
		[self addChild:judge[i] z:103];
		judge[i].position=p1;
		judge[i].visible=FALSE;
	}
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"dong.wav"];
	[[SimpleAudioEngine sharedEngine] preloadEffect:@"ka.wav"];
	lbl1=[CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:20];
	rt1=[CCLabelTTF labelWithString:@"" fontName:@"Arial" fontSize:20];
	[self addChild:rt1 z:250];
	rt1.visible=FALSE;
	rt1.position=CGPointMake(240, 210);
	[self addChild:lbl1 z:210];
	lbl1.position=CGPointMake(240, 160);
	lbl1.visible=FALSE;
	curSongNum=1;
	[self load1];
	[self scheduleUpdate];
	return self;
}
-(void) showSel {
	[lbl1 setString:(NSString *)[(NSDictionary *)[nd valueForKey:[NSString stringWithFormat:@"%d",curSongNum]] valueForKey:@"Name"]];
}
-(void) load1 {
	lbl1.color=ccc3(255, 255, 255);
	lbl1.anchorPoint=CGPointMake(0.5, 0.5);
	lbl1.position=CGPointMake(240, 160);
	ended=FALSE;
	rt1.visible=FALSE;
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	selSong.visible=TRUE;
	aleft.visible=TRUE;
	aright.visible=TRUE;
	lbl1.visible=TRUE;
	[self showSel];
}
-(void) load2 {
	guStg=0;
	lianda=0;
	lbl1.anchorPoint=CGPointMake(1.0, 0.0);
	lbl1.position=CGPointMake(480, 125);
	lbl1.color=ccc3(0, 0, 0);
	waitForStart=FALSE;
	//lbl1.visible=FALSE;
	selSong.visible=FALSE;
	aleft.visible=FALSE;
	aright.visible=FALSE;
	jf=0.0;
	started=false;
	bLen=0;
	xjLen=0;
	dp=kp=0;
	pjStage=0;
	currXj=0;
	cms1[0]=cms1[1]=4;
	pan1=9;
	pan2=24;
	pan3=30;
	scroll=1.0;
	tBase=0.0;
	yfs=0;
	cLiang=cKe=cBuke=0;
	mb1s=mb2s=mr1s=mr2s=0;
	ltMiss=FALSE;
	
	bg1.position=CGPointMake(240, 281);
	bg1a.position=CGPointMake(720, 281);
	bg1c.position=CGPointMake(240, 281);
	bg1ca.position=CGPointMake(720, 281);
	bg1m.position=CGPointMake(240, 281);
	bg1ma.position=CGPointMake(720, 281);
	bg1.visible=TRUE;
	bg1a.visible=TRUE;
	bg1c.visible=FALSE;
	bg1ca.visible=FALSE;
	bg1m.visible=FALSE;
	bg1ma.visible=FALSE;
	bgPos=240;
	for (int i=0;i<500;i++) xjyfLen[i]=gogoInfo[i]=0;
	NSString *fn=(NSString *)[(NSDictionary *)[nd valueForKey:[NSString stringWithFormat:@"%d",curSongNum]] valueForKey:@"File"];
	NSString *ts=[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fn];
	const char *path=[ts UTF8String];
	FILE *fp=fopen(path, "r");
	char buf1[300],buf2[300];
	int p=0;
	while (fgets(buf1, 300, fp)) {
		int l=strlen(buf1);
		p=0;
		for (int i=0;i<l;i++) {
			if (buf1[i]=='/'&&buf1[i+1]=='/') {
				buf2[p]=0;
				goto nxt1;
			}
			if (buf1[i]!=' '&&buf1[i]!='\n'&&buf1[i]!='\r') buf2[p++]=buf1[i];
		}
		if (p==0) goto nxt1;
		buf2[p]=0;
		if (buf2[0]=='B'&&buf2[1]=='P') sscanf(buf2+4,"%lf",&bpm);
		else if (buf2[0]=='W'&&buf2[1]=='A') strcpy(wave,buf2+5);
		else if (buf2[0]=='O'&&buf2[1]=='F') sscanf(buf2+7,"%lf",&offset);
		else if (buf2[0]=='L'&&buf2[1]=='E') sscanf(buf2+6,"%d",&level);
		else if (buf2[0]=='J'&&buf2[1]=='U') sscanf(buf2+6,"%d,%d,%d",&pan1,&pan2,&pan3);
		else if (buf2[0]=='S'&&buf2[1]=='C') sscanf(buf2+7,"%lf",&scroll);
		else if (buf2[0]=='B'&&buf2[1]=='A') {
			l=strlen(buf2);
			int i=8;
			int num=0;
			while(i<=l){
				if (buf2[i]>='0'&&buf2[i]<='9') num=num*10+buf2[i]-'0';
				else {
					bTime[bLen++]=num;
					num=0;
				}
				i++;
			}
		}
		else if (buf2[0]>='0'&&buf2[0]<='9'){
			l=strlen(buf2)-1;
			xjyfLen[xjLen]=l;
			xjMs[xjLen][0]=cms1[0];
			xjMs[xjLen][1]=cms1[1];
			xjScr[xjLen]=scroll;
			for (int i=0;i<l;i++) xjyf[xjLen][i]=buf2[i]-'0';
			for (int i=0;i<l;i++) if (xjyf[xjLen][i]>0&&xjyf[xjLen][i]<=4) yfs++;
			xjLen++;
		}
		else if (buf2[0]=='#'&&buf2[1]=='G'&&buf2[5]=='S') gogoInfo[xjLen]=1;
		else if (buf2[0]=='#'&&buf2[1]=='G'&&buf2[5]=='E') gogoInfo[xjLen]=2;
		else if (buf2[0]=='#'&&buf2[1]=='M') {
			cms1[0]=buf2[8]-'0';
			cms1[1]=buf2[10]-'0';
		}
	nxt1:;
	}
	fclose(fp);
	CGRect r1=CGRectMake(0, 0, 48, 48);
	CGPoint p1=CGPointMake(130, 206);
	bazi.position=p1;
	p1=CGPointMake(-30, 0);
	r1=CGRectMake(48, 0, 48, 48);
	for (int i=0;i<50;i++) {
		dong[i].position=p1;
		dong[i].visible=FALSE;
	}
	r1=CGRectMake(96, 0, 48, 48);
	for (int i=0;i<50;i++) {
		ka[i].position=p1;
		ka[i].visible=FALSE;
	}
	p1=CGPointMake(130, 206);
	for (int i=0;i<4;i++)
		for(int j=0;j<4;j++) {
			exp1[i][j].position=p1;
			exp1[i][j].visible=FALSE;
		}
	for (int i=0;i<4;i++)
		for(int j=0;j<4;j++) {
			exp2a[i][j].position=p1;
			exp2a[i][j].visible=FALSE;
		}
	for (int i=0;i<3;i++){
		judge[i].position=p1;
		judge[i].visible=FALSE;
	}
	for (int i=0;i<48;i++)gbar1[i].visible=FALSE;
	for (int i=0;i<15;i++)gbar2[i].visible=FALSE;
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:[NSString stringWithFormat:@"%s",wave]];
}
-(void) update:(ccTime)delta {
	CGPoint tp2=CGPointMake(130, 206);
	for (int i=0; i<4; i++) {
		for (int j=0; j<4; j++) {
			exp1[i][j].visible=FALSE;
			exp2a[i][j].visible=FALSE;
		}
	}
	for (int i=0;i<3;i++)
		for (int j=0;j<10;j++)
			dig[i][j].visible=FALSE;
	mb1.visible=FALSE;
	mb2.visible=FALSE;
	mr1.visible=FALSE;
	mr2.visible=FALSE;
	for (int i=0; i<8; i++) {
		soul[i].visible=FALSE;
	}
	for (int i=0; i<3; i++) {
		judge[i].visible=FALSE;
	}
	
	for (int i=0;i<5;i++) bar[i].visible=FALSE;
	for (int i=0; i<dp; i++) {
		dong[i].visible=FALSE;
	}
	for (int i=0; i<kp; i++) {
		ka[i].visible=FALSE;
	}
	dp=0;
	kp=0;
	gu.position=CGPointMake(240, 65);
	if (guStg>0&&guStg<5) {
		gu.position=CGPointMake(240, 65-guStg);
		guStg++;
	}
	if (guStg>=5) {
		gu.position=CGPointMake(240, 65-(10-guStg));
		guStg++;
		if (guStg>=10) guStg=0;
	}
	if (started==FALSE) return;
	
	if (mb1s>0) {
		mb1.visible=TRUE;
		mb1s++;
		if (mb1s>8) mb1s=0;
	}
	if (mb2s>0) {
		mb2.visible=TRUE;
		mb2s++;
		if (mb2s>8) mb2s=0;
	}
	if (mr1s>0) {
		mr1.visible=TRUE;
		mr1s++;
		if (mr1s>6) mr1s=0;
	}
	if (mr2s>0) {
		mr2.visible=TRUE;
		mr2s++;
		if (mr2s>6) mr2s=0;
	}
	bg1.visible=FALSE;
	bg1a.visible=FALSE;
	bg1c.visible=FALSE;
	bg1ca.visible=FALSE;
	bg1m.visible=FALSE;
	bg1ma.visible=FALSE;
	bgPos--;
	if (bgPos<=-240) bgPos=240;
	if (!bgmove) bgPos=240;
	bg1.position=CGPointMake(bgPos, 281);
	bg1c.position=CGPointMake(bgPos, 281);
	bg1m.position=CGPointMake(bgPos, 281);
	bg1a.position=CGPointMake(bgPos+480, 281);
	bg1ca.position=CGPointMake(bgPos+480, 281);
	bg1ma.position=CGPointMake(bgPos+480, 281);
	for (int i=0;i<48;i++)gbar1[i].visible=FALSE;
	for (int i=0;i<15;i++)gbar2[i].visible=FALSE;
	double td1=jf;
	if (td1<0) td1=0;
	for (int i=(td1*63>48?48:td1*63)-1;i>=0;i--) gbar1[i].visible=TRUE;
	for (int i=(td1*63>63?63:td1*63)-1;i>=48;i--)gbar2[i-48].visible=TRUE;
	if (td1*63<48) {
		bg1.visible=TRUE;
		bg1a.visible=TRUE;
	} else if (ltMiss==FALSE) {
		bg1c.visible=TRUE;
		bg1ca.visible=TRUE;
	} else {
		bg1m.visible=TRUE;
		bg1ma.visible=TRUE;
	}
	if (jf>0.999) {
		soul[soulStg/4].visible=TRUE;
		soulStg++;
		if (soulStg>=32) soulStg=0;
	}
	if (lianda>=10&&lianda<100) {
		dig[0][lianda/10].position=CGPointMake(43, 210);
		dig[0][lianda/10].visible=TRUE;
		dig[1][lianda%10].position=CGPointMake(61, 210);
		dig[1][lianda%10].visible=TRUE;
	} else if (lianda>=100) {
		dig[0][lianda/100].position=CGPointMake(34, 210);
		dig[0][lianda/100].visible=TRUE;
		dig[1][(lianda/10)%10].position=CGPointMake(52, 210);
		dig[1][(lianda/10)%10].visible=TRUE;
		dig[2][lianda%10].position=CGPointMake(70, 210);
		dig[2][lianda%10].visible=TRUE;
	}
	
	double def=[[[SimpleAudioEngine sharedEngine] getPlayer] currentTime]-tBase; //[now timeIntervalSinceDate:tStart]-tBase;
	double cxjTime=xjMs[currXj][0]/(bpm/60.0),viewStart,viewEnd,lastPos,td;
	int cxj=currXj-1;
	if (cxj>=0&&cxj<xjLen) scroll=xjScr[cxj];
	lastPos=-350/scroll*(def/cxjTime)+130;

	if (pjStage!=0) {
		if (pjStage>=100&&pjStage<116) {
			exp1[0][(pjStage-100)/4].visible=TRUE;
			exp2a[0][(pjStage-100)/4].visible=TRUE;
		} else if (pjStage>=200&&pjStage<216) {
			exp1[1][(pjStage-200)/4].visible=TRUE;
			exp2a[1][(pjStage-200)/4].visible=TRUE;
		}
		if (pjStage<400) {
			CGPoint tp4=CGPointMake(130, 320-(82-(pjStage%100)*2));
			judge[pjStage/100-1].position=tp4;
			judge[pjStage/100-1].visible=TRUE;
		}
		pjStage++;
		if (pjStage<=400&&pjStage%100>=20) pjStage=0;
	}
	int barn=0;
	lastPos=-350/scroll*(def/cxjTime)+130;
	while (lastPos>0) {
		if (cxj<0) break; 
		viewEnd=lastPos;
		viewStart=viewEnd-350.0/scroll;
		bar[barn].position=CGPointMake(viewStart-1, 206);
		bar[barn++].visible=TRUE;
		for (int i=0; i<xjyfLen[cxj]; i++) {
			switch (xjyf[cxj][i]) {
				case 1:case 3:
					td=viewStart+350.0/scroll/xjyfLen[cxj]*i;
					if (td>0&&td<=510) {
						tp2=CGPointMake(td, 206);
						dong[dp].position=tp2;
						dong[dp++].visible=TRUE;
					}
					if (td>0&&td<130-pan3) {
						[self addJf:-2.8/yfs];
						xjyf[cxj][i]=0;
					}
					break;
				case 2:case 4:
					td=viewStart+350.0/scroll/xjyfLen[cxj]*i;
					if (td>0&&td<=510) {
						tp2=CGPointMake(td, 206);
						ka[kp].position=tp2;
						ka[kp++].visible=TRUE;
					}
					if (td>0&&td<130-pan3) {
						[self addJf:-2.8/yfs];
						xjyf[cxj][i]=0;
					}
					break;
				default:
					break;
			}
		}
		lastPos=viewStart;
		cxj--;
	}
	cxj=currXj-1;
	lastPos=-350/scroll*(def/cxjTime)+130;
	while (lastPos<480) {
		cxj++;
		if (cxj>=xjLen) break;
		viewStart=lastPos;
		viewEnd=viewStart+350.0/scroll;
		bar[barn].position=CGPointMake(viewStart-1, 206);
		bar[barn++].visible=TRUE;
		for (int i=0; i<xjyfLen[cxj]; i++) {
			switch (xjyf[cxj][i]) {
				case 1:case 3:
					td=viewStart+350.0/scroll/xjyfLen[cxj]*i;
					if (td>0&&td<=510) {
						tp2=CGPointMake(td, 206);
						dong[dp].position=tp2;
						dong[dp++].visible=TRUE;
					}
					if (td>0&&td<130-pan3) {
						[self addJf:-2.8/yfs];
						xjyf[cxj][i]=0;
					}
					break;
				case 2:case 4:
					td=viewStart+350.0/scroll/xjyfLen[cxj]*i;
					if (td>0&&td<=510) {
						tp2=CGPointMake(td, 206);
						ka[kp].position=tp2;
						ka[kp++].visible=TRUE;
					}
					if (td>0&&td<130-pan3) {
						[self addJf:-2.8/yfs];
						xjyf[cxj][i]=0;
					}
					break;
				default:
					break;
			}
		}
		lastPos=viewEnd;
	}
	while (def>cxjTime&&currXj<xjLen) {
		tBase+=cxjTime;
		def-=cxjTime;
		currXj++;
		cxjTime=xjMs[currXj][1]/(bpm/60.0);
	}
	if (currXj>=xjLen) {
		started=FALSE;
		ended=TRUE;
		[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		rt1.visible=TRUE;
		[rt1 setString:[NSString stringWithFormat:@"良：%d 可：%d 不可：%d",cLiang,cKe,cBuke]];
	}
//nxt2:;

}
-(void) dealloc {
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	[super dealloc];
}
-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	lx=[touch locationInView:[touch view]].x;
	ly=[touch locationInView:[touch view]].y;
	if (forTouch) {
		int t=ly;
		ly=lx;
		lx=t;
		ly=320-ly;
	}
	CCLOG(@"%d %d",lx,ly);
	if (ended) {
		ended=FALSE;
		[self load1];
		return YES;
	}
	//if (i.phase!=UITouchPhaseBegan) continue;
	if (prompt.visible==TRUE) {
		prompt.visible=FALSE;
		forTouch=(ly<160);
		NSString *dd=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
		NSString *fn2=[dd stringByAppendingPathComponent:@"settings.plist"];
			FILE *f2=fopen([fn2 UTF8String], "w");
			fprintf(f2, "%d\n",(int)forTouch);
			fclose(f2);		return YES;
	}
	if ((!waitForStart)&&(!started)&&selSong.visible==TRUE){
		if (lx<60) {
			curSongNum--;
			if (curSongNum<=0) curSongNum=ndLen;
			[[SimpleAudioEngine sharedEngine] playEffect:@"ka.wav"];
			[self showSel];
		} else if (lx>420) {
			curSongNum++;
			if (curSongNum>ndLen) curSongNum=1;
			[[SimpleAudioEngine sharedEngine] playEffect:@"ka.wav"];
			[self showSel];
		} else {
			[[SimpleAudioEngine sharedEngine] playEffect:@"dong.wav"];
			[self load2];
		}
	} else if ((!waitForStart)&&(!started)&&selSong.visible==FALSE){
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:[NSString stringWithFormat:@"%s",wave] loop:1];
		currXj=0;
		tBase=offset;
		tStart=[NSDate date];
		[tStart retain];
		xjStart=[NSDate date];
		[xjStart retain];
		started=true;
	} else if (waitForStart) {
		
	} else {
		if (ly<80) {
			bLen=0;
			xjLen=0;
			bLen=0;
			cms1[0]=cms1[1]=4;
			currXj=0;
			pjStage=0;
			started=false;
			[self load1];
		} else if (ly>170&&lx>=100&&lx<=380) {
			//NSDate *now=[NSDate date];
			guStg=1;
			[[SimpleAudioEngine sharedEngine] playEffect:@"dong.wav"];
			if (lx<240) mr1s=1;
			else mr2s=1;
			double def=[[[SimpleAudioEngine sharedEngine] getPlayer] currentTime]-tBase;
			double cxjTime=xjMs[currXj][0]/(bpm/60.0),lastPos,td;
			lastPos=-350/scroll*(def/cxjTime)+130;
			if (currXj>0) {
				for (int i=0;i<xjyfLen[currXj-1];i++){
					td=abs(lastPos-350/scroll+350.0/scroll/xjyfLen[currXj-1]*i-130);
					if (xjyf[currXj-1][i]!=1&&xjyf[currXj-1][i]!=3)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj-1][i]=0;
						cLiang++;
						ltMiss=FALSE;
						[self addJf:1.4/yfs];
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj-1][i]=0;
						cKe++;
						ltMiss=FALSE;
						[self addJf:0.7/yfs];
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj-1][i]=0;
						cBuke++;
						ltMiss=TRUE;
						[self addJf:-2.8/yfs];
						return YES;
					}
				}
			}
			if (true) {
				for (int i=0;i<xjyfLen[currXj];i++){
					td=abs(lastPos+350.0/scroll/xjyfLen[currXj]*i-130);
					if (xjyf[currXj][i]!=1&&xjyf[currXj][i]!=3)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj][i]=0;
						cLiang++;
						ltMiss=FALSE;
						[self addJf:1.4/yfs];
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj][i]=0;
						cKe++;
						ltMiss=FALSE;
						[self addJf:0.7/yfs];
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj][i]=0;
						cBuke++;
						ltMiss=TRUE;
						[self addJf:-2.8/yfs];
						return YES;
					}
				}
			}
			if (currXj<xjLen-1) {
				for (int i=0;i<xjyfLen[currXj+1];i++){
					td=abs(lastPos+350/scroll+350.0/scroll/xjyfLen[currXj+1]*i-130);
					if (xjyf[currXj+1][i]!=1&&xjyf[currXj+1][i]!=3)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj+1][i]=0;
						cLiang++;
						ltMiss=FALSE;
						[self addJf:1.4/yfs];
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj+1][i]=0;
						cKe++;
						ltMiss=FALSE;
						[self addJf:0.7/yfs];
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj+1][i]=0;
						cBuke++;
						ltMiss=TRUE;
						[self addJf:-2.8/yfs];
						return YES;
					}
				}
			}
		} else if (ly>170&&(lx<100||lx>380)) {
			//NSDate *now=[NSDate date];
			guStg=1;
			[[SimpleAudioEngine sharedEngine] playEffect:@"ka.wav"];
			if (lx<100) mb1s=1;
			else mb2s=1;
			double def=[[[SimpleAudioEngine sharedEngine] getPlayer] currentTime]-tBase;
			double cxjTime=xjMs[currXj][0]/(bpm/60.0),lastPos,td;
			lastPos=-350/scroll*(def/cxjTime)+130;
			if (currXj>0) {
				for (int i=0;i<xjyfLen[currXj-1];i++){
					td=abs(lastPos-350/scroll+350.0/scroll/xjyfLen[currXj-1]*i-130);
					if (xjyf[currXj-1][i]!=2&&xjyf[currXj-1][i]!=4)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj-1][i]=0;
						cLiang++;
						ltMiss=FALSE;
						[self addJf:1.4/yfs];
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj-1][i]=0;
						cKe++;
						ltMiss=FALSE;
						[self addJf:0.7/yfs];
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj-1][i]=0;
						cBuke++;
						[self addJf:-2.8/yfs];
						ltMiss=TRUE;
						return YES;
					}
				}
			}
			if (true) {
				for (int i=0;i<xjyfLen[currXj];i++){
					td=abs(lastPos+350.0/scroll/xjyfLen[currXj]*i-130);
					if (xjyf[currXj][i]!=2&&xjyf[currXj][i]!=4)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj][i]=0;
						cLiang++;
						[self addJf:1.4/yfs];
						ltMiss=FALSE;
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj][i]=0;
						cKe++;
						[self addJf:0.7/yfs];
						ltMiss=FALSE;
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj][i]=0;
						cBuke++;
						[self addJf:-2.8/yfs];
						ltMiss=TRUE;
						return YES;
					}
				}
			}
			
			if (currXj<xjLen-1) {
				for (int i=0;i<xjyfLen[currXj+1];i++){
					td=abs(lastPos+350/scroll+350.0/scroll/xjyfLen[currXj+1]*i-130);
					if (xjyf[currXj+1][i]!=2&&xjyf[currXj+1][i]!=4)continue;
					if (td<pan1) {
						pjStage=100;
						xjyf[currXj+1][i]=0;
						cLiang++;
						ltMiss=FALSE;
						[self addJf:1.4/yfs];
						return YES;
					} else if (td<pan2) {
						pjStage=200;
						xjyf[currXj+1][i]=0;
						cKe++;
						ltMiss=FALSE;
						[self addJf:0.7/yfs];
						return YES;
					} else if (td<pan3) {
						pjStage=300;
						xjyf[currXj+1][i]=0;
						cBuke++;
						[self addJf:-2.8/yfs];
						ltMiss=TRUE;
						return YES;
					}
				}
			}
		}
	}
	return YES;
}
		 -(void) setScreenSaverEnabled:(bool)enabled
		{
			UIApplication *thisApp = [UIApplication sharedApplication];
			thisApp.idleTimerDisabled = !enabled;
		}
		 
@end
