import Foundation
import CoreImage

public class CIColorPolynomial: ImageFilter {
    init() {
        super.init(name: "CIColorPolynomial")
    }
    public func inputGreenCoefficients(_ inputGreenCoefficients: CIVector?) -> CIColorPolynomial {
        filter.setValue(inputGreenCoefficients, forKey:"inputGreenCoefficients")
        return self
    }
    public func inputBlueCoefficients(_ inputBlueCoefficients: CIVector?) -> CIColorPolynomial {
        filter.setValue(inputBlueCoefficients, forKey:"inputBlueCoefficients")
        return self
    }
    override public func inputImage(_ inputImage: CIImage?) -> CIColorPolynomial {
        filter.setValue(inputImage, forKey:"inputImage")
        return self
    }
    public func inputRedCoefficients(_ inputRedCoefficients: CIVector?) -> CIColorPolynomial {
        filter.setValue(inputRedCoefficients, forKey:"inputRedCoefficients")
        return self
    }
    public func inputAlphaCoefficients(_ inputAlphaCoefficients: CIVector?) -> CIColorPolynomial {
        filter.setValue(inputAlphaCoefficients, forKey:"inputAlphaCoefficients")
        return self
    }
}
