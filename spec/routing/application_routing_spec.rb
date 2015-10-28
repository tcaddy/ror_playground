require 'rails_helper'

RSpec.describe ApplicationController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/').to route_to('artists#index')
    end
  end
end
