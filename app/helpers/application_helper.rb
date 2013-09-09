#coding: utf-8
module ApplicationHelper
  # 入力フォームのそれぞれのinputやtextarea等の要素に関するエラーを出力します
  def full_error_messages_for(obj, attribute, *args)
    if obj
      if obj.errors[attribute].count > 0
        options = args.extract_options!
        result = ''
        obj.errors[attribute].each_with_index do |error, count|
          result += t("activerecord.attributes.#{obj.class.name.tableize.singularize}.#{attribute}") + error
          result = result.html_safe
        end

        if options[:tag]
          content_tag(options[:tag], result, :class => options[:class], :id => options[:id])
        end
      end
    end
  end
end
