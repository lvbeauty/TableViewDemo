//
//  Protocol.swift
//  Touch
//
//  Created by Tong Yi on 5/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit
protocol DataArrangeDelegate
{
    func addNewMakeup(data: TouchMakeup)
    func modifyExistMakeup(sec: Int, row: Int, data: TouchMakeup)
}
