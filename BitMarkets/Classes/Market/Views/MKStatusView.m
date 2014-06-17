//
//  MKStatusView.m
//  BitMarkets
//
//  Created by Steve Dekorte on 6/12/14.
//  Copyright (c) 2014 voluntary.net. All rights reserved.
//

#import "MKStatusView.h"
#import "MKTransaction.h"
#import "MKPostView.h"

@implementation MKStatusView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _statusTextView   = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 30)];
        [_statusTextView setSelectable:NO];
        [_statusTextView setThemePath:@"steps/status/title"];
        [self addSubview:_statusTextView];
        
        _subtitleTextView = [[NavTextView alloc] initWithFrame:NSMakeRect(0, 0, 100, 30)];
        [_subtitleTextView setSelectable:NO];
        [_subtitleTextView setThemePath:@"steps/status/subtitle"];
        [self addSubview:_subtitleTextView];
        
        _buttonsView = [[NavColoredView alloc] initWithFrame:NSMakeRect(0, 0, 100, 30)];
        //_buttonsView.backgroundColor = [NSColor colorWithCalibratedWhite:.9 alpha:1.0];
        _buttonsView.backgroundColor = [NSColor whiteColor];
        [_buttonsView setAutoresizesSubviews:NO];
        
        //_buttonsView.backgroundColor = [NSColor clearColor];
        [self addSubview:_buttonsView];
    }
    
    return self;
}

- (MKTransaction *)transaction
{
    return (MKTransaction *)self.node;
}

- (void)syncFromNode
{
    _statusTextView.string   = self.transaction.statusTitle;
    _subtitleTextView.string = self.transaction.statusSubtitle ? self.transaction.statusSubtitle : @"";
    
    self.backgroundColor = [self.nodeTitleAttributes objectForKey:NSBackgroundColorAttributeName];
    [self setupButtons];
    [self layout];
}

- (void)setupButtons
{
    [_buttonsView removeAllSubviews];
    
    for (NavActionSlot *actionSlot in self.transaction.currentNode.navMirror.actionSlots)
    {
        [_buttonsView addSubview:actionSlot.slotView];
    }
    
    //NavRoundButtonView *button = _buttonsView.subviews.firstObject;
    
    //NSLog(@"button.x = %i", (int)button.x);
    [_buttonsView setAllSubviewToWidth:150];
    //[_buttonsView setAllSubviewToHeight:34];
    
    //NSLog(@"button.x = %i", (int)button.x);
    [_buttonsView stackSubviewsLeftToRightWithMargin:10];
    //NSLog(@"button.x = %i", (int)button.x);
    
    [_buttonsView setWidth:_buttonsView.maxXOfSubviews];
    //NSLog(@"_buttonsView.width = %i", (int)_buttonsView.width);
    //NSLog(@"button.x = %i", (int)button.x);
    
    [_buttonsView stackSubviewsLeftToRightWithMargin:10];
    
    //[_buttonsView setHeight:self.maxYOfSubviews];
    [_buttonsView setHeight:32];
    
    [self layout];
    //NSLog(@"button.x = %i", (int)button.x);
}

- (void)layout
{
    //[_statusTextView setX:[[MKPostView class] leftMargin]];
    [_statusTextView setX:MKPostView.leftMargin];
    [_statusTextView setWidth:self.width];
    [_statusTextView setY:self.height - _statusTextView.height - 30];
    
    [_subtitleTextView setX:_statusTextView.x];
    [_subtitleTextView setWidth:_statusTextView.width];
    [_subtitleTextView placeYBelow:_statusTextView margin:0.0];
    
    [_buttonsView setX:self.width - _buttonsView.width - 30];
    [_buttonsView centerYInSuperview];
}

- (NSDictionary *)nodeTitleAttributes
{
    return [[NavTheme sharedNavTheme] attributesDictForPath:@"steps/step"];
}


- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    [self drawHorizontalLineAtY:self.height];
    [self drawHorizontalLineAtY:0];
}

- (void)drawHorizontalLineAtY:(CGFloat)y
{
    [[NSColor colorWithCalibratedWhite:.7 alpha:1.0] set];
    
    [NSBezierPath setDefaultLineCapStyle:NSButtLineCapStyle];
    
    NSBezierPath *aPath = [NSBezierPath bezierPath];
    [aPath moveToPoint:NSMakePoint(0.0, y)];
    [aPath lineToPoint:NSMakePoint(self.width, y)];
    [aPath setLineCapStyle:NSSquareLineCapStyle];
    [aPath stroke];
}

@end
