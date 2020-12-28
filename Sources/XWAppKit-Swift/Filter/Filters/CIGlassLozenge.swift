import Foundation
import CoreImage

public class CIGlassLozenge: ImageFilter {
    init() {
        super.init(name: "CIGlassLozenge")
    }
    public func inputPoint1(_ inputPoint1: CIVector?) -> CIGlassLozenge {
        filter.setValue(inputPoint1, forKey:"inputPoint1")
        return self
    }
    public func inputPoint0(_ inputPoint0: CIVector?) -> CIGlassLozenge {
        filter.setValue(inputPoint0, forKey:"inputPoint0")
        return self
    }
    public func inputRefraction(_ inputRefraction: Double) -> CIGlassLozenge {
        filter.setValue(inputRefraction, forKey:"inputRefraction")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIGlassLozenge {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIGlassLozenge {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
