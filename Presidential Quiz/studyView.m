//
//  studyView.m
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import "studyView.h"

@interface studyView ()

@end

@implementation studyView

- (void)viewDidLoad {
    blurVisible = false;
    [References blurView:blur];
    presidents = [References listOfPresidents];
    [table reloadData];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.name.text = presidents[indexPath.row];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (scrollView.contentOffset.y > 20) {
        if (blurVisible == false) {
            [References fadeIn:blur];
            blurVisible = true;
        }
    } else if (scrollView.contentOffset.y < 20) {
        if (blurVisible == true) {
            [References fadeOut:blur];
            blurVisible = false;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    table.frame = CGRectMake(0, table.frame.origin.y, [References screenWidth], 61*presidents.count);
    scroll.contentSize = CGSizeMake([References screenWidth], table.frame.origin.y+table.frame.size.height);
    return presidents.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}
@end
