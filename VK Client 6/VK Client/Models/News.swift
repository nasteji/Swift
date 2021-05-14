//
//  News.swift
//  VK Client
//
//  Created by Анастасия Живаева on 19.03.2021.
//

import Foundation

class News {
    var sourceName: String
    var sourceImage: String?
    var date: String
    var textNews: String
    var imageNews: String

    init(sourceName: String, sourceImage: String?, date: String, textNews: String, imageNews: String) {
        self.sourceName = sourceName
        self.sourceImage = sourceImage
        self.date = date
        self.textNews = textNews
        self.imageNews = imageNews
    }
}

extension News {
    
    static var news1 = News(sourceName: "Анна", sourceImage: "дама", date: "08.03.21 12:30", textNews: "Сумасшедший день! Я так устала, есть у кого-нибудь лишние вазы?", imageNews: "цветы")
    static var news2 = News(sourceName: "Бобби", sourceImage: "губкабоб", date: "10.03.21 16:02", textNews: "Просвещайтесь ребята: Губки не имеют настоящих тканей и органов, и различные функции выполняют разнообразные отдельные клетки и клеточные пласты. Питание большинства видов осуществляется путём фильтрации воды, прогоняемой через расположенную внутри тела губки водоносную систему различной сложности. Изнутри значительную часть водоносной системы выстилают особые клетки со жгутиком и воротничком из микроворсинок — хоаноциты, составляющие в совокупности хоанодерму; остальная часть водоносной системы и внешние покровы образованы пластом пинакоцитов (пинакодермой). Между пинакодермой и хоанодермой расположен мезохил — слой внеклеточного матрикса, содержащий разнообразные по строению и выполняемым функциям отдельные клетки. У многих губок в мезохиле обитают эндосимбиотические прокариоты (бактерии и археи).", imageNews: "губка")
    static var news3 = News(sourceName: "Рик", sourceImage: "рик", date: "14.03.21 01:45", textNews: "Я огурчик!", imageNews: "огурчик")
    
    static func fake() -> [News] {
        return [news1, news2, news3]
    }
}
