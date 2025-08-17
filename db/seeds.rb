require "stringio"

# ユーザー作成
users = 5.times.map do |i|
  User.find_or_create_by!(email: "tanaka#{i + 1}@test") do |user|
    user.name = "tanaka#{i + 1}"
    user.password = "password"
  end
end

# カテゴリ
%w[家電 家具 インテリア].each { |name| Category.find_or_create_by!(name: name) }

# カテゴリと画像リストの対応
category_images = {
  "家電"       => %w[kaden-1.jpeg kaden-2.jpeg kaden-3.jpeg kaden-4.jpeg],
  "家具"       => %w[kagu-1.jpeg kagu-2.jpeg kagu-3.jpeg kagu-4.jpeg],
  "インテリア" => %w[interior-1.jpeg interior-2.jpeg]
}

# 画像のベースパス
fixtures_dir = Rails.root.join("db", "fixtures")

# 投稿は毎回更新
category_images.each do |category_name, images|
  category = Category.find_by!(name: category_name)

  images.each_with_index do |filename, idx|
    path = fixtures_dir.join(filename)
    unless File.exist?(path)
      puts "⚠️  画像が見つかりません: #{path}"
      next
    end

    post = Post.find_or_initialize_by(title: "#{category_name}の投稿#{idx + 1}")
    post.assign_attributes(
      body:   "#{category_name}カテゴリのサンプル投稿です（#{filename}）。",
      category: category,
      user:   users.sample,
      rating: rand(1..5)
    )
    post.save!  # 先に保存してIDを確定

    # 画像を毎回付け直す（StringIOで閉じたストリーム問題を回避）
    post.image.purge if post.image.attached?
    data = File.binread(path)
    io   = StringIO.new(data)
    content_type =
      case File.extname(filename).downcase
      when ".jpg", ".jpeg" then "image/jpeg"
      when ".png"          then "image/png"
      else "application/octet-stream"
      end
    post.image.attach(io: io, filename: filename, content_type: content_type)

    puts "✅ 上書き保存: #{post.title}（#{filename}） by #{post.user.name} ⭐#{post.rating}"
  end
end

puts "---- まとめ ----"
puts "カテゴリ数: #{Category.count}"
puts "投稿数:     #{Post.count}"
puts "ユーザー数: #{User.count}"