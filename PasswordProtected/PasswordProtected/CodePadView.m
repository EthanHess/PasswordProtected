//
//  CodePadView.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "CodePadView.h"

@interface CodePadView()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSMutableArray *topViewArray;

@property (nonatomic, strong) UIStackView *pinStack;

@property (nonatomic, strong) NSMutableString *code;

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation CodePadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        if (self.code == nil) {
            self.code = [[NSMutableString alloc]init];
        }
        self.backgroundColor = [UIColor darkTextColor];
    }
    return self;
}

- (void)addSubviews {
    if (self.buttonArray == nil) {
        self.buttonArray = [[NSMutableArray alloc]init];
    }
    
    [self.buttonArray removeAllObjects];
    
    for (int i = 0; i < 10; i++) {
        [self createButtonAtIndex:i];
    }
    
    [self topViews];
    [self deleteButtonCreate];
}

- (void)deleteButtonCreate {
    
    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
    [self.deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteChar) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.deleteButton];
}

- (void)topViews {
    
    CGFloat stackX = self.frame.size.width / 6;
    CGFloat yC = (self.frame.size.height / 4) - 100;
    
    self.pinStack = [[UIStackView alloc]initWithFrame:CGRectMake(stackX, yC, self.frame.size.width - (stackX * 2), 60)];
    self.pinStack.axis = UILayoutConstraintAxisHorizontal;
    self.pinStack.distribution = UIStackViewDistributionEqualSpacing;
    self.pinStack.alignment = UIStackViewAlignmentTop;
    self.pinStack.spacing = self.pinStack.frame.size.width / 13;
    
    CGFloat viewX = self.pinStack.frame.size.width / 13;
    
    if (self.topViewArray == nil) {
        self.topViewArray = [[NSMutableArray alloc]init];
    }
    
    [self.topViewArray removeAllObjects];
    
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((viewX * (i * 2)) + viewX, 5, viewX, viewX)];
        view.tag = i;
        view.layer.cornerRadius = viewX / 2;
        view.layer.borderColor = [[UIColor whiteColor]CGColor];
        view.layer.borderWidth = 1;
        view.layer.masksToBounds = YES;
        view.backgroundColor = [UIColor blackColor];
        [self.topViewArray addObject:view];
        [self.pinStack addSubview:view];
    }
    
    [self addSubview:self.pinStack];
}

- (void)createButtonAtIndex:(int)index {
    
    if (index >= 0 && index < 3) {
        [self firstRow:index];
    }
    if (index > 2 && index < 6) {
        [self secondRow:index];
    }
    if (index > 5 && index < 9) {
        [self thirdRow:index];
    }
    if (index > 8) {
        //add last one "0"
        [self lastRow:index];
    }
}

- (void)firstRow:(int)index {
    
    CGFloat width = self.frame.size.width / 6;
    CGFloat yC = self.frame.size.height / 5;
    CGFloat xCoordOperand = width * (index + 1);
    CGFloat indices = (index * (width / 2)) + 1;
    CGFloat xC = xCoordOperand + indices;
    
    UIButton *theButton = [[UIButton alloc]initWithFrame:CGRectMake(xC, yC, width, width)];
    theButton.backgroundColor = [UIColor whiteColor];
    [theButton setTitle:[NSString stringWithFormat:@"%i", (index + 1)]  forState:UIControlStateNormal];
    theButton.tag = index;
    theButton.layer.cornerRadius = width / 2;
    theButton.layer.masksToBounds = YES;
    [theButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonTappedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:theButton];
    [self.buttonArray addObject:theButton]; 
}

- (void)secondRow:(int)index {
    
    CGFloat width = self.frame.size.width / 6;
    CGFloat yC = (self.frame.size.height / 5) + (width * 1.5);
    CGFloat xCoordOperand = width * ((index - 4.5) + 1);
    CGFloat indices = (index * (width / 2)) + 1;
    CGFloat xC = xCoordOperand + indices;
    
    UIButton *theButton = [[UIButton alloc]initWithFrame:CGRectMake(xC, yC, width, width)];
    theButton.backgroundColor = [UIColor whiteColor];
    [theButton setTitle:[NSString stringWithFormat:@"%i", (index + 1)]  forState:UIControlStateNormal];
    theButton.tag = index;
    theButton.layer.cornerRadius = width / 2;
    theButton.layer.masksToBounds = YES;
    [theButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonTappedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:theButton];
    [self.buttonArray addObject:theButton];
}

- (void)thirdRow:(int)index {
    
    CGFloat width = self.frame.size.width / 6;
    CGFloat yC = (self.frame.size.height / 5) + (width * 3);
    CGFloat xCoordOperand = width * ((index - 9) + 1);
    CGFloat indices = (index * (width / 2)) + 1;
    CGFloat xC = xCoordOperand + indices;
    
    UIButton *theButton = [[UIButton alloc]initWithFrame:CGRectMake(xC, yC, width, width)];
    theButton.backgroundColor = [UIColor whiteColor];
    [theButton setTitle:[NSString stringWithFormat:@"%i", (index + 1)]  forState:UIControlStateNormal];
    theButton.tag = index;
    theButton.layer.cornerRadius = width / 2;
    theButton.layer.masksToBounds = YES;
    [theButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonTappedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:theButton];
    [self.buttonArray addObject:theButton];
}

- (void)lastRow:(int)index {
    
    CGFloat width = self.frame.size.width / 6;
    CGFloat yC = (self.frame.size.height / 5) + (width * 4.5);
    CGFloat xCoord = (self.frame.size.width / 2) - (width / 2);
    
    UIButton *theButton = [[UIButton alloc]initWithFrame:CGRectMake(xCoord, yC, width, width)];
    theButton.backgroundColor = [UIColor whiteColor];
    [theButton setTitle:[NSString stringWithFormat:@"%i", (index + 1)]  forState:UIControlStateNormal];
    theButton.tag = index;
    theButton.layer.cornerRadius = width / 2;
    theButton.layer.masksToBounds = YES;
    [theButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [theButton addTarget:self action:@selector(buttonTappedWithSender:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:theButton];
    [self.buttonArray addObject:theButton];
    
    [self setSelectedForButton];
}

- (void)setSelectedForButton {
    for (UIButton *button in self.buttonArray) {
        [button setBackgroundImage:[UIImage imageNamed:@"graySQ"] forState:UIControlStateSelected | UIControlStateHighlighted];
    }
}

- (void)buttonTappedWithSender:(UIButton *)sender {
    
    NSInteger numberToAdd = sender.tag + 1;
    if (numberToAdd == 10) {
        numberToAdd = 0; //last one is 0 not 10
    }
    
    NSString *strVal = [NSString stringWithFormat:@"%li", (long)numberToAdd];
    
    if (self.code.length < 6) {
        [self.code appendString:strVal];
        
        UIView *viewAtIndex = self.topViewArray[self.code.length - 1];
        viewAtIndex.backgroundColor = [UIColor whiteColor];
        
        if (self.code.length == 6) {
            if (self.initialLoad == NO) {
                if ([self.code isEqualToString:[self defaultsReference]]) {
                    [self handleProceed];
                }
            } else {
                [self writeToDefaultsOnInitialLoad:self.code];
                [self handleProceed];
            }
        }
    }
}

- (NSString *)defaultsReference {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Code"];
}

- (void)writeToDefaultsOnInitialLoad:(NSString *)string {
    [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"Code"];
}

- (void)handleProceed {
    [self.delegate codeIsValid];
}

- (void)deleteChar {
    if (self.code.length != 0 && self.code.length <= 6) {
        self.code = [NSMutableString stringWithString:[self.code substringToIndex:[self.code length] - 1]];
        if (self.code.length < 7) {
            UIView *viewToDarken = self.topViewArray[self.code.length];
            viewToDarken.backgroundColor = [UIColor blackColor];
        }
    }
}

@end
