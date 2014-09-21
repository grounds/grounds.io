FactoryGirl.define do
  factory :ground do
    language 'python2'
    code 'print 42'
    
    factory :invalid_ground do
      language ''
    end
  end
end
