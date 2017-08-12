require 'builder'

module LayoutHelper
  # Monta uma tag <span> com atributos +data+ preparados para montar um componente React.
  #
  # @param [String] name o nome do componente React
  # @param [Object] props as propriedades
  def react_component(name, props = {}, &block)
    content_tag(:span, nil, data: { react_class: name, react_props: props }, &block)
  end
end