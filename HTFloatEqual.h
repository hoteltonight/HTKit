//
//  HTFloatEqual.h
//  HotelTonight
//
//  Created by Jacob Jennings on 3/14/13.
//  Copyright (c) 2013 Hotel Tonight. All rights reserved.
//

#ifndef HotelTonight_HTFloatEqual
#define HotelTonight_HTFloatEqual

CG_INLINE BOOL
HTFloatEqual(CGFloat val1, CGFloat val2)
{
    static CGFloat const kVerySmallNumber = 0.000001;
    return fabs(val1 - val2) < kVerySmallNumber * fabs(val1);
}

#endif
