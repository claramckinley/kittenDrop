//
//  Kitten.swift
//  KittenDrop
//
//  Created by Clara McKinley on 6/13/23.
//

class Kitten{
    //data
    private (set) var color:CatColor
    private (set) var size:Int
    private (set) var name:String
    private (set) var orientation:Direction
    
    enum CatColor: String {
        case grey
        case orange
        case black
    }
    
    enum Direction: String, CaseIterable {
        case up
        case right
        case down
        case left
        
        func next() -> Direction {
            let all = type(of: self).allCases // 1
            if self == all.last! {
              return all.first!
            } else {
              let index = all.firstIndex(of: self)!
              return all[index + 1]
            }
          }
        
        func prev() -> Direction {
            let all = type(of: self).allCases // 1
            if self == all.first! {
              return all.last!
            } else {
              let index = all.firstIndex(of: self)!
              return all[index - 1]
            }
          }
    }
    
    //behavior
    func spinRight() {
        orientation = orientation.next()
    }
    
    func spinLeft() {
        orientation = orientation.prev()
    }
    
    //initialization
    init(color: CatColor, size: Int, name: String, orientation: Direction) {
        self.color = color
        self.size = size
        self.name = name
        self.orientation = orientation
    }
}
