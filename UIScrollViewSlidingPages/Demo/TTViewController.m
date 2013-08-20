//
//  TTViewController.m
//  UIScrollViewSlidingPages
//
//  Created by Thomas Thorpe on 27/03/2013.
//  Copyright (c) 2013 Thomas Thorpe. All rights reserved.
//

#import "TTViewController.h"
#import "TTScrollSlidingPagesController.h"
#import "TabOneViewController.h"
#import "TabTwoViewController.h"
#import "TTSlidingPage.h"
#import "TTSlidingPageTitle.h"

@interface TTViewController ()
    @property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@end

@implementation TTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //initial setup of the TTScrollSlidingPagesController. 
    self.slider = [[TTScrollSlidingPagesController alloc] init];
    
    //set properties to customiser the slider. Make sure you set these BEFORE you access any other properties on the slider, such as the view or the datasource. Best to do it immediately after calling the init method.
    //slider.titleScrollerHidden = YES;
    //slider.titleScrollerHeight = 100;
    self.slider.titleScrollerItemWidth = self.view.frame.size.width / 2;
    //self.slider.titleScrollerBackgroundColour = [UIColor darkGrayColor];
    self.slider.disableTitleScrollerShadow = YES;
    self.slider.disableUIPageControl = YES;
    //self.slider.titleScrollerTextColour = [UIColor grayColor];
    //self.slider.initialPageNumber = 1;
    //slider.pagingEnabled = NO;
    //self.slider.zoomOutAnimationDisabled = YES;
    self.slider.fixedTopView = YES;
    //self.slider.titleScrollerSelectedTextColour = [UIColor whiteColor];
    self.slider.selectedBarImage = [UIImage imageNamed:@"bar_selected"];
    
    //set the datasource.
    self.slider.dataSource = self;
    
    //add the slider's view to this view as a subview, and add the viewcontroller to this viewcontrollers child collection (so that it gets retained and stays in memory! And gets all relevant events in the view controller lifecycle)
    self.slider.view.frame = self.view.frame;
    [self.view addSubview:self.slider.view];
    [self addChildViewController:self.slider];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TTSlidingPagesDataSource methods
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 2; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    
    UIViewController *viewController;
    if (index % 2 == 0){ //just an example, alternating views between one example table view and another.
        viewController = [[TabOneViewController alloc] init];
    } else {
        viewController = [[TabTwoViewController alloc] init];
    }
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    if (index == 0){
        //use a image as the header for the first page
        //title= [[TTSlidingPageTitle alloc] initWithHeaderImage:[UIImage imageNamed:@"about-tomthorpelogo.png"]];
        title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Page 1"];
    } else {
        //all other pages just use a simple text header
        switch (index) {
            case 1:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Page 2"];
                break;
            case 2:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Another Page"];
                break;
            case 3:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"More Stuff"];
                break;
            case 4:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Another Page"];
                break;
            default:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
                break;
        }
        
    }
    return title;
}

////The below method in the datasource might get removed from the control some time in the future as it doesn't work that well with the headers if the width is small.
//-(int)widthForPageOnSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index
//{
//    if (index ==3){
//        return 130;
//    } else {
//        return self.view.frame.size.width;
//    }
//}

@end
