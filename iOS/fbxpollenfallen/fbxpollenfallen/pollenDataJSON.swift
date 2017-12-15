//
//  pollenDataJSON.swift
//  fbxpollenfallen
//
//  Created by Laurin Fisher on 12/5/17.
//  Copyright © 2017 UAF. All rights reserved.
//

import Foundation

/* Example JSON from website, only 1 day of data in the Data object however
 {
    'Year' = 2000,
    'Data' = {
        'Alder' = 0,
        'Willow' = 0,
        'Poplar_Aspen' = 1,
        'Birch' = 0,
        'Spruce' = 0,
        'Other1_Tree' = 0,
        'Other2_Tree' = 1,
 
        'Grass' = 0,
        'Grass2' = 0,
        'Weed' = 1,
        'Other1' = 0,
        'Other2' = 1,
        'Mold' = 1,
 
        'Day' = 21,
        'Month' = 2
    }
 }

*/

//Since we have embedded JSON, for decoding, use another struct
struct Data : Codable {
    
    //Trees
    var Alder : Int
    var Willow : Int
    var Poplar_Aspen : Int
    var Birch : Int
    var Spruce : Int
    var Other1_Tree : Int
    var Other2_Tree : Int
    
    //Other pollen sources
    var Grass : Int
    var Grass2 : Int

    var Weed : Int
    var Other1 : Int
    var Other2 : Int
    var Mold : Int
    
    //Day & Month when data was recorded 
    var Day : Int
    var Month : Int
    
}

//structs are copied, classes are by reference
//Our JSON from our Server, Top level
struct pollenJSON : Codable {
    let Year : Int
    var Data : [Data]
}
