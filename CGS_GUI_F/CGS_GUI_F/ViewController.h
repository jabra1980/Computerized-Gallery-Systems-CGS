//
//  ViewController.h
//  CGS_GUI_F
//
//  Created by english on 2022-11-28.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController


-(BOOL) statusVerifier:(NSString *) artpID;

-(float) checkValue:(NSString *) artpID;

-(void) changeStausToSold:(NSString *) artpID;

-(NSString *) getCuratorIDFromPieceID:(NSString *) artpID;

-(void) setCommission: (NSString *) curatorID : (float) value : (float) estimate;

-(void) setEstimate: (NSString*) artpID : (float) estimate;

- (IBAction)loginBT:(id)sender;

- (IBAction)addCouratorBT:(id)sender;

-(BOOL) curatorVerifier:(NSString *) curID;

- (IBAction)addArtist:(id)sender;

- (IBAction)addArtPieceBT:(id)sender;

-(BOOL) artPieceVerifier:(NSString *) artpID;

-(BOOL) artVerifier:(NSString *) curID;

- (IBAction)sellArtPBT:(id)sender;

-(void) writeIntoCurators;
-(void) readFromCurators;

-(void) writeIntoArtpieces;
-(void) readFromArtpieces;

-(void) writeIntoArtists;
-(void) readFromArtists;





@end

