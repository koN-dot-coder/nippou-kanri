MEMBER_NAMES = [
  "田中 一郎", "鈴木 花子", "高橋 健太", "伊藤 美咲", "渡辺 翔",
  "山本 さくら", "中村 大輔", "小林 結衣", "加藤 拓也", "吉田 葵"
].freeze

DONE_TEXTS = [
  "A社を訪問し、新商品の提案資料を説明した。前向きな反応をもらえた",
  "見積書を3件作成して送付した。午後は既存顧客への電話フォロー",
  "新人研修の2日目を担当。名刺交換とヒアリングの練習をした",
  "B社の担当者と打ち合わせ。来月の発注量について相談した",
  "社内の営業会議に参加し、今月の進捗を報告した"
].freeze

PLAN_TEXTS = [
  "C社への提案資料を仕上げる",
  "見積もりの返事が来ていない2社に電話する",
  "研修のふりかえりアンケートを集計する",
  "B社の発注書を確認して、在庫を手配する",
  "来週の訪問先のアポイントを取る"
].freeze

TODAY_TROUBLES = [
  "B社の納期が来週に前倒しになり、今の人数では間に合いそうにありません",
  "新人の研修資料が古いままで、質問にうまく答えられていません",
  "D社からクレームの電話があり、どう返事をすればよいか迷っています"
].freeze

team = Team.find_or_create_by!(name: "営業1課")

User.find_or_create_by!(email: "boss@example.com") do |u|
  u.assign_attributes(name: "佐藤 課長", team:, role: :manager, password: "password")
end

members = (1..10).map do |i|
  User.find_or_create_by!(email: "member#{i}@example.com") do |u|
    u.assign_attributes(name: MEMBER_NAMES[i - 1], team:, role: :member, password: "password")
  end
end

today = Date.current
dates = (today - 13...today).select(&:on_weekday?) << today

dates.each do |date|
  members.each_with_index do |member, i|
    next if date == today && i >= 8

    n = i + date.day
    if date == today && i < 3
      trouble = TODAY_TROUBLES[i]
      condition = 2
    else
      trouble = nil
      condition = 3 + (n % 3)
    end

    member.daily_reports.find_or_create_by!(report_date: date) do |report|
      report.assign_attributes(
        done: DONE_TEXTS[n % DONE_TEXTS.size],
        plan: PLAN_TEXTS[n % PLAN_TEXTS.size],
        trouble:,
        condition:,
        status: :submitted
      )
    end
  end
end