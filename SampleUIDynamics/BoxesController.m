//
//  BoxesController.m
//  SampleUIDynamics
//
//  Created by Peter Chen on 11/22/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "BoxesController.h"

@interface BoxesController ()

@property (nonatomic, strong) UIView *box1;
@property (nonatomic, strong) UIView *box2;
@property (nonatomic, strong) UIView *box3;
@property (nonatomic, strong) UISnapBehavior *snap;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation BoxesController

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
    
    self.title = @"Boxes";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.box1 = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    self.box1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.box1];
    
    self.box2 = [[UIView alloc] initWithFrame:CGRectMake(150, 150, 70, 70)];
    self.box2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.box2];
    
    self.box3 = [[UIView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    self.box3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.box3];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIButton *startAnimationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startAnimationButton.frame = CGRectMake(50, 200, 220, 44);
    [startAnimationButton setTitle:@"Animate" forState:UIControlStateNormal];
    [startAnimationButton addTarget:self action:@selector(_startAnimationButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startAnimationButton];
}

- (void)_startAnimationButtonTapped {
    [self dynamicsStep1];
    [self performSelector:@selector(dynamicsStep2) withObject:nil afterDelay:2];
}

- (void)dynamicsStep1 {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[ self.box1, self.box2 ]];
    gravity.gravityDirection = CGVectorMake(0, 1);
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[ self.box1, self.box2 ]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UICollisionBehavior *collisionBoundaries = [[UICollisionBehavior alloc] initWithItems:@[ self.box3 ]];
    collisionBoundaries.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBoundaries];
    
    /*
     UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.box3 attachedToItem:self.box1];
     attachment.damping = 10;
     attachment.frequency = 100;
     [self.animator addBehavior:attachment];
     */
    
    self.snap = [[UISnapBehavior alloc] initWithItem:self.box3 snapToPoint:CGPointMake(50, 50)];
    self.snap.damping = 0.7;
    [self.animator addBehavior:self.snap];
}

- (void)dynamicsStep2 {
    [self.animator removeBehavior:self.snap];
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[ self.box2, self.box3 ] mode:UIPushBehaviorModeContinuous];
    push.pushDirection = CGVectorMake(2, 0);
    [self.animator addBehavior:push];
}

@end
