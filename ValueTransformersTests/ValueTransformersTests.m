/*******************************************************************************
 * The MIT License (MIT)
 * 
 * Copyright (c) 2018 Jean-David Gadina - www.xs-labs.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

#pragma clang diagnostic ignored "-Wgnu-statement-expression"

#import <XCTest/XCTest.h>
#import <ValueTransformers/ValueTransformers.h>

@interface ValueTransformersTests: XCTestCase

@end

@implementation ValueTransformersTests

- ( void )testVTArrayHasMoreThanOneObject
{
    VTArrayHasMoreThanOneObject * vt;
    
    vt = [ VTArrayHasMoreThanOneObject new ];
    
    XCTAssertEqual( [ VTArrayHasMoreThanOneObject transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTArrayHasMoreThanOneObject allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @""           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[          ] ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[ @""      ] ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @[ @"", @"" ] ] ).boolValue, @"" );
}

- ( void )testVTArrayHasOnlyOneObject
{
    VTArrayHasOnlyOneObject * vt;
    
    vt = [ VTArrayHasOnlyOneObject new ];
    
    XCTAssertEqual( [ VTArrayHasOnlyOneObject transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTArrayHasOnlyOneObject allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @""           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[          ] ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @[ @""      ] ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[ @"", @"" ] ] ).boolValue, @"" );
}

- ( void )testVTArrayIsEmpty
{
    VTArrayIsEmpty * vt;
    
    vt = [ VTArrayIsEmpty new ];
    
    XCTAssertEqual( [ VTArrayIsEmpty transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTArrayIsEmpty allowsReverseTransformation ], @"" );
    
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: nil           ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @""           ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @[          ] ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[ @""      ] ] ).boolValue, @"" );
}

- ( void )testVTArrayIsNotEmpty
{
    VTArrayIsNotEmpty * vt;
    
    vt = [ VTArrayIsNotEmpty new ];
    
    XCTAssertEqual( [ VTArrayIsNotEmpty transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTArrayIsNotEmpty allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @""           ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[          ] ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @[ @""      ] ] ).boolValue, @"" );
}

- ( void )testVTBoolToDisabledTextColor
{
    VTBoolToDisabledTextColor * vt;
    
    vt = [ VTBoolToDisabledTextColor new ];
    
    XCTAssertEqual( [ VTBoolToDisabledTextColor transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTBoolToDisabledTextColor allowsReverseTransformation ], @"" );
    
    XCTAssertEqual( [ vt transformedValue: @"" ], [ NSColor disabledControlTextColor ], @"" );
    XCTAssertEqual( [ vt transformedValue: @0  ], [ NSColor disabledControlTextColor ], @"" );
    XCTAssertEqual( [ vt transformedValue: @1  ], [ NSColor controlTextColor ], @"" );
}

- ( void )testVTCountToString
{
    VTCountToString * vt;
    
    vt = [ VTCountToString new ];
    
    XCTAssertEqual( [ VTCountToString transformedValueClass ], [ NSString class ], @"" );
    XCTAssertFalse( [ VTCountToString allowsReverseTransformation ], @"" );
    
    XCTAssertTrue( [ [ vt transformedValue: nil ]      isEqualToString: @"0" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @0  ]      isEqualToString: @"0" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @[] ]      isEqualToString: @"0" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @[ @"" ] ] isEqualToString: @"1" ], @"" );
}

- ( void )testVTNumberIsGreaterThanZero
{
    VTNumberIsGreaterThanZero * vt;
    
    vt = [ VTNumberIsGreaterThanZero new ];
    
    XCTAssertEqual( [ VTNumberIsGreaterThanZero transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTNumberIsGreaterThanZero allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @"" ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @-1 ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @0  ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @1  ] ).boolValue, @"" );
}

- ( void )testVTNumberIsLessThanZero
{
    VTNumberIsLessThanZero * vt;
    
    vt = [ VTNumberIsLessThanZero new ];
    
    XCTAssertEqual( [ VTNumberIsLessThanZero transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTNumberIsLessThanZero allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @"" ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @-1 ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @0  ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @1  ] ).boolValue, @"" );
}

- ( void )testVTNumberIsZero
{
    VTNumberIsZero * vt;
    
    vt = [ VTNumberIsZero new ];
    
    XCTAssertEqual( [ VTNumberIsZero transformedValueClass ], [ NSNumber class ], @"" );
    XCTAssertFalse( [ VTNumberIsZero allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @"" ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @-1 ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @0  ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @1  ] ).boolValue, @"" );
}

- ( void )testVTStringIsEmpty
{
    VTStringIsEmpty * vt;
    
    vt = [ VTStringIsEmpty new ];
    
    XCTAssertEqual( [ VTStringIsEmpty transformedValueClass ], [ NSString class ], @"" );
    XCTAssertFalse( [ VTStringIsEmpty allowsReverseTransformation ], @"" );
    
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: nil  ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @[]  ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @""  ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @" " ] ).boolValue, @"" );
}

- ( void )testVTStringIsNotEmpty
{
    VTStringIsNotEmpty * vt;
    
    vt = [ VTStringIsNotEmpty new ];
    
    XCTAssertEqual( [ VTStringIsNotEmpty transformedValueClass ], [ NSString class ], @"" );
    XCTAssertFalse( [ VTStringIsNotEmpty allowsReverseTransformation ], @"" );
    
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: nil  ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @[]  ] ).boolValue, @"" );
    XCTAssertFalse( ( ( NSNumber * )[ vt transformedValue: @""  ] ).boolValue, @"" );
    XCTAssertTrue(  ( ( NSNumber * )[ vt transformedValue: @" " ] ).boolValue, @"" );
}

- ( void )testVTUppercaseString
{
    VTUppercaseString * vt;
    
    vt = [ VTUppercaseString new ];
    
    XCTAssertEqual( [ VTUppercaseString transformedValueClass ], [ NSString class ], @"" );
    XCTAssertFalse( [ VTUppercaseString allowsReverseTransformation ], @"" );
    
    XCTAssertEqual( [ vt transformedValue: nil ], nil, @"" );
    XCTAssertEqual( [ vt transformedValue: @[] ], nil, @"" );
    
    XCTAssertTrue( [ [ vt transformedValue: @"" ]    isEqualToString: @"" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @"foo" ] isEqualToString: @"FOO" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @"Foo" ] isEqualToString: @"FOO" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @"FOO" ] isEqualToString: @"FOO" ], @"" );
    XCTAssertTrue( [ [ vt transformedValue: @"fOO" ] isEqualToString: @"FOO" ], @"" );
}

@end
