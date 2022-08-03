require_relative "../lib/qspec"


QSpec.describe "some examples" do 
  it "can pass" do 
    # actual == expected
    (1 + 1).should == 2
  end

  it "can fail" do
    (1 + 1).should == 3
  end

  it "negative testing" do
    (1 + 1).should != 3
  end
  
end

# New rspec like syntax
QSpec.describe "expectations" do 
  it "can expect values" do 
    # expect(1 + 1).to(eq(2))
    expect(1 + 1).to eq 2
  end
end


class SimpleTest
  #macro methods ruby
  QSpec.describe "Basic test"  do 
    it "1 + 1 = 2"  do 
      is_equal 2, 1 + 1
    end
    
  end
end