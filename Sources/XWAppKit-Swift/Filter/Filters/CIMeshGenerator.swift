import Foundation
import CoreImage

public class CIMeshGenerator: ImageFilter {
    public init() {
        super.init(name: "CIMeshGenerator")
    }
    public func inputWidth(_ inputWidth: Double) -> CIMeshGenerator {
        filter.setValue(inputWidth, forKey:"inputWidth")
        return self
    }
    public func inputMesh(_ inputMesh: NSArray?) -> CIMeshGenerator {
        filter.setValue(inputMesh, forKey:"inputMesh")
        return self
    }
    override public func inputColor(_ inputColor: CIColor?) -> CIMeshGenerator {
        filter.setValue(inputColor, forKey:"inputColor")
        return self
    }
}
