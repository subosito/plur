# encoding: utf-8
require 'mab'

module Plur
  module Helpers
    module View
      def current_locale
        I18n.locale.to_s
      end

      def rtl_locales
        %w(ar ckb fa he ug)
      end

      def rtl?
        rtl_locales.include? current_locale
      end

      def orientation
        rtl? ? 'rtl' : 'ltr'
      end

      def notifications
        return if flash.blank?

        map_classes = {
          notice: 'alert-success',
          alert: 'alert-error'
        }

        build_html do
          div class: 'notifications' do
            flash.each do |name, msg|
              if msg.is_a? String
                classes = ['alert', map_classes[name]]
                div msg, class: classes.join(' ')
              end
            end
          end
        end
      end

      def namespace_name
        splitted = controller.class.name.split('::')
        (splitted.size > 1) ? splitted.first.downcase : nil
      end

      def body_attributes
        classes  = []
        classes << [controller_name, action_name].join('-')
        classes << namespace_name unless namespace_name.nil?
        classes << orientation

        { dir: orientation, class: classes.join(' ') }
      end

      def build_html(assigns = {}, &block)
        ::Mab::PrettyBuilder.new(assigns, self, &block).to_s.html_safe
      end
    end
  end
end

