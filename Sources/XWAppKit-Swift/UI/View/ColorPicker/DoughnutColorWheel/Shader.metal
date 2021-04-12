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
    vector_float2 uv;
} Vertex;

struct VertexInOut {
    float4 position [[position]];
    float2 texCoord;
};

vertex VertexInOut vertexFunction(constant Vertex *vertexArr [[buffer(0)]],
                                  uint vid [[vertex_id]],
                                  constant Uniforms &uniforms [[buffer(1)]]) {
    VertexInOut output;
    float4 pos = vector_float4(vertexArr[vid].pos, 0, 1.0);
    output.position = pos;
    output.texCoord = vertexArr[vid].uv;
    return output;
}

fragment half4 fragmentFunction(VertexInOut input [[stage_in]],
                                constant Uniforms &uniforms [[buffer(1)]]) {
//    half4 color = half4(1.0, 0.0, 0.0, 1.0) * uniforms.hue;
//    return color;
    float h = uniforms.hue;
    float s = input.texCoord.x;
    float v = input.texCoord.y;
    half3 rgb;
    if (s == 0.0) {
        rgb = half3(v);
    }
    else {
        float f, p, q, t;
        int i;
        
        h = fmod(h * 6.0, 6.0);
        f = fract(h);
        i = int(h);
        
        p = v * (1.0 - s);
        q = v * (1.0 - s * f);
        t = v * (1.0 - (s * (1.0 - f)));
        
        if (i == 0) {
            rgb = half3(v, t, p);
        }
        else if (i == 1) {
            rgb = half3(q, v, p);
        }
        else if (i == 2) {
            rgb = half3(p, v, t);
        }
        else if (i == 3) {
            rgb = half3(p, q, v);
        }
        else if (i == 4) {
            rgb = half3(t, p, v);
        }
        else {
            rgb = half3(v, p, q);
        }
    }
    return half4(rgb, 1.0);
}

