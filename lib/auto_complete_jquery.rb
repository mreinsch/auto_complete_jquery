module AutoCompleteJquery

  def self.included(base)
    base.extend(ClassMethods)
  end

  #
  # Example:
  #
  #   # Controller
  #   class BlogController < ApplicationController
  #     auto_complete_for :post, :title
  #   end
  #
  # By default, auto_complete_for limits the results to 10 entries,
  # and sorts by the given field.
  #
  # auto_complete_for takes a third parameter, an options hash to
  # the find method used to search for the records:
  #
  #   auto_complete_for :post, :title, :limit => 15, :order => 'created_at DESC'
  #
  # You can also use named scopes to limit the search results. Two types of
  # named scopes are supported.
  #
  # 1) Without parameters:
  #
  #    auto_complete_for :post, :title, :scope => :red
  #    named_scope :red, conditions => {color: => 'red'}
  #
  # This will use Post.red.find(:all, ...) to lookup the post titles.
  #
  # 2) With the current_user as parameter:
  #
  #    auto_complete_for :post, :title, :user_scope => :author
  #    named_scope :author, lambda { |user|
  #      { :conditions => { :author_id => user } }
  #    }
  #
  # This would use Post.author(current_user).find(:all, ...) to lookup the 
  # post titles. 
  #
  # For more on jQuery auto-complete, see the docs for the jQuery autocomplete
  # plugin used in conjunction with this plugin:
  # * http://www.dyve.net/jquery/?autocomplete
  module ClassMethods
    def auto_complete_for(object, method, options = {})
      object_constant = object.to_s.camelize.constantize
      scope = options.delete(:scope)
      user_scope = options.delete(:user_scope)

      finder = scope.nil? ? object_constant : object_constant.send(scope)
      generic_find_options = {
        :order => "#{method} ASC",
        :select => "#{object_constant.table_name}.#{method}",
        :limit => 10 }.merge!(options)
      
      define_method("auto_complete_for_#{object}_#{method}") do
        if params[:q].blank?
          render :text => ""
          return
        end

        find_options = generic_find_options.clone
        find_options[:conditions] = [ "LOWER(#{method}) LIKE ?", '%' + params[:q].downcase + '%' ]
        find_options[:limit] = [find_options[:limit], params[:limit].to_i].min if params[:limit]

        render :text => (user_scope.nil? ? finder : finder.send(user_scope, current_user)).
          find(:all, find_options).collect(&method).join("\n")
      end
    end
  end

end
