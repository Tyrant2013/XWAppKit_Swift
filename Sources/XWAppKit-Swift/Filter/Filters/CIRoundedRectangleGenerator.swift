import Foundation
import CoreImage

public class CIRoundedRectangleGenerator: ImageFilter {
    init() {
        super.init(name: "CIRoundedRectangleGenerator")
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIRoundedRectangleGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIRoundedRectangleGenerator {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputExtent(_ inputExtent: CIVector?) -> CIRoundedRectangleGenerator {
        filter.setValue(inputExtent, forKey:"inputExtent")
        return self
    }
}
