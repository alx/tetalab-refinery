module ApplicationHelper

  def blog_post_teaser(post)
    if post.respond_to?(:custom_teaser) && post.custom_teaser.present?
     post.custom_teaser.html_safe
    else
     truncate(post.body, {
       :length => RefinerySetting.find_or_set(:blog_post_teaser_length, 250),
       :preserve_html_tags => true
      }).html_safe
    end
  end
  
end
