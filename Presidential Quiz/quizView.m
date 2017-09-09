//
//  quizView.m
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import "quizView.h"

@interface quizView ()

@end

@implementation quizView

- (void)viewDidLoad {

     [References blurView:blur];
     [References blurView:answerPanel];
    answerList = [[NSMutableArray alloc] initWithArray:[References listOfPresidents]];
    responseList = [[NSMutableArray alloc] init];
    currentSelection = [[NSMutableArray alloc] init];
    for (int a = 0; a < answerList.count; a++) {
        [responseList addObject:@"______________________"];
        [currentSelection addObject:[NSNumber numberWithInteger:1]];
    }
    [References tintUIButton:mistakeA color:[UIColor colorWithRed:0.70 green:0.13 blue:0.20 alpha:1.0]];
    [References tintUIButton:mistakeB color:[UIColor colorWithRed:0.70 green:0.13 blue:0.20 alpha:1.0]];[References tintUIButton:mistakeC color:[UIColor colorWithRed:0.70 green:0.13 blue:0.20 alpha:1.0]];
    
     [References cornerRadius:answerPanel radius:8.0f];
    [References cornerRadius:answerA radius:8.0f];
    [References cornerRadius:answerB radius:8.0f];
    [References cornerRadius:answerC radius:8.0f];
    [References cornerRadius:answerD radius:8.0f];
    [References cornerRadius:stop radius:8.0f];
    [References cornerRadius:timer radius:8.0f];
    [References cornerRadius:flag radius:10.0f];
    [References cornerRadius:currentScore radius:8.0f];
    [References lightCardShadow:shadow];
    [table reloadData];
    if ([_mode isEqualToString:@"Easy"]) {
        currentPresident = 0;
        currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
    } else {
        currentPresident = [self getRandomNumberBetween:0 to:(int)responseList.count];
        currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (currentPresident < 2) {
                [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            } else {
                [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(currentPresident-2) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
        });
    }

    [self nextPresident];
    currentTime = 0;
    quizTime = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(incrementTime)
                                                  userInfo:nil
                                                   repeats:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)incrementTime {
    currentTime++;
    dispatch_async(dispatch_get_main_queue(), ^{
            timer.text = [self timeFormatted:currentTime];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(void)nextPresident {
    answer = answerList[currentPresident];
    int correct;
    correct = [self getRandomNumberBetween:1 to:4];
    for (int a = 1; a < 5; a++) {
        if (a == correct) {
            UIButton *button = (UIButton*)[self.view viewWithTag:correct];
            [button setTitle:answer forState:UIControlStateNormal];
        } else {
            int random = 99;
            bool done = false;
            while (random != currentPresident && done == false) {
                random = (int)[self getRandomNumberBetween:0 to:(int)answerList.count-1];
                if (random == currentPresident) {
                    while (random == currentPresident) {
                        random = (int)[self getRandomNumberBetween:0 to:(int)answerList.count-1];
                    }
                } else {
                    bool foundMatch = false;
                    for (int b = 1; b < 5; b++) {
                        UIButton *button = (UIButton*)[self.view viewWithTag:b];
                        if ([button.titleLabel.text isEqualToString:answerList[random]]) {
                            foundMatch = true;
                        }
                    }
                    if (foundMatch == true) {
                        done = false;
                    } else {
                        UIButton *button = (UIButton*)[self.view viewWithTag:a];
                        [button setTitle:answerList[random] forState:UIControlStateNormal];
                        random = currentPresident;
                        done = true;
                    }
                }
            }
        }
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return answerList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}

- (IBAction)checkAnswer:(id)sender {
    answerResult = [[UINotificationFeedbackGenerator alloc] init];
    [answerResult prepare];
    UIButton *newAnswer = (UIButton*)sender;
    if ([newAnswer.titleLabel.text isEqualToString:answer]) {
        int answers = 0;
        for (int a = 0; a < responseList.count ; a++) {
            if ([responseList[a] isEqualToString:@"______________________"]) {
                nil;
            } else {
                answers++;
            }
        }
        if (answers == responseList.count) {
            [References fullScreenToast:@"You Did It!" inView:self withSuccess:YES andClose:YES];
        } else {
            [References fadeIn:nice];
            [answerResult notificationOccurred:UINotificationFeedbackTypeSuccess];
            responseList[currentPresident] = answer;
            currentSelection[currentPresident] = [NSNumber numberWithInteger:1];
            if ([_mode isEqualToString:@"Easy"]) {
                if (currentPresident == responseList.count-1) {
                    for (int a = 0; a < responseList.count; a++) {
                        if ([responseList[a] isEqualToString:@"______________________"]) {
                            currentPresident = a;
                            currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
                            break;
                        }
                    }
                } else {
                    currentPresident++;
                    currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
                }
            } else {
                bool nextUp = false;
                while (nextUp == false) {
                    currentPresident = [self getRandomNumberBetween:0 to:(int)responseList.count];
                    currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
                    if ([responseList[currentPresident] isEqualToString:@"______________________"]) {
                        nextUp = true;
                    }
                }
            }
            [self nextPresident];
            [table reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (currentPresident < 2) {
                    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                } else {
                    [table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(currentPresident-2) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         1 * NSEC_PER_SEC),
                           dispatch_get_main_queue(),
                           ^{
                               [References fadeOut:nice];
                           });
            int currentScoreInt = 0;
            for (int a = 0; a < responseList.count; a++) {
                if ([responseList[a] isEqualToString:@"______________________"]) {
                    nil;
                } else {
                    currentScoreInt++;
                }
            }
            currentScore.text = [NSString stringWithFormat:@"%i/%lu Complete",currentScoreInt,(unsigned long)responseList.count];
        }
        
    } else {
        mistakes++;
        UILabel *blurry = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [References screenWidth], [References screenHeight])];
        [References lightblurView:blurry];
        blurry.alpha = 0;
        [self.view addSubview:blurry];
        [self.view bringSubviewToFront:blurry];
        [self.view bringSubviewToFront:mistakeA];
        [self.view bringSubviewToFront:mistakeB];
        [self.view bringSubviewToFront:mistakeC];
        if (mistakes == 1) {
            [References fadeIn:blurry];
            [References fadeIn:mistakeA];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         1 * NSEC_PER_SEC),
                           dispatch_get_main_queue(),
                           ^{
                               [References fadeOut:blurry];
                               [References fadeOut:mistakeA];
                           });
        } else if (mistakes == 2) {
            [References fadeIn:blurry];
            [References fadeIn:mistakeA];
            [References fadeIn:mistakeB];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         1 * NSEC_PER_SEC),
                           dispatch_get_main_queue(),
                           ^{
                               [References fadeOut:blurry];
                               [References fadeOut:mistakeA];
                               [References fadeOut:mistakeB];
                           });
        } else if (mistakes == 3) {
            [References fadeIn:blurry];
            [References fadeIn:mistakeA];
            [References fadeIn:mistakeB];
             [References fadeIn:mistakeC];
            int currentScoreInt = 0;
            for (int a = 0; a < responseList.count; a++) {
                if ([responseList[a] isEqualToString:@"______________________"]) {
                    nil;
                } else {
                    currentScoreInt++;
                }
            }
            NSString *finalScore = [NSString stringWithFormat:@"%i/%lu",currentScoreInt,(unsigned long)responseList.count];
            if ([_mode isEqualToString:@"Easy"]) {
                int pastScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"easyScore"];
                [[NSUserDefaults standardUserDefaults] setObject:finalScore forKey:@"easyModeScore"];
                [[NSUserDefaults standardUserDefaults] setObject:[self timeFormatted:currentTime] forKey:@"easyModeTime"];
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:finalScore forKey:@"hardModeScore"];
                [[NSUserDefaults standardUserDefaults] setObject:[self timeFormatted:currentTime] forKey:@"hardModeTime"];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         1 * NSEC_PER_SEC),
                           dispatch_get_main_queue(),
                           ^{
                               [self dismissViewControllerAnimated:YES completion:nil];
                           });
        }
        [answerResult notificationOccurred:UINotificationFeedbackTypeError];
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"studyCell";
    
    studyCell *cell = (studyCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"studyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (currentSelection[indexPath.row] == [NSNumber numberWithInteger:2]) {
        cell.back.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];
    } else {
        cell.back.backgroundColor = [UIColor whiteColor];
    }
    if ([responseList[indexPath.row] isEqualToString:@"______________________"]) {
        [cell.name setTextColor:[UIColor clearColor]];
    } else {
        [cell.name setTextColor:[UIColor blackColor]];
    }
    cell.name.text = responseList[indexPath.row];
    cell.number.text = [NSString stringWithFormat:@"%@ PRESIDENT",[self addSuffixToNumber:(int)indexPath.row+1]];
    return cell;
}

-(NSString *) addSuffixToNumber:(int) number
{
    NSString *suffix;
    int ones = number % 10;
    int tens = (number/10) % 10;
    
    if (tens ==1) {
        suffix = @"TH";
    } else if (ones ==1){
        suffix = @"ST";
    } else if (ones ==2){
        suffix = @"ND";
    } else if (ones ==3){
        suffix = @"RD";
    } else {
        suffix = @"TH";
    }
    
    NSString * completeAsString = [NSString stringWithFormat:@"%d%@", number, suffix];
    return completeAsString;
}

- (NSString *)timeFormatted:(int)totalSeconds{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_mode isEqualToString:@"Easy"]) {
        currentSelection[currentPresident] = [NSNumber numberWithInteger:1];
        currentPresident = (int)indexPath.row;
        currentSelection[currentPresident] = [NSNumber numberWithInteger:2];
        [self nextPresident];
        [table reloadData];
    } else {
        answerResult = [[UINotificationFeedbackGenerator alloc] init];
        [answerResult prepare];
        [answerResult notificationOccurred:UINotificationFeedbackTypeWarning];
    }

}
@end
