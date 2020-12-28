import Foundation
import CoreImage

public class CIParallelogramTile: ImageFilter {
    public init() {
        super.init(name: "CIParallelogramTile")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIParallelogramTile {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputWidth(_ inputWidth: Double) -> CIParallelogramTile {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIParallelogramTile {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIParallelogramTile {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputAcuteAngle(_ inputAcuteAngle: Double) -> CIParallelogramTile {
        filter.setValue(inputAcuteAngle, forKey:"inputAcuteAngle")
        return self
    }
}
