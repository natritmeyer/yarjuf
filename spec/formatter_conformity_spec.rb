describe JUnit do
  context "interface conformity" do
    subject { JUnit.new "some output" }

    it "should respond to example passed" do
      should respond_to :example_passed
    end

    it "should respond to example failed" do
      should respond_to :example_failed
    end

    it "should respond to example pending" do
      should respond_to :example_pending
    end

    it "should respond to dump summary" do
      should respond_to :dump_summary
    end
  end
end

