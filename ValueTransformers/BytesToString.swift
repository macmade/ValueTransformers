/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2022, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Cocoa

@objc( VTBytesToString )
open class BytesToString: ValueTransformer
{
    private static var customFormatter: ( ( uint64 ) -> String )?

    @objc
    public class func setCustomFormatter( _ formatter: ( ( uint64 ) -> String )? )
    {
        self.customFormatter = formatter
    }

    open class func stringFromBytes( _ bytes: uint64 ) -> NSString
    {
        if let formatter = customFormatter
        {
            return formatter( bytes ) as NSString
        }

        if bytes < 1000
        {
            return "\( bytes ) bytes" as NSString
        }
        else if bytes < 1000 * 1000
        {
            return NSString( format: "%.02f KB", Double( bytes ) / 1000 )
        }
        else if bytes < 1000 * 1000 * 1000
        {
            return NSString( format: "%.02f MB", ( Double( bytes ) / 1000 ) / 1000 )
        }
        else if bytes < 1000 * 1000 * 1000 * 1000
        {
            return NSString( format: "%.02f GB", ( ( Double( bytes ) / 1000 ) / 1000 ) / 1000 )
        }

        return NSString( format: "%.02f TB", ( ( ( Double( bytes ) / 1000 ) / 1000 ) / 1000 ) / 1000 )
    }

    open override class func transformedValueClass() -> AnyClass
    {
        return NSString.self
    }

    open override class func allowsReverseTransformation() -> Bool
    {
        return false
    }

    open override func transformedValue( _ value: Any? ) -> Any?
    {
        guard let num = value as? NSNumber
        else
        {
            return nil
        }

        return BytesToString.stringFromBytes( num.uint64Value )
    }
}
