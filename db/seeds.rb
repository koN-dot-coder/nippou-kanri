MEMBER_NAMES = [
  "田中 一郎", "鈴木 花子", "高橋 健太", "伊藤 美咲", "渡辺 翔",
  "山本 さくら", "中村 大輔", "小林 結衣", "加藤 拓也", "吉田 葵"
].freeze

DONE_TEXTS = [
  "A社を訪問し、新商品の提案資料を説明した。前向きな反応をもらえた",
  "見積書を3件作成して送付した。午後は既存顧客への電話フォロー",
  "社内の営業会議に参加し、今月の進捗を報告した",
  "C社の新しい担当者にあいさつに行き、これまでの取引を説明した",
  "展示会の準備。パンフレットの発注と、ブースの配置を決めた",
  "既存顧客5社に電話して、来月の発注予定を聞いた",
  "E社との契約書を確認して、法務に回した",
  "後輩の商談に同行して、ヒアリングの進め方を見せた",
  "先月の売上をまとめて、課長に報告した",
  "F社に新商品のサンプルを届けて、使い方を説明した"
].freeze

PLAN_TEXTS = [
  "C社への提案資料を仕上げる",
  "見積もりの返事が来ていない2社に電話する",
  "研修のふりかえりアンケートを集計する",
  "B社の発注書を確認して、在庫を手配する",
  "来週の訪問先のアポイントを取る",
  "展示会のチラシを最終確認する",
  "E社の契約書の修正点を確認する",
  "後輩と商談のふりかえりをする",
  "来月の売上目標の案を作る",
  "F社にサンプルの感想を聞く"
].freeze

TODAY_ATTENTION = [
  {
    done: "B社と打ち合わせ。納期を来週に前倒ししてほしいと相談された",
    trouble: "B社の納期が来週に前倒しになり、今の人数では間に合いそうにありません",
    condition: 4
  },
  {
    done: "新人研修の資料を直そうとしたが、半分しか進まなかった",
    trouble: nil,
    condition: 2
  },
  {
    done: "D社からの電話に対応。商品の不具合について話を聞いた",
    trouble: "D社からクレームの電話があり、どう返事をすればよいか迷っています",
    condition: 2
  }
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
    attrs = {
      done: DONE_TEXTS[n % DONE_TEXTS.size],
      plan: PLAN_TEXTS[n % PLAN_TEXTS.size],
      trouble: nil,
      condition: 3 + (n % 3)
    }
    attrs.merge!(TODAY_ATTENTION[i]) if date == today && i < 3

    report = member.daily_reports.find_or_create_by!(report_date: date) do |r|
      r.assign_attributes(**attrs, status: :submitted)
    end

    report.update_column(:submitted_at, date.in_time_zone.change(hour: 17, min: 30) + i * 7.minutes)
  end
end
