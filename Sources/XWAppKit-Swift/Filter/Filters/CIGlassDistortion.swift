import Foundation
import CoreImage

public class CIGlassDistortion: ImageFilter {
    public init() {
        super.init(name: "CIGlassDistortion")
    }
    public func inputScale(_ inputScale: Double) -> CIGlassDistortion {
        filter.setValue(inputScale, forKey:"inputScale")
        return self
    }
    public func inputTexture(_ inputTexture: CIImage?) -> CIGlassDistortion {
        filter.setValue(inputTexture, forKey:"inputTexture")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIGlassDistortion {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGlassDistortion {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
