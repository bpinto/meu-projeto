module UsersHelper
   def link_to_active(*args, &block)
    if block_given?
      options = args.first || {}
      html_options = args.second
      link_to_active(capture(&block), options, html_options)
    else
      name = args[0]
      options = args[1] || {}
      html_options = args[2]
      link_to_unless_current(name, options, html_options) do
        link_to(name, options, html_options.try(:merge, :class => :ativo) || {:class => :ativo})
      end
    end
  end
end
