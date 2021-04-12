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
    private var uniformsBuffer: MTLBuffer?
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
            
            let v: [Float] = [-1.0,  1.0,
                               1.0,  1.0,
                              -1.0, -1.0,
                               1.0, -1.0]
            
            vertexBuffer = device.makeBuffer(bytes: v, length: MemoryLayout<Float>.size * v.count, options: [])
            
            uniformsBuffer = device.makeBuffer(length: MemoryLayout<Uniforms>.size, options: [])
            uniformsBuffer!.contents().assumingMemoryBound(to: Uniforms.self).pointee.hue = 1.0
            commandQueue = device.makeCommandQueue()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        if let currentDrawable = currentDrawable,
           let vertexBuffer = self.vertexBuffer,
           let uniformsBuffer = self.uniformsBuffer,
           let commandQueue = self.commandQueue,
           let renderPassDesc = currentRenderPassDescriptor,
           let pipeline = pipelineState {
            
            let commandBuffer = commandQueue.makeCommandBuffer()
            
            guard let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return }
            renderEncoder.setFrontFacing(.counterClockwise)
            renderEncoder.setRenderPipelineState(pipeline)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            renderEncoder.setFragmentBuffer(uniformsBuffer, offset: 0, index: 1)

            renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
            renderEncoder.endEncoding()
            
            commandBuffer?.present(currentDrawable)
            commandBuffer?.commit()
        }
    }

}
