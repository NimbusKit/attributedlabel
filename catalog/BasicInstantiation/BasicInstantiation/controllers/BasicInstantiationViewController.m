/**
 Copyright (c) 2011-present, NimbusKit. All rights reserved.

 This source code is licensed under the BSD-style license found in the LICENSE file in the root
 directory of this source tree and at the http://nimbuskit.info/license url. An additional grant of
 patent rights can be found in the PATENTS file in the same directory and url.
 */

#import "BasicInstantiationViewController.h"

// Using the library import, rather than directly importing, has some nice advantages:
//
// - We don't have to import any dependent framework headers.
// - Any file movement within the library happens transparently to us.
//
#import "NimbusKitAttributedLabel.h"

@interface BasicInstantiationViewController () <NIAttributedLabelDelegate>
@end

@implementation BasicInstantiationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    self.title = @"Basic Instantiation";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Standard instantiation
  {
    NIAttributedLabel* label = [NIAttributedLabel new];
    label.text = @"NimbusKit 2.0";

    // Standard style properties immediately apply to the label as a whole.
    label.font = [UIFont systemFontOfSize:24];

    // NIAttributedLabel provides a number of convenience methods to modify attributes for ranges of
    // the label's text.
    [label setFont:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(0, @"Nimbus".length)];
    [label setTextColor:[UIColor orangeColor] range:NSMakeRange(0, @"NimbusKit".length)];

    label.frame = (CGRect){CGPointMake(20, 50), CGSizeZero};

    [label sizeToFit];

    [self.view addSubview:label];
  }

  // Inline images
  {
    NIAttributedLabel* label = [NIAttributedLabel new];
    label.text = @"NimbusKit 2.0";
    label.font = [UIFont systemFontOfSize:24];

    [label insertImage:[UIImage imageNamed:@"AppIcon60x60"] atIndex:@"NimbusKit".length
               margins:UIEdgeInsetsZero verticalTextAlignment:NIVerticalTextAlignmentMiddle];

    label.frame = (CGRect){CGPointMake(20, 80), CGSizeZero};

    [label sizeToFit];

    [self.view addSubview:label];
  }

  // Links
  {
    NIAttributedLabel* label = [NIAttributedLabel new];
    label.text = @"NimbusKit 2.0";
    label.font = [UIFont systemFontOfSize:24];

    [label addLink:[NSURL URLWithString:@"http://nimbuskit.info"] range:NSMakeRange(0, label.text.length)];
    label.delegate = self;

    label.frame = (CGRect){CGPointMake(20, 150), CGSizeZero};

    [label sizeToFit];

    [self.view addSubview:label];
  }
}

#pragma mark - NIAttributedLabelDelegate

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
  if (result.resultType == NSTextCheckingTypeLink) {
    [[UIApplication sharedApplication] openURL:result.URL];
  }
}

@end
