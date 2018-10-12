require File.expand_path("spec_helper", File.dirname(File.dirname(__FILE__)))

begin
  require 'mail'
rescue LoadError
  warn "mail not installed, skipping mail plugin test"  
else
Mail.defaults do
  delivery_method :test
end

describe "error_mail plugin" do 
  def app(opts={})
    @emails = emails = [] unless defined?(@emails)
    @app ||= super(:bare) do
      plugin :error_mail, {:to=>'t', :from=>'f'}.merge(opts)

      route do |r|
        r.get('noerror'){error_mail("Problem"); 'g'}
        raise ArgumentError, 'bad foo' rescue error_mail($!)
        'e'
      end
    end
  end

  before do
    Mail::TestMailer.deliveries.clear
  end

  def email
    Mail::TestMailer.deliveries.last
  end

  it "adds error_mail method for emailing exceptions" do
    app
    body('rack.input'=>StringIO.new, 'QUERY_STRING'=>'b=c', 'rack.session'=>{'d'=>'e'}).must_equal 'e'
    email.to.must_equal ['t']
    email.from.must_equal ['f']
    email.header.to_s.must_match(/^Subject: ArgumentError: bad foo/)
    email.body.to_s.must_match(/^Backtrace:$.+^ENV:$.+^"rack\.input" => .+^Params:$\s+^"b" => "c"$\s+^Session:$\s+^"d" => "e"$/m)
  end

  it "have error_mail method support string arguments" do
    app
    body('/noerror', 'rack.input'=>StringIO.new, 'QUERY_STRING'=>'b=c', 'rack.session'=>{'d'=>'e'}).must_equal 'g'
    email.to.must_equal ['t']
    email.from.must_equal ['f']
    email.header.to_s.must_match(/^Subject: Problem/)
    email.body.to_s.must_match(/^ENV:$.+^"rack\.input" => .+^Params:$\s+^"b" => "c"$\s+^Session:$\s+^"d" => "e"$/m)
    email.body.to_s.wont_include('Backtrace')
  end

  it "supports error_mail_content for the content of the email" do
    app.route do |r|
      raise ArgumentError, 'bad foo' rescue error_mail_content($!)
    end
    b = body('rack.input'=>StringIO.new, 'QUERY_STRING'=>'b=c', 'rack.session'=>{'d'=>'e'})
    b.must_match(/^Subject: ArgumentError: bad foo/)
    b.must_match(/^Backtrace:.+^ENV:.+^"rack\.input" => .+^Params:\s+^"b" => "c"\s+^Session:\s+^"d" => "e"/m)
  end

  it "adds :prefix option to subject line" do
    app(:prefix=>'TEST ')
    body('rack.input'=>StringIO.new).must_equal 'e'
    email.header.to_s.must_match(/^Subject: TEST ArgumentError/)
  end

  it "uses :headers option for additional headers" do
    app(:headers=>{'Foo'=>'Bar', 'Baz'=>'Quux'})
    body('rack.input'=>StringIO.new).must_equal 'e'
    email.header.to_s.must_match(/^Foo: Bar/)
    email.header.to_s.must_match(/^Baz: Quux/)
  end

  it "requires the :to and :from options" do
    proc{app :from=>nil}.must_raise(Roda::RodaError)
    proc{app :to=>nil}.must_raise(Roda::RodaError)
  end

  it "works correctly in subclasses" do
    @app = Class.new(app)
    @app.route do |r|
      raise ArgumentError rescue error_mail($!)
      'e'
    end
    body('rack.input'=>StringIO.new).must_equal 'e'
    email.to.must_equal ['t']
    email.from.must_equal ['f']
    email.header.to_s.must_match(/^Subject: ArgumentError: ArgumentError/)
    email.body.to_s.must_match(/^Backtrace:$.+^ENV:$.+^"rack\.input" => .+/m)
  end
end
end
