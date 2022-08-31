class HtmlBuilder
  attr_reader :text

  def initialize(&block)
    @result = "<html>\n"
    @space = 1
    block.call(self) if block_given?
  end

  def html_doc!
    @result += "</html>\n"
  end

  private

  def method_missing(tag, *args, class_name: nil, &block)
    @result += ' ' * 2 * @space + "<#{tag}>"
    @result += 'class=' + "\"#{class_name}\"" unless class_name.nil?
    @result += "#{args.first}" if args.any?
    if block_given?
      @space += 1
      @result += "\n"
      block.call(self)
      @space -= 1
    end

    if args.any? || block_given?
      @result += ' ' * 2 * @space if block_given?
      @result += "</#{tag}>"
    end
    @result += "\n"
  end
end

html_builder = HtmlBuilder.new do |html|
  html.body do |body|
    body.h1('Hello!', class_name: 'h1-formatted margin-10')

    body.p('This is paragraph') do |p|
      p.p('Paragraph inside paragraph')
    end

    body.div('New div element') do |div|
      div.p('Paragraph in div')
    end

    body.div(class_name: 'empty-div')
  end
end


puts html_builder.html_doc!
