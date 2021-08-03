//
//  Message.swift
//  iCovid
//
//  Created by Mac on 31/07/2021.
//

import Foundation

    enum MessageType {
        case question
        case answer
    }

    struct Message {
        let date: Date
        let text: String
        let type: MessageType
    }

    let openingLine = Message(date: Date(), text: "Xin chào, tôi là bác sỹ. Bạn cần giúp \nvề vấn đề gì?", type: .answer)

