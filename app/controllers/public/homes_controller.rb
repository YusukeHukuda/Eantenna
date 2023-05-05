class Public::HomesController < ApplicationController
  def top
    @tag_lists = Tag.all
  end

  def about
  end
end
