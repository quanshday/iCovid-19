//
//  ConversationDelegate.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import Foundation

struct MessageDelegate {

    func responseTo(question: String) -> String {
        let lowerQuestion = question.lowercased()
        
        if lowerQuestion.hasPrefix("xin chao") {
            return "Xin chào"
        } else if lowerQuestion.hasPrefix("chao") {
            return "Xin chào"
        } else if lowerQuestion.hasPrefix("alo") {
            return "Xin chào"
        } else if lowerQuestion.hasPrefix("hello") {
            return "Xin chào"
        } else if lowerQuestion.hasPrefix("hi") {
            return "Xin chào"
        } else if lowerQuestion.hasPrefix("cam on") {
            return "Cám ơn bạn!"
        } else if lowerQuestion.hasPrefix("khoe khong") {
            return "Cám ơn bạn, tôi khỏe bạn nhớ chú ý đến \nsức khỏe nhé!"
        } else if lowerQuestion == "toi can giup do" {
            return "Bạn cần tôi giúp về vấn đề gì?"
        } else if lowerQuestion.hasPrefix("o dau") {
            return "Tôi ở Huế"
        } else if lowerQuestion.hasPrefix("dia phuong") {
            return "Bạn có thể gọi trực tiếp cho chúng tôi để \nhỗ trợ bạn"
        } else if lowerQuestion.hasPrefix("covid") {
            return "Tình hình đang căng thẳng nên bạn tuân thủ \n5K nhé!"
        } else if lowerQuestion.hasPrefix("vac xin") {
            return "Hiện nay nhà nước đang thử nghiệm và tiêm \nvác xin cho những địa phương có nguy cơ \nbùng phát mạnh"
        } else {
            let defaultNumber = question.count % 3
            
            if defaultNumber == 0 {
                return "Tôi không hiều"
            } else if defaultNumber == 1 {
                return "Bạn vui lòng hỏi lại"
            } else {
                return "Tôi không hiểu câu hỏi của bạn"
            }
        }
    }
}
