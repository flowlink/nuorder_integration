require 'spec_helper'

describe NuOrderServices::Base do
  include_examples 'config hash'
  subject { described_class.new(config) }

  it { should respond_to(:config) }
  it { should respond_to(:nuorder) }
end
