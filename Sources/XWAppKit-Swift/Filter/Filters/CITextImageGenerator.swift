import Foundation
import CoreImage

public class CITextImageGenerator: ImageFilter {
    public init() {
        super.init(name: "CITextImageGenerator")
    }
    public func inputFontName(_ inputFontName: NSString?) -> CITextImageGenerator {
        filter.setValue(inputFontName, forKey:"inputFontName")
        return self
    }
    public func inputFontSize(_ inputFontSize: Double) -> CITextImageGenerator {
        filter.setValue(inputFontSize, forKey:"inputFontSize")
        return self
    }
    public func inputScaleFactor(_ inputScaleFactor: Double) -> CITextImageGenerator {
        filter.setValue(inputScaleFactor, forKey:"inputScaleFactor")
        return self
    }
    public func inputText(_ inputText: NSString?) -> CITextImageGenerator {
        filter.setValue(inputText, forKey:"inputText")
        return self
    }
}
