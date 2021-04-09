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
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        self.drawableSize = .init(width: frameRect.width, height: frameRect.height)
        initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        if let device = MTLCreateSystemDefaultDevice() {
            self.device = device
            
            let library = device.makeDefaultLibrary()
            guard let verFunc = library?.makeFunction(name: "vertexFunction"),
                  let fragFunc = library?.makeFunction(name: "fragmentFunction") else {
                print("")
                return
            }
            let desc = MTLRenderPipelineDescriptor()
            desc.vertexFunction = verFunc
            desc.fragmentFunction = fragFunc
            desc.colorAttachments[0].pixelFormat = .bgra8Unorm
            do {
                pipelineState = try device.makeRenderPipelineState(descriptor: desc)
            }
            catch {
                print(error)
            }
        }
    }
    
    public override func draw(_ rect: CGRect) {
        if let currentDrawable = currentDrawable, let device = device, let pipeline = pipelineState {
            let commandQueue = device.makeCommandQueue()
            let commandBuffer = commandQueue?.makeCommandBuffer()
            let v: [Float] = [-1.0,  1.0,
                               1.0,  1.0,
                              -1.0, -1.0,
                               1.0, -1.0]
            let vertexBuffer = device.makeBuffer(bytes: v, length: MemoryLayout<Float>.size * v.count, options: [])!
            let renderPassDesc = MTLRenderPassDescriptor()
            
            renderPassDesc.colorAttachments[0].texture = currentDrawable.texture
            renderPassDesc.colorAttachments[0].clearColor = MTLClearColor(red: 1, green: 1, blue: 1, alpha: 1)
            renderPassDesc.colorAttachments[0].storeAction = .store
            renderPassDesc.colorAttachments[0].loadAction = .clear
            
            guard let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDesc) else { return }
//            renderEncoder.setViewport(MTLViewport(originX: 0,
//                                                  originY: 0,
//                                                  width: Double(drawableSize.width),
//                                                  height: Double(drawableSize.height),
//                                                  znear: -1,
//                                                  zfar: 1.0))
            renderEncoder.setFrontFacing(.counterClockwise)
            renderEncoder.setRenderPipelineState(pipeline)
            renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            renderEncoder.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)
            renderEncoder.endEncoding()
            
            commandBuffer?.present(currentDrawable)
            commandBuffer?.commit()
        }
    }

}
