//
//  homeView.m
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import "homeView.h"

@interface homeView ()

@end

@implementation homeView

-(void)viewDidAppear:(BOOL)animated{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"easyModeScore"]) {
        easyModeScore.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"easyModeScore"];
        easyModeTime.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"easyModeTime"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hardModeScore"]) {
        hardModeScore.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hardModeScore"];
        hardModeTime.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"hardModeTime"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [References blurView:blur];
    [super viewDidLoad];
    [References cornerRadius:startQuiz radius:8.0f];
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    bgVideo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [References screenWidth], [References screenHeight])];
    bgVideo.alpha = 0.5;
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    avPlayerItem.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithmVarispeed;
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:bgVideo.frame];
    [bgVideo.layer addSublayer:avPlayerLayer];
    [self.view addSubview:bgVideo];
    [self.view sendSubviewToBack:bgVideo];
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    // Create confetti view
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                            target:self
                                       selector:@selector(fadeIn)
                                              userInfo:nil
                                               repeats:NO];
    // Do any additional setup after loading the view.
}

-(void)fadeIn {
    //[References fadeIn:blur];
    
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero completionHandler:nil];
    [self.avplayer play];
}

- (void)playerStartPlaying
{
    [self.avplayer play];
}



- (IBAction)startQuiz:(id)sender {
    if (currentMode.selectedSegmentIndex == 0) {
        // easy
        quizView *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"quizView"];
        viewController.mode = @"Easy";
        [self presentViewController:viewController animated:YES completion:nil];
    } else {
        // hard
        quizView *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"quizView"];
        viewController.mode = @"Hard";
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
@end
