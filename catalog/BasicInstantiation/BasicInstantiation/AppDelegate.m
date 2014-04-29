/**
 Copyright (c) 2011-present, NimbusKit. All rights reserved.

 This source code is licensed under the BSD-style license found in the LICENSE file in the root
 directory of this source tree and at the http://nimbuskit.info/license url. An additional grant of
 patent rights can be found in the PATENTS file in the same directory and url.
 */

#import "AppDelegate.h"

#import "BasicInstantiationViewController.h"

@implementation AppDelegate

#pragma mark - Standard Scaffolding

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];

  self.window.rootViewController = [BasicInstantiationViewController new];

  [self.window makeKeyAndVisible];
  return YES;
}

@end
