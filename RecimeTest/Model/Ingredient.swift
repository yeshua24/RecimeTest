//
//  Ingredient.swift
//  RecimeTest
//
//  Created by Yeshua Lagac on 2/14/26.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    
    static let mock : [Ingredient] = [
        .init(name: "Chicken", imageName: "chicken"),
        .init(name: "Egg", imageName: "egg"),
        .init(name: "Pasta", imageName: "pasta"),
        .init(name: "Rice", imageName: "rice"),
        .init(name: "Beef Mince", imageName: "beef mince"),
        .init(name: "Broccoli", imageName: "broccoli"),
        .init(name: "Tofu", imageName: "tofu"),
        .init(name: "Salmon", imageName: "salmon"),
        .init(name: "Spinach", imageName: "spinach"),
        .init(name: "Milk", imageName: "milk"),
        .init(name: "Quinoa", imageName: "quinoa"),
        .init(name: "Canned Tomato", imageName: "cannedTomato"),
        .init(name: "Pork", imageName: "pork"),
        .init(name: "Beef", imageName: "beef"),
        .init(name: "Lamb", imageName: "lamb"),
        .init(name: "Mushroom", imageName: "mushroom"),
        .init(name: "Potato", imageName: "potato"),
        .init(name: "Tomato", imageName: "tomato"),
        .init(name: "Noodles", imageName: "noodles"),
        .init(name: "Green Beans", imageName: "greenBeans"),
        .init(name: "Lentils", imageName: "lentils"),
        .init(name: "Chicken Stock", imageName: "chickenStock"),
        .init(name: "Flour", imageName: "flour"),
        .init(name: "Peas", imageName: "peas")
    ]
    
    let id = UUID()
    let name: String
    let imageName: String
}
