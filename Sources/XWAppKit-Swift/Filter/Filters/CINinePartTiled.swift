import Foundation
import CoreImage

public class CINinePartTiled: ImageFilter {
    init() {
        super.init(name: "CINinePartTiled")
    }
    public func inputBreakpoint0(_ inputBreakpoint0: CIVector?) -> CINinePartTiled {
        filter.setValue(inputBreakpoint0, forKey:"inputBreakpoint0")
        return self
    }
    public func inputGrowAmount(_ inputGrowAmount: CIVector?) -> CINinePartTiled {
        filter.setValue(inputGrowAmount, forKey:"inputGrowAmount")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CINinePartTiled {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputFlipYTiles(_ inputFlipYTiles: Double) -> CINinePartTiled {
        filter.setValue(inputFlipYTiles, forKey:"inputFlipYTiles")
        return self
    }
    public func inputBreakpoint1(_ inputBreakpoint1: CIVector?) -> CINinePartTiled {
        filter.setValue(inputBreakpoint1, forKey:"inputBreakpoint1")
        return self
    }
}
