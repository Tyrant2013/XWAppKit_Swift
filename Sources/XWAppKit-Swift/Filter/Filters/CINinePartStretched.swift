import Foundation
import CoreImage

public class CINinePartStretched: ImageFilter {
    public init() {
        super.init(name: "CINinePartStretched")
    }
    public func inputBreakpoint1(_ inputBreakpoint1: CIVector?) -> CINinePartStretched {
        filter.setValue(inputBreakpoint1, forKey:"inputBreakpoint1")
        return self
    }
    public func inputBreakpoint0(_ inputBreakpoint0: CIVector?) -> CINinePartStretched {
        filter.setValue(inputBreakpoint0, forKey:"inputBreakpoint0")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CINinePartStretched {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputGrowAmount(_ inputGrowAmount: CIVector?) -> CINinePartStretched {
        filter.setValue(inputGrowAmount, forKey:"inputGrowAmount")
        return self
    }
}
