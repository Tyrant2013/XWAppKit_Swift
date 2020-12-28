import Foundation
import CoreImage

public class CIEdgeWork: ImageFilter {
    public init() {
        super.init(name: "CIEdgeWork")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIEdgeWork {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIEdgeWork {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
}
