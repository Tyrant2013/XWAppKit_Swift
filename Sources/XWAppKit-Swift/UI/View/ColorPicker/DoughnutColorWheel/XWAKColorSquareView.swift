//
//  XWAKColorSquareView.swift
//  XWAppKit-Swift
//
//  Created by ZHXW on 2021/4/9.
//  Copyright © 2021 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import MetalKit

public class XWAKColorSquareView: MTKView {
    private var pipelineState: MTLRenderPipelineState?
    private var vertexBuffer: MTLBuffer?
//    private var uniformsBuffer: MTLBuffer?
    private var commandQueue: MTLCommandQueue?
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: MTLCreateSystemDefaultDevice())
        self.drawableSize = .init(width: frameRect.width, height: frameRect.height)
        initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        if let device = self.device {
            self.device = device
            
            let library = device.makeDefaultLibrary()
            guard let verFunc = library?.makeFunction(name: "vertexFunction"),
                  let fragFunc = library?.makeFunction(name: "fragmentFunction") else {
                print("加载方法失败")
                return
            }
            let desc = MTLRenderPipelineDescriptor()
            desc.sampleCount = 1
            desc.vertexFunction = verFunc
            desc.fragmentFunction = fragFunc
            desc.colorAttachments[0].pixelFormat = colorPixelFormat
            do {
                pipelineState = try device.makeRenderPipelineState(descriptor: desc)
            }
            catch {
                print(error)
            }
            
            let v: [Float] = [-1.0,  1.0,  0,  1,
                               1.0,  1.0,  1,  1,
                              -1.0, -1.0,  0, -1,
                               1.0, -1.0, -1, -1]
            
            vertexBuffer = device.makeBuffer(bytes: v, length: MemoryLayout<Float>.size * v.count, options: [])
            
//            uniformsBuffer = device.makeBuffer(length: MemoryLayout<Uniforms>.size, options: [])
//            let uniforms = uniformsBuffer!.contents().assumingMemoryBound(to: Uniforms.self)
//            uniforms.pointee.hue = 1.0
//            uniforms.pointee.modelViewProjectionMatrix = matrix_load(left: 0,
//                                                                     right: Float(bounds.width),
//                                                                     bottom: 0,
//                                                                     top: Float(bounds.height),
//                                                                     near: -1.0,
//                                                                     far: 1.0)
            commandQueue = device.makeCommandQueue()
        }
    }
    
    func matrix_load(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) -> matrix_float4x4 {
        let r_l = right - left
        let t_b = top - bottom
        let f_n = far - near
        let tx = -(right + left) / (right - left)
        let ty = -(top + bottom) / (top - bottom)
        let tz = -(far + near) / (far - near)
        return matrix_make(m00: 2.0/r_l,    m10: 0,         m20: 0,         m30: 0,
                           m01: 0.0,        m11: 2.0/t_b,   m21: 0,         m31: 0,
                           m02: 0,          m12: 0,         m22: -2.0/f_n,  m32: 0,
                           m03: tx,         m13: ty,        m23: tz,        m33: 1.0)
    }
    
    func matrix_make(m00: Float, m10: Float, m20: Float, m30: Float,
                     m01: Float, m11: Float, m21: Float, m31: Float,
                     m02: Float, m12: Float, m22: Float, m32: Float,
                     m03: Float, m13: Float, m23: Float, m33: Float) -> matrix_float4x4 {
        return matrix_float4x4(SIMD4<Float>(m00, m10, m20, m30),
                               SIMD4<Float>(m01, m11, m21, m31),
                               SIMD4<Float>(m02, m12, m22, m32),
                               SIMD4<Float>(m03, m13, m23, m33))
    }
    
    public override func draw(_ rect: CGRect) {
        if let currentDrawable = currentDrawable,
           let vertexBuffer = self.vertexBuffer,
//           let uniformsBuffer = self.uniformsBuffer,
           let commandQueue = self.commandQueue,
           let renderPassDesc = currentRenderPassDescriptor,
           let pipeline = pipelineState {
            
            let commandBuffer = commandQueue.makeCommandBuffer()
            
            guard let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return }
            renderEncoder.setFrontFacing(.counterClockwise)
            renderEncoder.setRenderPipelineState(pipeline)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//            renderEncoder.setVertexBuffer(uniformsBuffer, offset: 0, index: 1)
//            renderEncoder.setFragmentBuffer(uniformsBuffer, offset: 0, index: 1)

            renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
            renderEncoder.endEncoding()
            
            commandBuffer?.present(currentDrawable)
            commandBuffer?.commit()
        }
    }

}
