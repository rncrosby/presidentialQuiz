//
//  quizView.h
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "References.h"
#import "studyCell.h"

@interface quizView : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    UINotificationFeedbackGenerator *answerResult;
    NSMutableArray *answerList,*responseList,*currentSelection;
    NSString *answer;
    int currentPresident, currentTime, mistakes;
    NSTimer *quizTime;
    __weak IBOutlet UIButton *answerA;
    __weak IBOutlet UIButton *answerB;
    __weak IBOutlet UIButton *answerC;
    __weak IBOutlet UIButton *answerD;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *timer;
    __weak IBOutlet UIButton *stop;
    __weak IBOutlet UILabel *blur;
    __weak IBOutlet UILabel *currentScore;
    __weak IBOutlet UILabel *answerPanel;
    __weak IBOutlet UIScrollView *scroll;
    __weak IBOutlet UILabel *shadow;
    __weak IBOutlet UIImageView *flag;
    __weak IBOutlet UIProgressView *progressView;
    __weak IBOutlet UIButton *mistakeA;
    __weak IBOutlet UIButton *mistakeB;
    __weak IBOutlet UIButton *mistakeC;
    __weak IBOutlet UILabel *nice;
}
@property (nonatomic, retain) NSString *mode;
- (IBAction)checkAnswer:(id)sender;
- (IBAction)goBack:(id)sender;

@end
