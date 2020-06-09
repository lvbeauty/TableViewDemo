//
//  DataModel.swift
//  Touch
//
//  Created by Tong Yi on 5/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

struct TouchMakeup {
    var brand: String
    var makeup: String
    var makeupType: MakeupType
    var makeupPoster: UIImage
    var money: String
    var rateImage: UIImage
    var rateNUm: String
    var detail: String
}

enum MakeupType: String, CaseIterable {
    case Face = "Face"
    case Eye = "Eye"
    case Lip = "Lip"
    case Brush = "Brush"
    case Others = "#"
}

let dataSouce: [[TouchMakeup]] = [
    [TouchMakeup(brand: "ARMANI BEAUTY", makeup: "Luminous Silk Foundation", makeupType: .Face, makeupPoster: #imageLiteral(resourceName: "Foundation"), money: "$64.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), rateNUm: "3K", detail: ""),
     TouchMakeup(brand: "IT COSMETICS", makeup: "CC+ Cream with SPF 50+", makeupType: .Face, makeupPoster: #imageLiteral(resourceName: "BBCream"), money: "$39.50", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), rateNUm: "3K", detail: ""),
     TouchMakeup(brand: "BOBBI BROWN", makeup: "Vitamin Enriched Face Base Priming Moisturizer", makeupType: .Face, makeupPoster: #imageLiteral(resourceName: "primer"), money: "$60.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "1K", detail: ""),
     TouchMakeup(brand: "LAURA MERCIER", makeup: "Translucent Loose Setting Powder", makeupType: .Face, makeupPoster: #imageLiteral(resourceName: "settingPowder"), money: "$39.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "8K", detail: "")],
    
    [TouchMakeup(brand: "CHARLOTTE TILBURY", makeup: "Luxury Eyeshadow Palette", makeupType: .Eye, makeupPoster: #imageLiteral(resourceName: "eyeshadow1"), money: "$53.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), rateNUm: "197", detail: ""),
     TouchMakeup(brand: "ANASTASIA BEVERLY HILLS", makeup: "Brow Wiz", makeupType: .Eye, makeupPoster: #imageLiteral(resourceName: "eyeBrowe"), money: "$23.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "14K", detail: ""),
     TouchMakeup(brand: "DIOR", makeup: "BACKSTAGE Eyeshadow Palette", makeupType: .Eye, makeupPoster: #imageLiteral(resourceName: "eyeShadow2"), money: "$49.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "191", detail: "")],
    
    [TouchMakeup(brand: "DIOR", makeup: "Dior Lip Glow", makeupType: .Lip, makeupPoster: #imageLiteral(resourceName: "lipGrow"), money: "$34.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), rateNUm: "5K", detail: ""),
     TouchMakeup(brand: "YVES SAINT LAURENT", makeup: "Tatouage Couture Velvet Cream Liquid Lipstick", makeupType: .Lip, makeupPoster: #imageLiteral(resourceName: "lipStick"), money: "$37.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "58", detail: ""),
     TouchMakeup(brand: "GIVENCHY", makeup: "Le Rouge Lipstick", makeupType: .Lip, makeupPoster: #imageLiteral(resourceName: "lipStick2"), money: "$38.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "649", detail: "")],
    
    [TouchMakeup(brand: "SEPHORA COLLECTION", makeup: "Ready To Roll Brush Set", makeupType: .Brush, makeupPoster: #imageLiteral(resourceName: "brushSet"), money: "$70.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "368", detail: ""),
     TouchMakeup(brand: "BEAUTYBLENDER", makeup: "Rosie Posie Blender Essentials Set", makeupType: .Brush, makeupPoster: #imageLiteral(resourceName: "sponge"), money: "$45.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_3_stars"), rateNUm: "22", detail: ""),
     TouchMakeup(brand: "SEPHORA COLLECTION", makeup: "PRO Bronzer Brush #80", makeupType: .Brush, makeupPoster: #imageLiteral(resourceName: "brush"), money: "$34.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_5_stars"), rateNUm: "6", detail: "")],
    
    [TouchMakeup(brand: "BEAUTYBLENDER", makeup: "liquid blendercleanser®", makeupType: .Others, makeupPoster: #imageLiteral(resourceName: "cleanser"), money: "$18.00", rateImage: #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), rateNUm: "906", detail: "")]
]

