module Jekyll
  module LiquifyFilter
    def liquify(input)
      output = Liquid::Template.parse(input)
      output.render(@context)
    end
  end
end

Liquid::Template.register_filter(Jekyll::LiquifyFilter)