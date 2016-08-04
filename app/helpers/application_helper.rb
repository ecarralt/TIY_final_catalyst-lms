module ApplicationHelper

  extensions = {
    autolink: true, ##parse links even when they are not enclosed in <> characters. Autolinks for the http, https and ftp protocols will be automatically detected. Email addresses and http links without protocol, but starting with www are also handled.
    no_intra_emphasis: true, ##do not parse emphasis inside of words. Strings such as foo_bar_baz will not generate <em> tags.
    fenced_code_blocks: true ##parse fenced code blocks, PHP-Markdown style. Blocks delimited with 3 or more ~ or backticks will be considered as code, without the need to be indented. An optional language name may be added at the end of the opening fence for the code block.
  }

  render_options = {
    filter_html: true, ##do not allow any user-inputted HTML in the output.
    hard_wrap: true ##insert HTML <br> tags inside paragraphs where the original Markdown document had newlines (by default, Markdown ignores these newlines).
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
