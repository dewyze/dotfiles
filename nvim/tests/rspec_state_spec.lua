local rspec_state = require("rspec_state")

local function make_buf(lines)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	return buf
end

describe("rspec_state.resolve", function()
	it("finds a let defined in the enclosing describe", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 5, 4)

		assert.are.equal(1, #result.entries)
		local entry = result.entries[1]
		assert.are.equal("user", entry.name)
		assert.are.equal("let", entry.kind)
		assert.are.equal(2, entry.lnum)
	end)

	it("threads lets so the innermost definition wins", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"",
			'  context "as admin" do',
			"    let(:user) { build(:user, :admin) }",
			"",
			'    it "is valid" do',
			"      expect(user).to be_valid",
			"    end",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 8, 6)

		assert.are.equal(1, #result.entries)
		local entry = result.entries[1]
		assert.are.equal("user", entry.name)
		assert.are.equal(5, entry.lnum)
		assert.are.equal(1, #entry.overridden)
		assert.are.equal(2, entry.overridden[1].lnum)
		assert.are.equal("let", entry.overridden[1].kind)
	end)

	it("recognizes let! and named subjects", function()
		local buf = make_buf({
			"describe User do",
			"  subject(:user) { build(:user) }",
			"  let!(:account) { create(:account) }",
			"",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 6, 4)

		assert.are.equal(2, #result.entries)
		assert.are.equal("user", result.entries[1].name)
		assert.are.equal("subject", result.entries[1].kind)
		assert.are.equal("account", result.entries[2].name)
		assert.are.equal("let!", result.entries[2].kind)
	end)

	it("lists a bare subject under the reserved name", function()
		local buf = make_buf({
			"describe User do",
			"  subject { build(:user) }",
			"",
			'  it "is valid" do',
			"    expect(subject).to be_valid",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 5, 4)

		assert.are.equal(1, #result.entries)
		assert.are.equal("subject", result.entries[1].name)
		assert.are.equal("subject", result.entries[1].kind)
		assert.are.equal(2, result.entries[1].lnum)
	end)

	it("anchors to the enclosing it", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 5, 4)

		assert.are.equal(4, result.anchor.lnum)
		assert.are.equal("it", result.anchor.kind)
	end)

	it("anchors to the enclosing context when not inside an example", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"",
			'  context "as admin" do',
			"    let(:role) { :admin }",
			"",
			'    it "is valid" do',
			"    end",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 6, 0)

		assert.are.equal(4, result.anchor.lnum)
		assert.are.equal("context", result.anchor.kind)
		assert.are.equal(2, #result.entries)
		assert.are.equal("role", result.entries[2].name)
	end)

	it("ignores lets defined in sibling contexts", function()
		local buf = make_buf({
			"describe User do",
			'  context "as admin" do',
			"    let(:role) { :admin }",
			"  end",
			"",
			'  context "as guest" do',
			'    it "is valid" do',
			"    end",
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 7, 4)

		assert.are.equal(0, #result.entries)
	end)

	it("treats RSpec.describe as a describe", function()
		local buf = make_buf({
			"RSpec.describe User do",
			"  let(:user) { build(:user) }",
			'  it "is valid" do',
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 4, 2)

		assert.are.equal(1, #result.entries)
		assert.are.equal("user", result.entries[1].name)
	end)

	it("lets a same-block redefinition win", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"  let(:user) { build(:user, :admin) }",
			'  it "is valid" do',
			"  end",
			"end",
		})

		local result = rspec_state.resolve(buf, 5, 2)

		assert.are.equal(1, #result.entries)
		assert.are.equal(3, result.entries[1].lnum)
		assert.are.equal(2, result.entries[1].overridden[1].lnum)
	end)

	it("includes definitions below the cursor in the same block", function()
		local buf = make_buf({
			"describe User do",
			'  it "is valid" do',
			"  end",
			"",
			"  let(:user) { build(:user) }",
			"end",
		})

		local result = rspec_state.resolve(buf, 3, 2)

		assert.are.equal(1, #result.entries)
		assert.are.equal(5, result.entries[1].lnum)
	end)
end)
