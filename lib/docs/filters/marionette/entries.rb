module Docs
  class Marionette
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        name = at_css('h1').content.strip
        name.remove!(/Marionette./)
        name = name[0].upcase + name.from(1)
        name
      end

      def get_type
        name
      end

      def additional_entries
        if slug == 'marionette.behavior'
          css('#documentation-index + ul a[href="#api"] + ul a').map do |node|
            ["#{name}: #{node.content}", node['href'].remove('#')]
          end
        else
          css('#documentation-index + ul a').each_with_object [] do |node, entries|
            content = node.content.strip
            content.remove! '\'s'
            id = node['href'].remove('#')
            if content.start_with?(name) || content.start_with?('Marionette.')
              entries << [content, id]
            elsif content =~ /\A"?[a-z]/
              entries << ["#{name} #{content}", id]
            end
          end
        end
      end
    end
  end
end
