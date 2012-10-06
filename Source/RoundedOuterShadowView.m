/**
 * Copyright (c) 2008, 2012, Pecunia Project. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; version 2 of the
 * License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301  USA
 */

#import "RoundedOuterShadowView.h"
#import "GraphicsAdditions.h"

@implementation RoundedOuterShadowView

@synthesize indicatorColor;

- (id) initWithFrame: (NSRect) frameRect
{
    self = [super initWithFrame: frameRect];
    if (self != nil)
    {
    }
    
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

// Shared objects.
static NSShadow* borderShadow = nil;

- (void) drawRect: (NSRect) rect
{
    [NSGraphicsContext saveGraphicsState];
    
    // Initialize shared objects.
    if (borderShadow == nil)
    {
        borderShadow = [[NSShadow alloc] initWithColor: [NSColor colorWithDeviceWhite: 0 alpha: 0.5]
                                                offset: NSMakeSize(3, -3)
                                            blurRadius: 8.0];
    }
    
    // Outer bounds with shadow.
    NSRect bounds = [self bounds];
    bounds.size.width -= 20;
    bounds.size.height -= 20;
    bounds.origin.x += 10;
    bounds.origin.y += 10;

    NSBezierPath* borderPath = [NSBezierPath bezierPathWithRoundedRect: bounds xRadius: 8 yRadius: 8];
    [borderShadow set];
    [[NSColor whiteColor] set];
    [borderPath fill];
    
    [NSGraphicsContext restoreGraphicsState];

    if (indicatorColor != nil) {
        [borderPath setClip];
        [self.indicatorColor set];
        NSRect barRect = bounds;
        barRect.origin.y = 8;
        barRect.size.height = 8;
        NSRectFill(barRect);
    }

    // Draw Text Fields
    [self drawTextFields];
}

- (void)setIndicatorColor: (NSColor*)color
{
    if (indicatorColor != color) {
        [indicatorColor release];
        indicatorColor = [color retain];
        [self setNeedsDisplay: YES];
    }
}

@end