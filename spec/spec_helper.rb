require 'rspec'
require 'rspec/its'
require 'pronto/eslint'

RSpec.shared_context 'test repo' do
  let(:git) { 'spec/fixtures/test.git/git' }
  let(:dot_git) { 'spec/fixtures/test.git/.git' }

  before { FileUtils.mv(git, dot_git) }
  let(:repo) { Pronto::Git::Repository.new('spec/fixtures/test.git') }
  after { FileUtils.mv(dot_git, git) }
end

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
  config.mock_with(:rspec) { |c| c.syntax = :should }
end

RSpec.shared_context 'with config', config: true do
  requested_config = metadata[:config].to_yaml

  let(:config_path) do
    File.join(repo.path.to_s, Pronto::ESLint::CONFIG_FILE)
  end

  before { File.write(config_path, requested_config) }
  after { FileUtils.rm(config_path) }
end
