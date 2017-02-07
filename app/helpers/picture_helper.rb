module PictureHelper
  def random_img
    image_tag pictures.sample
  end

  def pictures
    %w(http://teachbase.ru/media/cache/6f/27/6f27e75f85b5f09ce0e5e17762ddb6d4.jpg
      http://teachbase.ru/media/cache/8e/5d/8e5dd645c78e94419c68c68c06aef39e.jpg
      http://teachbase.ru/media/cache/51/03/510358b5c6b99ae49840fce64e9f0dbf.jpg
      http://teachbase.ru/media/cache/f4/87/f4875ff378debd4c47e3f85097088f1c.jpg
      http://teachbase.ru/media/cache/51/ac/51ac495468ab73e0923f7038d73fe764.jpg)
  end
end