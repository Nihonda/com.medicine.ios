//
//  Array+Extension.swift
//  OpenMedicine
//
//  Created by Nurlan Nihonda on 15/11/21.
//

import Foundation

extension Array{
    public mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
      newElements.forEach { (item) in
        if !(self.contains(where: { (selfItem) -> Bool in
            return !condition(selfItem, item)
        })) {
            self.append(item)
        }
    }
  }
}
