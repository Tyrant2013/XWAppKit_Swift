import Foundation
import CoreImage

public class CILenticularHaloGenerator: ImageFilter {
    init() {
        super.init(name: "CILenticularHaloGenerator")
    }
    public func inputStriationContrast(_ inputStriationContrast: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputStriationContrast, forKey:"inputStriationContrast")
        return self
    }
    public func inputHaloWidth(_ inputHaloWidth: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputHaloWidth, forKey:"inputHaloWidth")
        return self
    }
    public func inputHaloOverlap(_ inputHaloOverlap: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputHaloOverlap, forKey:"inputHaloOverlap")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CILenticularHaloGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
    public func inputCenter(_ inputCenter: CIVector?) -> CILenticularHaloGenerator {
        filter.setValue(inputCenter, forKey:"inputCenter")
        return self
    }
    public func inputStriationStrength(_ inputStriationStrength: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputStriationStrength, forKey:"inputStriationStrength")
        return self
    }
    public func inputHaloRadius(_ inputHaloRadius: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputHaloRadius, forKey:"inputHaloRadius")
        return self
    }
    public func inputTime(_ inputTime: Double) -> CILenticularHaloGenerator {
        filter.setValue(inputTime, forKey:"inputTime")
        return self
    }
}
