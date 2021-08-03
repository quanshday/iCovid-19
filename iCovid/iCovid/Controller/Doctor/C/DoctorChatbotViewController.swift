//
//  DoctorChatbotViewController.swift
//  iCovid
//
//  Created by Mac on 30/07/2021.
//

import UIKit

class DoctorChatbotViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let questionAnswerer = MessageDelegate()
    let conversationSource = MessageDataSource()
    
    private let thinkingTime: TimeInterval = 2
    var isThinking = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnswerTableViewCell.nib(), forCellReuseIdentifier: AnswerTableViewCell.identifier)
        tableView.register(QuestionTableViewCell.nib(), forCellReuseIdentifier: QuestionTableViewCell.identifier)
        tableView.register(WaitingTableViewCell.nib(), forCellReuseIdentifier: WaitingTableViewCell.identifier)
        tableView.register(AskTableViewCell.nib(), forCellReuseIdentifier: AskTableViewCell.identifier)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func question(_ questionText: String){
        
        isThinking = true
        let countBefore = conversationSource.messageCount
        conversationSource.add(question: questionText)
        let count = conversationSource.messageCount
        var questionPath: IndexPath?
        if count != countBefore {
            questionPath = IndexPath(row: count - 1, section: ConversationSection.history.rawValue)
        }
        tableView.insertRows(at: [questionPath, ConversationSection.thinkingPath].compactMap { $0 }, with: .bottom)
        tableView.scrollToRow(at: ConversationSection.askPath, at: .bottom, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + thinkingTime) {
            self.isThinking = false
            let answer = self.questionAnswerer.responseTo(question:  questionText)
            let countBefore = self.conversationSource.messageCount
            self.conversationSource.add(answer: answer)
            let count = self.conversationSource.messageCount
            self.tableView.beginUpdates()
            if count != countBefore {
                self.tableView.insertRows(at: [IndexPath(row:count - 1, section: ConversationSection.history.rawValue)], with: .fade)
            }
            self.tableView.deleteRows(at: [ConversationSection.thinkingPath], with: .fade)
            self.tableView.endUpdates()
            self.tableView.scrollToRow(at: ConversationSection.askPath, at: .bottom, animated: true)
        }
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DoctorChatbotViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ConversationSection.sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ConversationSection(rawValue: section)! {
        case .history:
            return conversationSource.messageCount
        case .thinking:
            return isThinking ? 1 : 0
        case .ask:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ConversationSection(rawValue: indexPath.section)! {
        case .history:
            let message = conversationSource.messageAt(index: indexPath.row)
            
            switch message.type {
            case .question:
                let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier) as! QuestionTableViewCell
                
                cell.configureWithMessage(message)
                return cell
            case .answer:
                let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier) as! AnswerTableViewCell
                cell.configureWithMessage(message)
                return cell
            }
            
        case .thinking:
            let cell = tableView.dequeueReusableCell(withIdentifier: WaitingTableViewCell.identifier, for: indexPath) as! WaitingTableViewCell
            cell.waitingImageView.startAnimating()
            return cell
        case .ask:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AskTableViewCell.identifier, for: indexPath) as! AskTableViewCell
            
            if cell.questionTextField.delegate == nil{
                    cell.questionTextField.becomeFirstResponder()
                    cell.questionTextField.delegate = self
                }
            
            
            return cell
        }
    }
    
    
}

extension DoctorChatbotViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DoctorChatbotViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        
        if isThinking{
            return false
        }

        if text == ""{
            
//            AlertView.shared.showAlert()
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập câu hỏi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            textField.text = nil
            question(text)
            
        }
        return false
    }
}

extension DoctorChatbotViewController{
    enum ConversationSection: Int{
        case history = 0
        case thinking = 1
        case ask = 2
        
        static var sectionCount: Int{
            return self.ask.rawValue + 1
        }
        
        static var allSections: IndexSet{
            return IndexSet(integersIn: 0..<sectionCount)
        }
        
        static var askPath: IndexPath{
            return IndexPath(row: 0, section: self.ask.rawValue)
        }
        
        static var thinkingPath: IndexPath{
            return IndexPath(row: 0, section: self.thinking.rawValue)
        }
    }
}
