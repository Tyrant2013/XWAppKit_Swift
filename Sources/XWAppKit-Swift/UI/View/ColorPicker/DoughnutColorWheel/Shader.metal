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

typedef struct {
    vector_float2 pos;
} Vertex;

struct VertexInOut {
    float4 position [[position]];
};

vertex VertexInOut vertexFunction(constant Vertex *vertexArr [[buffer(0)]],
                             uint vid [[vertex_id]]) {
    VertexInOut output;
    float4 pos = vector_float4(vertexArr[vid].pos, 0, 1.0);
    output.position = pos;
    return output;
}

fragment half4 fragmentFunction(VertexInOut input [[stage_in]],
                                constant Uniforms &uniforms [[buffer(1)]]) {
    half4 color = half4(1.0, 1.0, 0.0, 0.0) * uniforms.hue;
    return color;
}

