//
//  TaskTableViewCell.swift
//  Task Manager
//
//  Created by Adenilson Noronha da Silva Junior on 07/11/19.
//  Copyright © 2019 Adenilson Noronha da Silva Junior. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewTask: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(task: Task) {
        labelName.text = task.name
        labelDate.text = task.date
        labelLevel.text = String(task.level)
        
        if (task.done) {
            imageViewTask.image = UIImage(named: "ic_done.png")
        } else {
            imageViewTask.image = UIImage(named: "ic_todo.png")
        }
    }
}
