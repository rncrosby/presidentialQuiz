//
//  homeView.h
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "References.h"
#import "quizView.h"

@interface homeView : UIViewController {
UIView *bgVideo;
    __weak IBOutlet UIButton *startQuiz;
    __weak IBOutlet UISegmentedControl *currentMode;
    __weak IBOutlet UILabel *blur;
    
    __weak IBOutlet UILabel *easyModeScore;
    __weak IBOutlet UILabel *easyModeTime;
    __weak IBOutlet UILabel *hardModeScore;
    __weak IBOutlet UILabel *hardModeTime;
    
}
- (IBAction)startQuiz:(id)sender;
@property (nonatomic, strong) AVPlayer *avplayer;
@end
