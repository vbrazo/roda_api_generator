module Api
  module Operations
    class UserService
      def initialize(params)
        @params = params
      end

      attr_reader :params

      def show_params
        params['email']
      end
    end
  end
end
