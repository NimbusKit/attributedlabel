<!--dox @defgroup NimbusAttributedLabel NimbusKit Attributed Label -->

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/banner.gif "Attributed Label")

<div id="github" feature="attributedlabel"></div>

A UILabel substitute with data detectors, links, inline images, and Core Text attributes available right out of the box.

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample1.png "A mashup of possible label styles")

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabel_inlineimages.png "Inline images")

iOS 6 introduced supported for attributed text via `attributedText` but it still lacks several significant features that NimbusKit provides:

- Links, both explicit and implicitly via data detection.
- Inline images.
- Adopting any existing UILabel styles when the text is changed.
- Convenience methods for modifying substrings of the label.

If you do not need any of these features then you should consider simply using UILabel.

Adding it to your App
---------------------

Drag all of the files from the `src` directory into your app and then import the library header.

```objc
#import "NimbusKitAttributedLabel.h"
```

If you would like to use the internal helper methods on `NSMutableAttributedString`, import:

```objc
#import "NSMutableAttributedString+NimbusKitAttributedLabel.h"
```

This category header is not included in the library header.

Using NIAttributedLabel
=======================

In general using an NIAttributedLabel is similar to using a UILabel. This does not mean, however,that you should start using NIAttributedLabel everywhere that you can. Notably, it takes significantly more time to create and render an NIAttributedLabel than to create and render a corresponding UILabel, and especially compared to rendering the text manually. NIAttributedLabel is designed as a convenience, so take that into account when designing your apps - convenience comes at a cost!

Creating a Label in Code
------------------------

NIAttributedLabel is a subclass of UILabel. When text is assigned to the label, all of the label's style properties are applied to the string in its entirety.

```objc
NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectZero];

// The internal NSAttributedString will apply all of UILabel's style attributes when
// we assign text.
label.text = @"Nimbus";

[label sizeToFit];

[view addSubview:label];
```

Creating a Label in Interface Builder
-------------------------------------

You can use an attributed label within Interface Builder by creating a \c UILabel and changing its class to NIAttributedLabel. This will allow you to set standard UILabel styles that apply to the entire string. If you need to style specific parts of the string then this must be done in code.

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelIB.png "Configuring an Attributed Label in Interface Builder")

Features Overview
=================

- Automatic link detection using data detectors
- Link attributes
- Explicit links
- Inline images
- Underlining
- Justifying paragraphs
- Stroking
- Kerning
- Setting rich text styles at specific ranges

Links
-----

### Automatic Link Detection

Automatic link detection is provided via <a href="https://developer.apple.com/library/mac/#documentation/Foundation/Reference/NSDataDetector_Class/Reference/Reference.html">NSDataDetector</a>.

Data detection is off by default and can be enabled by setting NIAttributedLabel::autoDetectLinks to YES. You may configure the types of data that are detected by modifying the NIAttributedLabel::dataDetectorTypes property. By default only urls are detected.

@attention NIAttributedLabel is not designed to detect html anchor tags (i.e. &lt;a>). If you would like to attach a URL to a given range of text you must use NIAttributedLabel::addLink:range:. You may add links to the attributed string using the attribute NIAttributedLabelLinkAttributeName. The NIAttributedLabelLinkAttributeName value must be an instance of NSTextCheckingResult.

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabel_autoDetectLinksOff.png "Before enabling autoDetectLinks")

```objc
// Enable link detection on the label.
myLabel.autoDetectLinks = YES;
```

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabel_autoDetectLinksOn.png "After enabling autoDetectLinks")

Enabling automatic link detection will automatically enable user interation with the label view
so that the user can tap the detected links.

### Link Attributes

Detected links will use NIAttributedLabel::linkColor and NIAttributedLabel::highlightedLinkBackgroundColor to differentiate themselves from standard text. `linkColor` is the text color of any link, while `highlightedLinkBackgroundColor` is the color of the background frame drawn around the link when it is tapped. You can easily add underlines to links by enabling NIAttributedLabel::linksHaveUnderlines. You can customize link attributes in more detail by directly modifying the NIAttributedLabel::attributesForLinks property.

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelLinkAttributes.png "Link attributes")

#### A Note on Performance

Automatic link detection is expensive. You can choose to defer automatic link detection by enabling NIAttributedLabel::deferLinkDetection. This will move the link detection to a separate background thread. Once the links have been detected the label will be redrawn.

### Handling Taps on Links

The NIAttributedLabelDelegate protocol allows you to process events fired by the the user tapping a link. The protocol methods provide the tap point as well as the data pertaining to the tapped link.

```objc
- (void)attributedLabel:(NIAttributedLabel)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult)result atPoint:(CGPoint)point {
  [[UIApplication sharedApplication] openURL:result.URL];
}
```

### Explicit Links

Links can be added explicitly using NIAttributedLabel::addLink:range:.

```objc
// Add a link to the string 'nimbus' in myLabel.
[myLabel addLink:[NSURL URLWithString:@"nimbus://custom/url"]
           range:[myLabel.text rangeOfString:@"nimbus"]];
```

Inline Images
-------------

Inline images may be inserted using the `-insertImage:atIndex:` family of methods.

```objc
NIAttributedLabel* label = [NIAttributedLabel new];
label.text = @"NimbusKit 2.0";
label.font = [UIFont systemFontOfSize:24];

[label insertImage:[UIImage imageNamed:@"AppIcon60x60"] atIndex:@"NimbusKit".length
           margins:UIEdgeInsetsZero verticalTextAlignment:NIVerticalTextAlignmentMiddle];

label.frame = (CGRect){CGPointMake(20, 80), CGSizeZero};

[label sizeToFit];

[self.view addSubview:label];
```

Generates the following output:

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample6.png "Inline Images")

Modifying Style Attributes
--------------------------

### Underlining Text

To underline an entire label:

```objc
// Underline the whole label with a single line.
myLabel.underlineStyle = kCTUnderlineStyleSingle;
```

Underline modifiers can also be added:

```objc
// Underline the whole label with a dash dot single line.
myLabel.underlineStyle = kCTUnderlineStyleSingle;
myLabel.underlineStyleModifier = kCTUnderlinePatternDashDot;
```

Underline styles and modifiers can be mixed to create the desired effect, which is shown in the following screenshot:

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample2.png "Underline styles")

   @remarks Underline style kCTUnderlineStyleThick does not draw a thicker line.

### Justifying Paragraphs

NIAttributedLabel supports justified text using UITextAlignmentJustify.

```objc
 myLabel.textAlignment = UITextAlignmentJustify;
```

### Stroking Text

```objc
myLabel.strokeWidth = 3.0;
myLabel.strokeColor = [UIColor blackColor];
```

A positive stroke width will render only the stroke.

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample3.png "Black stroke of 3.0")

A negative number will fill the stroke with textColor:

```objc
myLabel.strokeWidth = -3.0;
myLabel.strokeColor = [UIColor blackColor];
```

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample4.png "Black stroke of -3.0")


### Kerning Text

Kerning is the space between characters in points. A positive kern will increase the space
between letters. Correspondingly a negative number will decrease the space.

```objc
myLabel.textKern = -6.0;
```

![](https://github.com/NimbusKit/attributedlabel/raw/master/docs/gfx/NIAttributedLabelExample5.png "Text kern of -6.0")


### Modifying Style at Specific Ranges

All styles that can be added to the whole label (as well as default UILabel styles like font and
text color) can be added to just a range of text.

```objc
[myLabel setTextColor:[UIColor orangeColor] range:[myLabel.text rangeOfString:@"Nimbus"]];
[myLabel setFont:[UIFont boldSystemFontOfSize:22] range:[myLabel.text rangeOfString:@"iOS"]];
```

Requirements
------------

NIAttributedLabel must be compiled with the iOS 6 SDK or above. You must link to the CoreText and Core Graphics frameworks.

Version History
===============

1.0.0 on Apr 30, 2014
-----

Initial release. Includes:

- Zero dependencies!
- Link detection.
- Inline images.
- Helper category on NSMutableAttributedString.

Credits
=======

NIAttributedLabel was extracted from Nimbus 1.2.0 by [Jeff Verkoeyen](http://jeffverkoeyen.com/) ([@featherless](http://twitter.com/)).

Contributors
------------

You can be the first! [Open a pull request now](https://github.com/NimbusKit/Basics/compare/).

License
=======

NimbusKit's Attributed Label is licensed under the BSD three-clause license. For a more permissive license (no redistribution of copyright notice, etc.), please contact Jeff at jverkoey@gmail.com for pricing.
