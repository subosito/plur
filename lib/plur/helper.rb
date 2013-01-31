# encoding: utf-8
require 'active_support'

module Plur
  module Helper

    def current_locale
      I18n.locale.to_s
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
      splitted = controller.class.name.split('::').pop
      splitted.blank? ? nil : splitted.first.downcase
    end

    def body_attributes
      classes  = []
      classes << [controller_name, action_name].join('-')
      classes << namespace_name

      { class: classes.join(' ') }
    end

    def build_html(assigns = {}, &block)
      Mab::PrettyBuilder.new(assigns, self, &block).to_s.html_safe
    end
  end
end

ActiveSupport.on_load(:action_view) { include Plur::Helper }

