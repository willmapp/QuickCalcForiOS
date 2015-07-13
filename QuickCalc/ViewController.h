//
//  ViewController.h
//  QuickCalc
//
//  Created by William Lee Mapp, III on 7/7/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    BOOL    m_replaceValue;
    int     m_operation;
    double  m_firstValue;
    double  m_secondValue;
}

@property (nonatomic, strong) IBOutlet UITextField  *expressionTextField;

// operations
- (IBAction) addButtonTapped:(id)sender;
- (IBAction) clearButtonTapped:(id)sender;
- (IBAction) decimalButtonTapped:(id)sender;
- (IBAction) divideButtonTapped:(id)sender;
- (IBAction) equalsButtonTapped:(id)sender;
- (IBAction) multiplyButtonTapped:(id)sender;
- (IBAction) negateButtonTapped:(id)sender;
- (IBAction) percentButtonTapped:(id)sender;
- (IBAction) subtractButtonTapped:(id)sender;

// numbers
- (IBAction) oneButtonTapped:(id)sender;
- (IBAction) twoButtonTapped:(id)sender;
- (IBAction) threeButtonTapped:(id)sender;
- (IBAction) fourButtonTapped:(id)sender;
- (IBAction) fiveButtonTapped:(id)sender;
- (IBAction) sixButtonTapped:(id)sender;
- (IBAction) sevenButtonTapped:(id)sender;
- (IBAction) eightButtonTapped:(id)sender;
- (IBAction) nineButtonTapped:(id)sender;
- (IBAction) zeroButtonTapped:(id)sender;

// helpers
- (BOOL) isZeroDisplayed;
- (void) setExpressionValue;
- (void) updateCalcDisplay:(NSString*)value;

@end

