
# Default to sparse specifications.
# use `strict!` calls to make matching strict where needed
JsonExpressions::Matcher.assume_strict_arrays = false
JsonExpressions::Matcher.assume_strict_hashes = false

RSpec::Matchers.define :match_json do |json_spec_hash, options={}|
  json_spec_hash.deep_stringify_keys!

  json_matcher = JsonExpressions::Matcher.new(json_spec_hash)
  

  match do |actual|
    json_matcher =~ actual.json_body
  end

  failure_message do |actual|
    <<-EOS
response json match error: 
  #{json_matcher.last_error}
when matching:
  #{actual.json_body.inspect}
against spec:
  #{json_spec_hash.inspect}
EOS
  end

  failure_message_when_negated do |actual|
    <<-EOS
expected response json to not match spec: 
  #{json_spec_hash.inspect}
but it did!
EOS
  end
end