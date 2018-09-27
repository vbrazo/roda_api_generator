RSpec.describe RubyApiGenerators::Generators::Roda do
  subject do
    args = ['project_name']

    described_class.new(args, test_framework: :spec)
  end

  def action(*args, &block)
    capture(:stdout) { subject.send(*args, &block) }
  end

  describe '#initialize' do
    it 'has default behavior invoke' do
      expect(subject.behavior).to eq(:invoke)
    end

    it 'has correct name' do
      expect(subject.name).to include('project_name')
    end
  end

  describe 'on include' do
    it 'adds runtime options to the base class' do
      expect(subject.options.keys).to include('test_framework')
    end
  end

  it 'executes the thor command' do
    expect(subject).to receive(:system).with('thor list')
    action :thor, :list, verbose: true
  end
end
