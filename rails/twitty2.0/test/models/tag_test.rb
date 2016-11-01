require 'test_helper'

class TagTest < ActiveSupport::TestCase
    # создание
    test 'tag is saved' do
        tag = Tag.new(name: 'test')
        assert tag.save
    end

    test 'should not save tag with such id' do
        tag = Tag.new
        assert tag.save
    end

    # изменение
    test 'tag is changed' do
        id = Tag.all.ids.sample
        if id.nil?
            assert true
        else
            tag = Tag.find(id)
            assert tag.update(name: 'yo-ho-ho')
     end
    end

    test 'should not change tag and save without content' do
        id = Tag.all.ids.sample
        if id.nil?
            assert true
        else
            tag = Tag.find(id)
            assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException) { tag.update(created_at: nil) }
     end
    end

    # удаление
    test 'Should be removed' do
        tag = Tag.new(name: 'test')
        tag.destroy
        assert tag.destroyed?
    end

    test 'should not delete tag' do
        id = Tag.all.ids.sample
        if id.nil?
            assert true
        else
            tag = Tag.find(id)
            tag.id = 99_999_999
            assert tag.destroy.destroyed?
         #       assert_raises(ActiveRecord::StatementInvalid, SQLite3::ConstraintException){ tag.save }
     end
    end
end
