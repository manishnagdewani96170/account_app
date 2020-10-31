# frozen_string_literal: true
module API::V1
  module Concerns
    module DefaultHelpers
      extend ActiveSupport::Concern
     
      included do
        helpers do

          def declared_params
            @declared_params ||= declared(params, include_missing: false)
          end

        end
      end
    end
  end
end
