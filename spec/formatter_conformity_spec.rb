describe JUnit do
  context "interface conformity" do
    subject { JUnit.new "some output" }

    it { should respond_to :example_passed }
    it { should respond_to :example_failed }
    it { should respond_to :example_pending }
    it { should respond_to :dump_summary }
  end
end

