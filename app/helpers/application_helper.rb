module ApplicationHelper

  extensions = {
    autolink: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true
  }

  render_options = {
    filter_html: true,
    hard_wrap: true
  }


  renderer = Redcarpet::Render::HTML.new(render_options)
  @@r = Redcarpet::Markdown.new(renderer, extensions)

  def markdown(text)
    return @@r.render(text).html_safe
  end


  # markdown = Redcarpet::Markdown.new(renderer, extensions{})
  #
  #   options = {hard_wrap: true,
  #     filter_html: true,
  #     autolink: true,
  #     no_intra_emphasis: true,
  #     fenced_code_blocks: true}
  # end


end
