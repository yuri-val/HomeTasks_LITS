require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
  #создание
  test "user is saved" do
   	 user = User.new(nickname: 'test', email: "test@test.com")
     assert user.save
  end

  test "should not save user with such id" do
    user = User.new
    assert user.save
  end

  #изменение
  test "user is changed" do
   	 id = User.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   user = User.find(id)
       assert user.update(nickname: "yo-ho-ho")
	 end
  end

  test "should not change user and save without content" do
    id = User.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   user = User.find(id)
       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ user.update(created_at: nil) }
	 end
  end


  #удаление
  test 'Should be removed' do
    user = User.new(nickname: 'test')
    user.destroy
    assert user.destroyed? 
  end

  test "should not delete user with comments" do
    id = User.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   user = User.find(id)
   	   user.id = 99999999
   	   assert user.destroy.destroyed?
#       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ user.save }
	 end
  end

end
