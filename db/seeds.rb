10.times do |index|
  name = Faker::Name.name
  email = "test#{index}@test.com"
  password = 'test123'

  User.create(username: name, email: email, password: password) unless User.find_by email: email
end

20.times do
  user_id = User.ids.sample
  title = Faker::Hipster.sentence(word_count: 3)
  content = Faker::Lorem.paragraph(sentence_count: 20, supplemental: true, random_sentences_to_add: 4)
  status = Article::VALID_STATUES.sample

  Article.create user_id: user_id, title: title, content: content, status: status
end

Article.all.collect do |article|
  10.times do
    user_id = User.ids.sample
    body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
    status = Comment::VALID_STATUES.sample

    Comment.create user_id: user_id, body: body, status: status, commentable_type: article.class.to_s,
                   commentable_id: article.id
  end
end
