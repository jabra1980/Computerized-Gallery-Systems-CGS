//
//  ViewController.m
//  CGS_GUI_F
//
//  Created by english on 2022-11-28.
//

#import "ViewController.h"
#import "Curator.h"
#import "Artist.h"
#import "ArtPiece.h"


Curator *myCurator[10];
Artist *myArtist[10];
ArtPiece *myArtPiece[10];

int i_cur = 0;
int i_art = 0;
int i_artp = 0;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextBox;
@property (weak, nonatomic) IBOutlet UITextField *passTextBox;

@property (weak, nonatomic) IBOutlet UITextField *curTextBox;
@property (weak, nonatomic) IBOutlet UITextField *curFnameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *curLnameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *curCommTextBox;

@property (weak, nonatomic) IBOutlet UITextField *artTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artFnameTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artLnameTextBox;

@property (weak, nonatomic) IBOutlet UITextField *artPieceTextBox;
@property (weak, nonatomic) IBOutlet UITextField *curArtTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artArtpTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artpTitleTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artpYearTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artpValueTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artEstimateTextBox;
@property (weak, nonatomic) IBOutlet UITextField *artStatusTextBox;


@property (weak, nonatomic) IBOutlet UITextField *SellArtpieceIDTextBox;
@property (weak, nonatomic) IBOutlet UITextField *SellArtpieceEstamiteTextBox;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"/Users/user220600/Downloads/CGS_GUI_F/IOS.jpg"]]];
}

- (IBAction)sellArtPBT:(id)sender {
        NSString *artPieceid = [_SellArtpieceIDTextBox text];
        float estimate = [_SellArtpieceEstamiteTextBox.text floatValue];

        NSString* message;
            
        if([self artPieceVerifier:artPieceid] == false)
        {
            message = @"Error! Artpiece ID does not exist";
        }
        else
        {
            if([self statusVerifier:artPieceid] == true)
            {
                message = @"Error! This artpiece is already tagged as sold";
            }
            else
            {
                if(estimate < [self checkValue:artPieceid])
                {
                    message = @"Error! Estimate cannot be lower than artpiece value";
                }
                else
                {
                    [self changeStausToSold:artPieceid];
                    NSString *curatorId = [self getCuratorIDFromPieceID:artPieceid];
                    [self setCommission:curatorId : [self checkValue:artPieceid] : estimate];
                    [self setEstimate:artPieceid : estimate];
                    message = @"Success! Artpiece is now sold";
                }
            }
            
            
            
        }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message: message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    _SellArtpieceIDTextBox.text = nil;
    _SellArtpieceEstamiteTextBox.text = nil;
    
    
}


-(BOOL) artPieceVerifier:(NSString *) artpID{
    BOOL flag = false;
    for(int i = 0; i < 10; i++){
        if([myArtPiece[i] getID] == artpID){
            flag = true;
        }
    }
    return flag;
}

- (IBAction)addArtPieceBT:(id)sender {
    
    NSString *artPieceID = [_artPieceTextBox text];
    NSString *curID = [_curArtTextBox text];
    NSString *artID = [_artArtpTextBox text];
    NSString *title = [_artpTitleTextBox text];
    int year = [_artpYearTextBox.text intValue];
    float value = [_artpValueTextBox.text floatValue];
    float estimate = [_artEstimateTextBox.text floatValue];
    const char *status = [_artStatusTextBox.text UTF8String];

    
    NSString *message;
    
    if([artPieceID length] != 5)
    {
        message = @"Error! Artpiece ID must be 5 characters";
    }
    else
    {
        if([self artPieceVerifier:artPieceID] == true)
        {
            message = @"Error! This ID already exists";
        }
        else
        {
            if([self curatorVerifier:curID] == false)
            {
                message = @"Error! Curator ID is incorrect";
            }
            else
            {
                if([self artVerifier:artID] == false)
                {
                    message = @"Error! Artist ID is incorrect";
                }
                else
                {
                    if([[NSString stringWithFormat:@"%d",year] length] != 4)
                    {
                        message = @"Error! Year must be 4 digits";
                    }
                    else
                    {
                        ArtPiece *artpInstance = [[ArtPiece alloc] initartPieceID:artPieceID initcuratorID:curID initartistID:artID inittitle:title inityear:year initvalue:value initestimate:estimate initstatus:*status];
                        myArtPiece[i_artp] = artpInstance;
                        i_artp++;
                        message = @"Art piece has been successfully added to the list";
                        [self writeIntoArtpieces];
                        
                    }
                }
            }
        }
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message: message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    _artPieceTextBox.text = nil;
    _curArtTextBox.text = nil;
    _artArtpTextBox.text = nil;
    _artpTitleTextBox.text = nil;
    _artpYearTextBox.text = nil;
    _artpValueTextBox.text = nil;
    _artEstimateTextBox.text = nil;
    _artStatusTextBox.text = nil;

}

-(void) writeIntoArtpieces{
    @try {
        NSURL *url2 = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/ArtPiece.txt"];
        NSString *newFileContent2;
        for (int i = 0; i < sizeof(myArtPiece); i++) {
            if(myArtPiece[i] == NULL){}
            else{
            newFileContent2 = [NSString stringWithFormat:@"%@", [myArtPiece[i] toString]];
            }
        }
        [newFileContent2 writeToURL:url2 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    } @catch(NSException *ex){
        NSLog(@"%@", ex);
    }
}

-(void) readFromArtpieces{
    @try{
        NSURL *url22 = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/ArtPiece.txt"];
        NSString *fileContent22 = [NSString stringWithContentsOfURL: url22 encoding: NSUTF8StringEncoding error:nil];
        NSLog(@"fileContent: %@", fileContent22);
    }
    @catch(NSException *ex){
        NSLog(@"The name %@ and the reason %@ of the exception is", [ex name], [ex reason]);
    }
    @finally {
        NSLog(@"Drinking JF's coffee does not protect you against exception");
            
    }
}


-(BOOL) artVerifier:(NSString *) curID{
    BOOL flag = false;
    for (int i = 0; i < 10; i++) {
        if([myArtist[i] getArtistID] == curID){
            flag = true;
        }
    }
    return flag;
}


- (IBAction)addArtist:(id)sender {
    NSString *artID = [_artTextBox text];
    NSString *artFirstName = [_artFnameTextBox text];
    NSString *artLastName = [_artLnameTextBox text];
    
    NSString *message;
    if([artID length] != 5){
        message = @"Error! Artist ID must be 5 digits";
    }
    else{
        if([self artVerifier:artID] == true){
            
            message = @"Error! Artist ID already exists";
        }
        else{
            if([artFirstName length] + [artLastName length] > 40){
                message = @"Error! Firstname + lastname must be 40 characters maximum";
            }
            else{
                Artist *artistInstance = [[Artist alloc]  initartistID:artID initFN:artFirstName initLN:artLastName];
                myArtist[i_art] = artistInstance;
                i_art++;
                message = @"Artist has been successfully added to the list";
                [self writeIntoArtists];
                
            }
        }
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message: message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    _artTextBox.text = nil;
    _artFnameTextBox.text = nil;
    _artLnameTextBox.text = nil;
       
    
}

-(void) writeIntoArtists{
    @try {
        NSURL *url1 = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/Artist.txt"];
        NSString *newFileContent1;
        for (int i = 0; i < sizeof(myArtist); i++) {
            if(myArtist[i] == NULL){}
            else{
            newFileContent1 = [NSString stringWithFormat:@"%@", [myArtist[i] toString]];
            }
        }
        [newFileContent1 writeToURL:url1 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    @catch(NSException *ex){
        NSLog(@"%@", ex);
    }
}

-(void) readFromArtists{
    @try{
        NSURL *url11 = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/Artist.txt"];
        NSString *fileContent11 = [NSString stringWithContentsOfURL: url11 encoding: NSUTF8StringEncoding error:nil];
        NSLog(@"fileContent: %@", fileContent11);
    }
    @catch(NSException *ex){
        NSLog(@"The name %@ and the reason %@ of the exception is", [ex name], [ex reason]);
    }
    @finally {
        NSLog(@"Drinking JF's coffee does not protect you against exception");
            
    }
}

-(BOOL) curatorVerifier:(NSString *) curID{
    BOOL flag = false;
    for (int i = 0; i < 10; i++) {
        if([myCurator[i] getID] == curID){
            flag = true;
        }
    }
    return flag;
}
- (IBAction)addCouratorBT:(id)sender {
    NSString *curID = [_curTextBox text];
    NSString *curFirstName = [_curFnameTextBox text];
    NSString *curLastName = [_curLnameTextBox text];
    float curComm = [_curCommTextBox.text floatValue];
        
    NSString *message;
    if([curID length] != 5)
    {
        message = @"Error! Curator ID must be 5 digits";
    }
    else
    {
        if([self curatorVerifier:curID] == true)
        {
            message = @"Error! Curator ID already exists";
        }
        else
        {
            if([curFirstName length] + [curLastName length] > 40)
            {
                message = @"Error! Firstname + lastname must be 40 characters maximum";
            }
            else
            {
                Curator *curInstance = [[Curator alloc]  initcurID:curID initFN:curFirstName initLN:curLastName initcomm:curComm];
                myCurator[i_cur] = curInstance;
                i_cur++;
                message = @"Curator has been successfully added to the list";
                [self writeIntoCurators];
            }
        }
                
        
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message: message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];

    _curTextBox.text = nil;
    _curFnameTextBox.text = nil;
    _curLnameTextBox.text = nil;
    _curCommTextBox.text = nil;
}

- (void) writeIntoCurators{
    @try{
        NSURL *url = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/Curator.txt"];

        NSString *newFileContent;

        for (int i = 0; i < sizeof(myCurator); i++) {
            if(myCurator[i] == NULL){}
            else{
            newFileContent = [NSString stringWithFormat:@"%@", [myCurator[i] toString]];
            }
        }

        [newFileContent writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    @catch(NSException *ex){
        NSLog(@"%@", ex);
    }

}

- (void) readFromCurators{

    @try {
        NSURL *url = [NSURL fileURLWithPath:@"/Users/user220600/Downloads/CGS_GUI_F/CGS_GUI_F/Curator.txt"];
        NSString *fileContent = [NSString stringWithContentsOfURL: url encoding: NSUTF8StringEncoding error:nil];
        NSLog(@"fileContent: %@", fileContent);
    }
    @catch (NSException *ex) {
        NSLog(@"The name %@ and the reason %@ of the exception is", [ex name], [ex reason]);
    }
    @finally {
        NSLog(@"Drinking JF's coffee does not protect you against exception");
            
    }
}











- (IBAction)loginBT:(id)sender {
    
    NSString *user = [_userTextBox text];
    NSString *pass = [_passTextBox text];
        if ([user isEqual:@"admin"] && [pass isEqual:@"123"]) {
            ViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenuVC"];
                    [self presentViewController:monitorMenuViewController animated:NO completion:nil];
        }else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Credentials are incorrect!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
        }
    
}





-(void) setEstimate: (NSString*) artpID : (float) estimate
{
    for(int i = 0; i < 10; i++)
    {
        if([myArtPiece[i] getID] == artpID)
        {
            [myArtPiece[i] setEstimate:estimate];
        }
    }
}

-(void) setCommission: (NSString *) curatorID : (float) value : (float) estimate{
    float commission;
    commission = (estimate - value) * 0.25;
    for(int i = 0; i < 10; i++)
    {
        if([myCurator[i] getID] == curatorID)
        {
            [myCurator[i] setCommission:commission];
        }
    }
}

-(NSString*) getCuratorIDFromPieceID:(NSString *) artpID{
    NSString *curID;
    for(int i = 0; i < 10; i++){
        if([myArtPiece[i] getID] == artpID){
            curID = artpID;
        }
    }
    return curID;
}

-(void) changeStausToSold:(NSString *) artpID{
    for(int i = 0; i < 10; i++){
        if([myArtPiece[i] getID] == artpID){
            [myArtPiece[i] changeStatus:'S'];
        }
    }
}

-(float) checkValue:(NSString *) artpID{
    float value = 0.0;
    for(int i = 0; i < 10; i++){
        if([myArtPiece[i] getID] == artpID){
            value = [myArtPiece[i] getValue];
        }
    }
    return value;
}


-(BOOL) statusVerifier:(NSString *) artpID{
    BOOL flag = false;
    for(int i = 0; i < 10; i++){
        if([myArtPiece[i] getID] == artpID){
            if([myArtPiece[i] getStatus] == 'S'){
                flag = true;
            }
        }
    }
    return flag;
}
@end
