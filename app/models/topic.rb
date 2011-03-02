class Topic < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name,:content

  def user_name
    user.email if user
  end



end

