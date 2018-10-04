class ApiSupport
  route do |r|
    r.root do
      'Nothing Here'
    end

    r.on 'example' do
      r.get do
        begin
          params = request.params
        rescue StandardError
          params = JSON.parse(request.body.read)
        end

        user = Api::Operations::UserService.new(params)
        user.show_params
      end
    end
  end
end
