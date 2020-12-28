import Foundation
import CoreImage

public class CICrystallize: ImageFilter {
    public init() {
        super.init(name: "CICrystallize")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CICrystallize {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CICrystallize {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CICrystallize {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
}
