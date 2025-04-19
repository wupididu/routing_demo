# Приложение для демонтстрации работы с навигацией

Приложение, похожее на интернет магазин
Навигация следующего вида
@startuml
[*] --> LoginPage
[*] --> HomePage

LoginPage --> RegisterPage

HomePage --> ShopPage
HomePage --> CartPage
HomePage --> ProfilePage

ShopPage --> ItemPage
CartPage --> ItemPage
ItemPage --> FeedbacksItemPage

ProfilePage --> OrdersPage
ProfilePage --> SettingsPage
@enduml

HomePage - это страница с боттомшит наигацией табами ShopPage, CartPage и ProfilePage
ShopPage, CartPage и ProfilePage - это вложенная навигация. Используй для этого вложенный Navigator

LoginPage должен открываться автоматически, если пользователь разлогинен

Используй для навигации Navigator 1.0
Экраны должны быть супер простые.
Код должен быть минималистичен и читаем. Не пиши много кода