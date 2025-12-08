# config/initializers/pagy.rb

# 載入 Pagy 的基本功能
require 'pagy/extras/bootstrap'  # 使用 Bootstrap UI
require 'pagy/extras/overflow'   # 處理溢出頁碼

# Pagy 配置
Pagy::DEFAULT[:items] = 20       # 每頁顯示項目數
Pagy::DEFAULT[:overflow] = :last_page # 溢出時重定向到最後一頁