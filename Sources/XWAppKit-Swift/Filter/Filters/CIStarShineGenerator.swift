import Foundation
import CoreImage

public class CIStarShineGenerator: ImageFilter {
    public init() {
        super.init(name: "CIStarShineGenerator")
    }
    public func inputCrossScale(_ inputCrossScale: Double) -> CIStarShineGenerator {
        filter.setValue(inputCrossScale, forKey:"inputCrossScale")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CIStarShineGenerator {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputRadius(_ inputRadius: Double) -> CIStarShineGenerator {
        filter.setValue(inputRadius, forKey:"inputRadius")
        return self
    }
    public func inputCrossWidth(_ inputCrossWidth: Double) -> CIStarShineGenerator {
        filter.setValue(inputCrossWidth, forKey:"inputCrossWidth")
        return self
    }
    public func inputCrossOpacity(_ inputCrossOpacity: Double) -> CIStarShineGenerator {
        filter.setValue(inputCrossOpacity, forKey:"inputCrossOpacity")
        return self
    }
    public func inputEpsilon(_ inputEpsilon: Double) -> CIStarShineGenerator {
        filter.setValue(inputEpsilon, forKey:"inputEpsilon")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIStarShineGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputCrossAngle(_ inputCrossAngle: Double) -> CIStarShineGenerator {
        filter.setValue(inputCrossAngle, forKey:"inputCrossAngle")
        return self
    }
}
