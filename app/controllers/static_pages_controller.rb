class StaticPagesController < ApplicationController
  before_action :authenticate_user!, :except => [:home]

  def contact
  end
  
  def faq
  end

  def hiragana
  end

  def home
  end
end
