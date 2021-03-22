require 'delivery/models/language'
require 'delivery/responses/response_base'

module Kentico
  module Kontent
    module Delivery
      module Responses
        # The response of a successful query for project languages.
        class DeliveryLanguageListingResponse < ResponseBase
          # Parses the 'pagination' JSON node of the response.
          #
          # * *Returns*:
          #   - Kentico::Kontent::Delivery::Pagination
          def pagination
            @pagination unless @pagination.nil?
            @pagination = Pagination.new @response['pagination']
          end

          # Parses the 'languages' JSON node of the response from a
          # Kentico::Kontent::Delivery::DeliveryClient.languages call.
          #
          # * *Returns*:
          #   - +Array+ The content types as Kentico::Kontent::Delivery::Language objects
          def languages
            @languages unless @languages.nil?
            languages = []
            @response['languages'].each do |n|
              languages << Kentico::Kontent::Delivery::Language.new(n)
            end
            @languages = languages
          end

          def initialize(headers, body)
            @response = JSON.parse(body)
            super 200,
                  "Success, #{languages.length} languages returned",
                  headers,
                  JSON.generate(@response)
          end
        end
      end
    end
  end
end
