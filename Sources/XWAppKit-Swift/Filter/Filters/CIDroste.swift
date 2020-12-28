import Foundation
import CoreImage

public class CIDroste: ImageFilter {
    public init() {
        super.init(name: "CIDroste")
    }
    public func inputPeriodicity(_ inputPeriodicity: Double) -> CIDroste {
        filter.setValue(inputPeriodicity, forKey:"inputPeriodicity")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIDroste {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputInsetPoint0(_ inputInsetPoint0: CIVector?) -> CIDroste {
        filter.setValue(inputInsetPoint0, forKey:"inputInsetPoint0")
        return self
    }
    public func inputStrands(_ inputStrands: Double) -> CIDroste {
        filter.setValue(inputStrands, forKey:"inputStrands")
        return self
    }
    public func inputZoom(_ inputZoom: Double) -> CIDroste {
        filter.setValue(inputZoom, forKey:"inputZoom")
        return self
    }
    public func inputRotation(_ inputRotation: Double) -> CIDroste {
        filter.setValue(inputRotation, forKey:"inputRotation")
        return self
    }
    public func inputInsetPoint1(_ inputInsetPoint1: CIVector?) -> CIDroste {
        filter.setValue(inputInsetPoint1, forKey:"inputInsetPoint1")
        return self
    }
}
