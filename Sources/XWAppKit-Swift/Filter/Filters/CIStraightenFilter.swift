import Foundation
import CoreImage

public class CIStraightenFilter: ImageFilter {
    init() {
        super.init(name: "CIStraightenFilter")
    }
    public func inputAngle(_ inputAngle: Double) -> CIStraightenFilter {
        filter.setValue(inputAngle, forKey:"inputAngle")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIStraightenFilter {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
}
