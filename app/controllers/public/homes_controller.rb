class Public::HomesController < ApplicationController
  def top
    @tag_lists = Tag.all
    @random_post = Post.all.shuffle.first
    @header_text = "E.antenna"
    @header_text_sub = "E.antennaへようこそ。このサイトはあなたの身近にあるemotionalな風景を共有できるサイトです。"
  end
end
