import Foundation
import CoreImage

public class CIColorMatrix: ImageFilter {
    public init() {
        super.init(name: "CIColorMatrix")
    }
    public func inputRVector(_ inputRVector: CIVector?) -> CIColorMatrix {
        filter.setValue(inputRVector, forKey:"inputRVector")
        return self
    }
    public func inputGVector(_ inputGVector: CIVector?) -> CIColorMatrix {
        filter.setValue(inputGVector, forKey:"inputGVector")
        return self
    }
    public func inputAVector(_ inputAVector: CIVector?) -> CIColorMatrix {
        filter.setValue(inputAVector, forKey:"inputAVector")
        return self
    }
    public func inputBVector(_ inputBVector: CIVector?) -> CIColorMatrix {
        filter.setValue(inputBVector, forKey:"inputBVector")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorMatrix {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBiasVector(_ inputBiasVector: CIVector?) -> CIColorMatrix {
        filter.setValue(inputBiasVector, forKey:"inputBiasVector")
        return self
    }
}
