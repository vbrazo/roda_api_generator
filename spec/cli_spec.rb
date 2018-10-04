RSpec.describe ApiGenerators::CLI do
  describe '#start' do
    context 'given valid params' do
      it 'execute commands' do
        group_output = capture(:stdout) { ApiGenerators::CLI.start(%w(roda --name=project_name)) }

        expect(group_output.scan('project_name').size).to be > 0
      end

      it 'shows help message', :aggregate_failures do
        group_output = capture(:stdout) { ApiGenerators::CLI.start(%w(help)) }

        aggregate_failures 'accurate_help_output' do
          expect(group_output).to include('help [COMMAND]')
          expect(group_output).to include('roda')
          expect(group_output).to include('sinatra')
        end
      end
    end

    context 'given invalid params' do
      it 'shows help message' do
        group_output = capture(:stdout) { ApiGenerators::CLI.start(%w(invalid_command)) }

        aggregate_failures 'accurate_help_output' do
          expect(group_output).to eq('')
        end
      end
    end
  end
end
