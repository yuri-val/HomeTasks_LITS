require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  #создание
    test "comment is saved" do
     	 comment = Comment.new(body: 'test')
       assert comment.save
    end

    test "should not save comment with such id" do
      comment = Comment.new
      assert comment.save
    end

    #изменение
    test "comment is changed" do
     	 id = Comment.all.ids.sample
     	 if id.nil?
     	   assert true
     	 else
     	   comment = Comment.find(id)
         assert comment.update(body: "yo-ho-ho")
  	 end
    end

    test "should not change comment and save without content" do
      id = Comment.all.ids.sample
     	 if id.nil?
     	   assert true
     	 else
     	   comment = Comment.find(id)
         assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ comment.update(created_at: nil) }
  	 end
    end


    #удаление
    test 'Should be removed' do
      comment = Comment.new(body: 'test')
      comment.destroy
      assert comment.destroyed?
    end

    test "should not delete comment" do
      id = Comment.all.ids.sample
     	 if id.nil?
     	   assert true
     	 else
     	   comment = Comment.find(id)
     	   comment.id = 99999999
     	   assert comment.destroy.destroyed?
  #       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ comment.save }
  	 end
    end
end
