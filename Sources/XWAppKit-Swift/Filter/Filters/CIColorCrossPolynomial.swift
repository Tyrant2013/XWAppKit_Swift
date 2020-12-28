import Foundation
import CoreImage

public class CIColorCrossPolynomial: ImageFilter {
    init() {
        super.init(name: "CIColorCrossPolynomial")
    }
    public func inputRedCoefficients(_ inputRedCoefficients: CIVector?) -> CIColorCrossPolynomial {
        filter.setValue(inputRedCoefficients, forKey:"inputRedCoefficients")
        return self
    }
    public func inputGreenCoefficients(_ inputGreenCoefficients: CIVector?) -> CIColorCrossPolynomial {
        filter.setValue(inputGreenCoefficients, forKey:"inputGreenCoefficients")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorCrossPolynomial {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputBlueCoefficients(_ inputBlueCoefficients: CIVector?) -> CIColorCrossPolynomial {
        filter.setValue(inputBlueCoefficients, forKey:"inputBlueCoefficients")
        return self
    }
}
