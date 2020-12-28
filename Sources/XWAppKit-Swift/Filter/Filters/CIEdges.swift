import Foundation
import CoreImage

public class CIEdges: ImageFilter {
    public init() {
        super.init(name: "CIEdges")
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIEdges {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputIntensity(_ inputIntensity: Double) -> CIEdges {
        filter.setValue(inputIntensity, forKey:"inputIntensity")
        return self
    }
}
