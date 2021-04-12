//
//  Shader.metal
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/9.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
#include "ShaderTypes.h"

struct Vertex {
    float4 position [[position]];
    float2 textureCoordinate [[user(texturecoord)]];
};

vertex Vertex vertexFunction(const device packed_float2 *position [[buffer(0)]],
                             uint vid [[vertex_id]]) {
    Vertex output;
    output.position = float4(position[vid], 0, 1.0);
//    output.textureCoordinate = texturecoord[vid];
    return output;
}

fragment half4 fragmentFunction(Vertex input [[stage_in]],
                                constant Uniforms &uniforms [[buffer(1)]]) {
    half4 color = half4(1.0, 0.0, 0.0, 0.0) * uniforms.hue;
    return color;
}

