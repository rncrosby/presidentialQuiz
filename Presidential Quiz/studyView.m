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
    presidents = [[NSArray alloc] initWithObjects:
                  @"George Washington",
                  @"John Adams",
                  @"Thomas Jefferson",
                  @"James Madison",
                  @"James Monroe",
                  @"John Quincey Adams",
                  @"Andrew Jackson",
                  @"Martin Van Buren",
                  @"William H. Harrison",
                  @"John Tyler",
                  @"James K. Polk",
                  @"Zachary Taylor",
                  @"Millard Fillmore",
                  @"Franklin Pierce",
                  @"James Buchanan",
                  @"Abraham Lincoln",
                  @"Andrew Johnson",
                  @"Ulysses S. Grant",
                  @"Rutherford B. Hayes",
                  @"James A. Garfield",
                  @"Chester A. Arthur",
                  @"Grover Cleveland",
                  @"William McKinley",
                  @"Theodore Roosevelt",
                  @"William Howard Taft",
                  @"Woodrow Wilson",
                  @"Warren G. Harding",
                  @"Calvin Coolidge",
                  @"Herbert Hoover",
                  @"Franklin D. Roosevelt",
                  @"Harry S. Truman",
                  @"Dwight D. Eisenhower",
                  @"John F. Kennedy",
                  @"Lyndon B. Johnson",
                  @"Richard Nixon",
                  @"Gerald Ford",
                  @"Jimmy Carter",
                  @"Ronald Reagan",
                  @"George H. W. Bush",
                  @"Bill Clinton",
                  @"George W. Bush",
                  @"Barack Obama",
                  @"Donald Trump", nil];
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
    cell.number.text = [NSString stringWithFormat:@"%li PRESIDENT",indexPath.row+1];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (scrollView.contentOffset.y > 30) {
        if (blurVisible == false) {
            [References fadeIn:blur];
            blurVisible = true;
        }
    } else if (scrollView.contentOffset.y < 30) {
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
