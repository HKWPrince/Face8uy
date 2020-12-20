//
//  ShoppingListControl.swift
//  Face8uy
//
//  Created by 國維黃 on 2020/9/2.
//  Copyright © 2020 國維黃. All rights reserved.
//

import UIKit
import Firebase

class ShoppingListControl: NSObject
{
    static var shoppingList: Array<String> = []
    static var itemNumber: Array<Int> = []
    static var itemPrice: Array<String> = []
    static var tempPrice:Int = 0
    
    class func addItemToShoppingList(newItem: String)
    {
        ShoppingListControl.shoppingList.append(newItem)
        ShoppingListControl.itemNumber.append(1)
        //ShoppingListControl.itemPrice.append(ShoppingListControl.tempPrice)
        print(ShoppingListControl.shoppingList)
        print(ShoppingListControl.itemNumber)
        
    }
    class func addItemPriceToList(newPrice: String)
    {
        ShoppingListControl.itemPrice.append(newPrice)
    }
    
    class func deletItemFromShoppingList(atIndex: Int)
    {
        ShoppingListControl.shoppingList.remove(at: atIndex)
        ShoppingListControl.itemNumber.remove(at: atIndex)
        ShoppingListControl.itemPrice.remove(at: atIndex)
        
    }
}
