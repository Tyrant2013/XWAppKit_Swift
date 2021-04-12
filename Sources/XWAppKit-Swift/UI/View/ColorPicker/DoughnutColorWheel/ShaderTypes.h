//
//  ShaderTypes.h
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/12.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#ifdef __METAL_VERSION__
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define NSInteger metal::int32_t
#else
#import <Foundation/Foundation.h>
#endif

#include <simd/simd.h>

typedef struct
{
    float hue;
} Uniforms;

#endif /* ShaderTypes_h */
