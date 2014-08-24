# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Status.all.empty?
  Status.create([
    { name: 'new' },
    { name: 'in_process' },
    { name: 'confirmed' },
    { name: 'rejected', is_final: true },
    { name: 'fixed', is_final: true }
  ])
end

if Category.all.empty?
  Category.create([
      { title: 'Дорожное движение', description: 'Не работающие светофоры, ямы на дорогах и т.п.', icon: 'road' },
      { title: 'Благоустройство', description: 'Граффити, сломанные бордюры и т.п.', icon: 'leaf' },
      { title: 'Доступная среда', description: 'Отсутствие пандуса и т.п.', icon: 'wheelchair' },
      { title: 'Нарушение правил торговли', description: 'Нелегальные точки продажи алкоголя и т.п.', icon: 'shopping-cart' }
  ])
end