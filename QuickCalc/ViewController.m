//
//  ViewController.m
//  QuickCalc
//
//  Created by William Lee Mapp, III on 7/7/15.
//  Copyright (c) 2015 Studio Codeworks, Inc. All rights reserved.
//

#import "ViewController.h"

#define NONE        0
#define ADD         1
#define SUBTRACT    2
#define MULTIPLY    3
#define DIVIDE      4

@interface ViewController ()

@end

@implementation ViewController
@synthesize expressionTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // initialize states
    m_operation     = NONE;
    m_replaceValue  = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// operations
- (IBAction) addButtonTapped:(id)sender
{
    if(m_operation != NONE)
    {
        // the user entered in an expression, but
        // equals wasn't hit yet
        // trigger it ourselves then continue processing
        [self equalsButtonTapped:nil];
    }

    // capture the expression first
    // then update the state
    // this pattern follows for the rest of the mathematical functions
    [self setExpressionValue];
    m_operation     = ADD;
    m_replaceValue  = TRUE;
}

- (IBAction) clearButtonTapped:(id)sender
{
    // clear the states and express
    m_operation                 = NONE;
    m_replaceValue              = FALSE;
    expressionTextField.text    = @"0";
}

- (IBAction) decimalButtonTapped:(id)sender
{
    // check to see if there's a decimal there
    // if not add one
    if(![expressionTextField.text containsString:@"."])
    {
        NSString *text = [expressionTextField.text stringByAppendingString:@"."];
        expressionTextField.text = text;
    }
}

- (IBAction) divideButtonTapped:(id)sender
{
    if(m_operation != NONE)
    {
        // equals wasn't hit yet
        // trigger it ourselves then continue processing
        [self equalsButtonTapped:nil];
    }
    
    [self setExpressionValue];
    m_operation     = DIVIDE;
    m_replaceValue  = TRUE;
}

- (IBAction) equalsButtonTapped:(id)sender
{
    // set the first and second values
    [self setExpressionValue];
    // compute
    if(m_operation != NONE)
    {
        double result = 0.0;
        
        // check for potential divide by zero
        if(m_operation == DIVIDE && m_secondValue == 0.0)
        {
            // the user tried to divide by zero
            expressionTextField.text = @"NaN";
        }
        else
        {
            switch(m_operation)
            {
                case ADD:
                    result = m_firstValue + m_secondValue;
                    break;
                    
                case SUBTRACT:
                    result = m_firstValue - m_secondValue;
                    break;
                    
                case MULTIPLY:
                    result = m_firstValue * m_secondValue;
                    break;
                    
                case DIVIDE:
                    result = m_firstValue / m_secondValue;
                    break;
                    
                default:
                    break;
            }
            
            // set the display with the new value
            NSNumber *number = [NSNumber numberWithDouble:result];
            expressionTextField.text = [number stringValue];
            m_replaceValue  = TRUE;
            m_operation     = NONE;
        }
    }
}

- (IBAction) multiplyButtonTapped:(id)sender
{
    if(m_operation != NONE)
    {
        // the user entered in an expression, but
        // equals wasn't hit yet
        // trigger it ourselves then continue processing
        [self equalsButtonTapped:nil];
    }

    [self setExpressionValue];
    m_operation     = MULTIPLY;
    m_replaceValue  = TRUE;
}

- (IBAction) negateButtonTapped:(id)sender
{
    // either prepend or remove a beginning minus sign
    // then
    // flip the negated switch
    // do this using numerical ops
    
    if(expressionTextField.text.length > 0)
    {
        double value = [expressionTextField.text doubleValue];
        
        if(abs(value) > 0.0)
        {
            // flip the sign of the value
            value = -(value);
            // convert the number to a string
            NSNumber *number = [NSNumber numberWithDouble:value];
            expressionTextField.text = [number stringValue];
        }
    }    
}

- (IBAction) percentButtonTapped:(id)sender
{
    // take whatever is on the screen and divide it by 100
    // it doesn't matter if the first or second expression
    // is filled in, ops will fill in the appropriate value
    double dv = [expressionTextField.text doubleValue];
    dv = dv / 100.f;
    NSNumber *number = [NSNumber numberWithDouble:dv];
    expressionTextField.text = [number stringValue];
}

- (IBAction) subtractButtonTapped:(id)sender
{
    if(m_operation != NONE)
    {
        // the user entered in an expression, but
        // equals wasn't hit yet
        // trigger it ourselves then continue processing
        [self equalsButtonTapped:nil];
    }

    [self setExpressionValue];
    m_operation     = SUBTRACT;
    m_replaceValue  = TRUE;
}

// numbers
- (IBAction) oneButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"1"];
}

- (IBAction) twoButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"2"];
}

- (IBAction) threeButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"3"];
}

- (IBAction) fourButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"4"];
}

- (IBAction) fiveButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"5"];
}

- (IBAction) sixButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"6"];
}

- (IBAction) sevenButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"7"];
}

- (IBAction) eightButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"8"];
}

- (IBAction) nineButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"9"];
}

- (IBAction) zeroButtonTapped:(id)sender
{
    [self updateCalcDisplay:@"0"];
}

// helpers
- (BOOL) isZeroDisplayed
{
    BOOL result = FALSE;
    
    if(expressionTextField.text.length == 1)
    {
        if([expressionTextField.text compare:@"0"] == NSOrderedSame)
        {
            result = TRUE;
        }
    }
    
    return result;
}

- (void) setExpressionValue
{
    // set the first and second value in our expression
    // if the user hasn't tapped an operation button
    // set the first expression, else the second
    if(m_operation == NONE)
    {
        m_firstValue = [expressionTextField.text doubleValue];
    }
    else
    {
        m_secondValue = [expressionTextField.text doubleValue];
    }
}

- (void) updateCalcDisplay:(NSString *)value
{
    // check for zero, or potential division by zero by some fool
    if(m_operation == NONE)
    {
        if(m_replaceValue)
        {   // if the flag is set to replace what's on the screen do that here
            // flip the flag back
            expressionTextField.text = value;
            m_replaceValue = FALSE;
        }
        else if([self isZeroDisplayed] || [expressionTextField.text compare:@"NaN"] == NSOrderedSame)
        {
            // replace what's there
            expressionTextField.text = value;
        }
        else
        {
            // append what's there
            NSString *text = [expressionTextField.text stringByAppendingString:value];
            expressionTextField.text = text;
        }        
    }
    else
    {
        if(m_replaceValue)
        {
            expressionTextField.text = value;
            m_replaceValue = FALSE;
        }
        else
        {
            // append what's there
            NSString *text = [expressionTextField.text stringByAppendingString:value];
            expressionTextField.text = text;
        }
    }
}

@end