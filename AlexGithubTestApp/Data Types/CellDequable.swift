//
//  CellDequable.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

protocol CellDequable {
    func register<Cell: AnyObject>(_ cell: Cell.Type) where Cell: Identifiable
    func registerNib<Cell>(_ cell: Cell.Type) where Cell: Identifiable
    func dequeue<Cell>(_ cell: Cell.Type, at indexPath: IndexPath) -> Cell where Cell: Identifiable
}

extension UITableView: CellDequable {
    
    func register<Cell: AnyObject>(_ cell: Cell.Type) where Cell: Identifiable {
        self.register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func registerNib<Cell>(_ cell: Cell.Type) where Cell: Identifiable {
        let nib = UINib(nibName: Cell.identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeue<Cell>(_ cell: Cell.Type, at indexPath: IndexPath) -> Cell where Cell : Identifiable {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! Cell
    }
}

