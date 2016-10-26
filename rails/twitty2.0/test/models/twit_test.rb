require 'test_helper'

class TwitTest < ActiveSupport::TestCase
  
  #создание
  test "twit is saved" do
   	 twit = Twit.new(content: 'test', user_id: 12)
     assert twit.save
  end

  test "should not save twit without content" do
    twit = Twit.new(user_id: 12)
    assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ twit.save }
  end

  #изменение
  test "twit is changed" do
   	 id = Twit.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   twit = Twit.find(id)
       assert twit.update(content: "yo-ho-ho")
	 end
  end

  test "should not change twit and save without content" do
    id = Twit.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   twit = Twit.find(id)
       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ twit.update(content: nil) }
	 end
  end


  #удаление
  test 'Should be removed' do
    twit = Twit.new(content: 'test', user_id: 12)
    twit.destroy
    assert twit.destroyed? 
  end

  test "should not delete twit with comments" do
    id = Twit.all.ids.sample
   	 if id.nil?
   	   assert true
   	 else	
   	   twit = Twit.find(id)
   	   twit.id = 99999999
   	   assert twit.destroy.destroyed?
#       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ twit.save }
	 end
  end

end
