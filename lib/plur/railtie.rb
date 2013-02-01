require 'plur/helpers/view'

module Plur
  class Railtie < ::Rails::Railtie
    initializer 'plur.view_helpers' do
      ActionView::Base.send :include, Plur::Helpers::View
    end
  end
end
