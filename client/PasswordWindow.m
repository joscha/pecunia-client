//
//  PasswordWindow.m
//  Pecunia
//
//  Created by Frank Emminghaus on 23.05.09.
//  Copyright 2009 Frank Emminghaus. All rights reserved.
//

#import "PasswordWindow.h"


@implementation PasswordWindow

-(id)init
{
	self = [super initWithWindowNibName:@"PasswordWindow"];
	active = YES;
	return self;
}

-(id)initWithText: (NSString *)x title: (NSString *)y
{
	self = [super initWithWindowNibName:@"PasswordWindow"];
    text = [x copy];
	title = [y copy];
	active = YES;
	return self;
}

-(void)controlTextDidEndEditing:(NSNotification *)aNotification
{
//	[self close];
	result = [inputField stringValue];
	if([result length] == 0) NSBeep();
	else {
		[NSApp stopModalWithCode:0];
		active = NO;
		[self closeWindow ];
	}
}

-(void)retry
{
	[self showWindow:self ];
	active = YES;
	NSBeep();
	[inputField setStringValue: @"" ];
	[inputField setBackgroundColor:[NSColor redColor ] ];
}

-(void)closeWindow
{
	[[self window ] close ];
}

-(void)windowWillClose:(NSNotification *)aNotification
{
	if(active) {
		result = [inputField stringValue];
		if([result length] == 0) [NSApp stopModalWithCode:1];
		else [NSApp stopModalWithCode:0];
	}
}

-(void)windowDidLoad
{
	[inputText setStringValue: text];
	[[self window] setTitle: title];
}

-(NSString*)result
{
	return result;
}

-(BOOL)shouldSavePassword
{
	return savePassword;
}


@end