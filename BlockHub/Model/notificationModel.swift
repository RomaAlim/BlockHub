//
//  notificationModel.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation

struct NotificationTemplates {
    static let newsPush = [
        "🔥 Горячие новости! Не пропустите последние обновления в мире блокчейна.",
        "📢 Новая статья на нашем блоге: Узнайте больше!",
        "📰 Новости дня: важные события в блокчейн-технологиях."
    ]
    static let newCourse = [
        "🎓 Новый курс доступен:. Начните обучение сегодня!",
        "📘 Ваш любимый курс обновлен! Проверьте новые материалы.",
        "🔔 Напоминание: вы давно не заходили на наши курсы. Продолжите обучение!"
    ]
    static let myCourse = [
        "📈 Вы продвинулись в курсе! Продолжайте в том же духе.",
        "⏰ Напоминание: осталось немного до завершения курса.",
        "🏆 Отличная работа! Вы завершили курс. Получите свой сертификат."
    ]
    static let update = [
        "🚀 Новое обновление приложения! Улучшения и новые функции уже доступны.",
        "🛠️ Мы исправили ошибки и улучшили производительность. Обновите приложение для лучшего опыта.",
        "🎉 Новый интерфейс и функции! Проверьте обновления в вашем профиле."
    ]
    
}
func getRandomMessage(from templates: [String]) -> String {
    return templates.randomElement() ?? "Не пропустите важные обновления!"
}

