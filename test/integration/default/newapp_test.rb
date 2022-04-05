describe file('/tmp/base_cookbook') do
  it { should exist }
end

describe file('/tmp/app_cookbook') do
  it { should exist }
end

describe file('/tmp/newapp_cookbook') do
  it { should exist }
end

describe file('/tmp/newapp2_cookbook') do
  it { should_not exist }
end
