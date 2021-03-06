include Octodown

describe Renderer::HTML do
  let(:html) { Renderer::GithubMarkdown.render File.new(dummy_path) }

  subject { Renderer::HTML.new(html, opts).content }

  before { allow(Octodown).to receive(:root) { '.' } }

  it 'includes HTML from markdown rendering phase' do
    expect(subject).to include '<h1>Hello world!</h1>'
    expect(subject).to include 'highlight-ruby'
  end

  it 'sets the title' do
    expect(subject).to include '<title>Octodown Preview</title>'
  end

  it 'injects Github CSS' do
    css = File.read assets_dir('github.css')
    expect(subject).to include css
  end

  it 'includes jQuery' do
    jquery = File.read assets_dir('vendor', 'jquery-2.1.3.min.js')
    expect(subject).to include jquery
  end

  it 'includes correct websocket address in js' do
    expect(subject).to include 'new WebSocket("ws://localhost:8080")'
  end
end
