import Foundation
import CoreImage

public class CIKaleidoscope: ImageFilter {
    init() {
        super.init(name: "CIKaleidoscope")
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIKaleidoscope {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputAngle(_ inputAngle: Double) -> CIKaleidoscope {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    public func inputCount(_ inputCount: Double) -> CIKaleidoscope {
        filter.setValue(inputCount, forKey:"inputCount")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIKaleidoscope {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
