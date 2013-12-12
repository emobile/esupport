require 'helper'

class ImmigrantTest < ActiveSupport::TestCase
  include TestMethods

  class MockModel < ActiveRecord::Base
    self.abstract_class = true
    class << self
      def primary_key
        connection.primary_key(table_name)
      end
      def connection
        @connection ||= MockConnection.new
      end
    end
  end
  
  class MockConnection
    def supports_primary_key? # AR <3.2
      true
    end
    def primary_key(table)
      table !~ /s_.*s\z/ ? 'id' : nil
    end
  end

  def teardown
    subclasses = ActiveSupport::DescendantsTracker.direct_descendants(MockModel)
    subclasses.each do |subclass|
      ImmigrantTest.send(:remove_const, subclass.to_s.sub(/.*::/, ''))
    end
    subclasses.replace([])
  end


  # basic scenarios
  
  test 'belongs_to should generate a foreign key' do
    class Author < MockModel; end
    class Book < MockModel
      belongs_to :guy, :class_name => 'Author', :foreign_key => 'author_id'
    end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'has_one should generate a foreign key' do
    class Author < MockModel
      has_one :piece_de_resistance, :class_name => 'Book', :order => "id DESC"
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'has_one :dependent => :delete should generate a foreign key with :dependent => :delete' do
    class Author < MockModel
      has_one :book, :order => "id DESC", :dependent => :delete
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => :delete
       )],
      keys
    )
  end

  test 'has_many should generate a foreign key' do
    class Author < MockModel
      has_many :babies, :class_name => 'Book'
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'has_many :dependent => :delete_all should generate a foreign key with :dependent => :delete' do
    class Author < MockModel
      has_many :books, :dependent => :delete_all
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => :delete
       )],
      keys
    )
  end

  test 'has_and_belongs_to_many should generate two foreign keys' do
    class Author < MockModel
      has_and_belongs_to_many :fans
    end
    class Fan < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Fan]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'authors_fans', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       ),
       foreign_key_definition(
         'authors_fans', 'fans',
         :column => 'fan_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'has_and_belongs_to_many should respect the join_table' do
    class Author < MockModel
      has_and_belongs_to_many :fans, :join_table => :lol_wuts
    end
    class Fan < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Fan]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'lol_wuts', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       ),
       foreign_key_definition(
         'lol_wuts', 'fans',
         :column => 'fan_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'conditional has_one/has_many associations should ignore :dependent' do
    class Author < MockModel
      has_many :articles, :conditions => "published", :dependent => :delete_all
      has_one :favorite_book, :class_name => 'Book',
              :conditions => "most_awesome", :dependent => :delete
    end
    class Book < MockModel; end
    class Article < MockModel; end

    keys = Immigrant.infer_keys([], [Article, Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'articles', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       ),
       foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end


  # (no) duplication
  
  test 'STI should not generate duplicate foreign keys' do
    class Company < MockModel; end
    class Employee < MockModel
      belongs_to :company
    end
    class Manager < Employee; end

    assert(Manager.reflections.present?)
    keys = Immigrant.infer_keys([], [Company, Employee, Manager]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'employees', 'companies',
         :column => 'company_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'complementary associations should not generate duplicate foreign keys' do
    class Author < MockModel
      has_many :books
    end
    class Book < MockModel
      belongs_to :author
    end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'redundant associations should not generate duplicate foreign keys' do
    class Author < MockModel
      has_many :books
      has_many :favorite_books, :class_name => 'Book', :conditions => "awesome"
      has_many :bad_books, :class_name => 'Book', :conditions => "amateur_hour"
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end


  # skipped associations

  test 'associations should not generate foreign keys if they already exist, even if :dependent/name are different' do
    database_keys = [
      foreign_key_definition(
        'articles', 'authors',
        :column => 'author_id', :primary_key => 'id', :dependent => nil,
        :name => "doesn't_matter"
      ),
      foreign_key_definition(
        'books', 'authors', :column => 'author_id', :primary_key => 'id',
        :dependent => :delete
      )
    ]

    class Author < MockModel
      has_many :articles
      has_one :favorite_book, :class_name => 'Book',
              :conditions => "most_awesome"
    end
    class Book < MockModel; end
    class Article < MockModel; end

    keys = Immigrant.infer_keys(database_keys, [Article, Author, Book]).first
    assert_equal([], keys)
  end

  test 'finder_sql associations should not generate foreign keys' do
    class Author < MockModel
      has_many :books, :finder_sql => <<-SQL
        SELECT *
        FROM books
        WHERE author_id = \#{id}
        ORDER BY RANDOM() LIMIT 5'
      SQL
    end
    class Book < MockModel; end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_equal([], keys)
  end

  test 'polymorphic associations should not generate foreign keys' do
    class Property < MockModel
      belongs_to :owner, :polymorphic => true 
    end
    class Person < MockModel
      has_many :properties, :as => :owner
    end
    class Corporation < MockModel
      has_many :properties, :as => :owner
    end

    keys = Immigrant.infer_keys([], [Corporation, Person, Property]).first
    assert_equal([], keys)
  end

  test 'has_many :through should not generate foreign keys' do
    class Author < MockModel
      has_many :authors_fans
      has_many :fans, :through => :authors_fans
    end
    class AuthorsFan < MockModel
      belongs_to :author
      belongs_to :fan
    end
    class Fan < MockModel
      has_many :authors_fans
      has_many :authors, :through => :authors_fans
    end

    keys = Immigrant.infer_keys([], [Author, AuthorsFan, Fan]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'authors_fans', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       ),
       foreign_key_definition(
         'authors_fans', 'fans',
         :column => 'fan_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end

  test 'broken associations should not cause errors' do
    class Author < MockModel; end
    class Book < MockModel
      belongs_to :author
      belongs_to :invalid
    end

    keys = Immigrant.infer_keys([], [Author, Book]).first
    assert_nothing_raised { keys.map { |key| key.to_ruby(:add) } }
    assert_equal(
      [foreign_key_definition(
         'books', 'authors',
         :column => 'author_id', :primary_key => 'id', :dependent => nil
       )],
      keys
    )
  end
end
