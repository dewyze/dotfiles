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

describe("rspec_state.show", function()
	local function find_float()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local config = vim.api.nvim_win_get_config(win)
			if config.relative ~= "" then
				return win, config
			end
		end
	end

	local function close_floats()
		local win = find_float()
		while win do
			vim.api.nvim_win_close(win, true)
			win = find_float()
		end
	end

	after_each(close_floats)

	it("opens a float above the anchor listing the effective state", function()
		local buf = make_buf({
			"describe User do",
			"  subject(:user) { build(:user) }",
			"",
			'  context "as admin" do',
			"    let(:user) { build(:user, :admin) }",
			"    let!(:account) { create(:account) }",
			"",
			'    it "is valid" do',
			"      expect(user).to be_valid",
			"    end",
			"  end",
			"end",
		})
		vim.api.nvim_set_current_buf(buf)
		vim.api.nvim_win_set_cursor(0, { 9, 6 })

		rspec_state.show()

		local win, config = find_float()
		assert.is_not_nil(win)
		assert.are.equal("SW", config.anchor)
		assert.are.same({ 7, 0 }, { config.bufpos[1], config.bufpos[2] })
		local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_win_get_buf(win), 0, -1, false)
		assert.are.same({
			"let   user     :5  (overrides :2)",
			"let!  account  :6",
		}, lines)
	end)

	it("jumps to the definition under the cursor on <CR>", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			"  let(:account) { build(:account) }",
			"",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"end",
		})
		vim.api.nvim_set_current_buf(buf)
		local source_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_cursor(0, { 6, 6 })

		rspec_state.show()
		vim.api.nvim_win_set_cursor(0, { 2, 0 })
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "x", false)

		assert.is_nil(find_float())
		assert.are.equal(source_win, vim.api.nvim_get_current_win())
		assert.are.equal(3, vim.api.nvim_win_get_cursor(source_win)[1])
	end)

	it("closes on q and <Esc> without moving the cursor", function()
		local buf = make_buf({
			"describe User do",
			"  let(:user) { build(:user) }",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"end",
		})
		vim.api.nvim_set_current_buf(buf)
		local source_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_cursor(0, { 4, 6 })

		for _, key in ipairs({ "q", "<Esc>" }) do
			rspec_state.show()
			assert.is_not_nil(find_float())
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "x", false)
			assert.is_nil(find_float())
			assert.are.same({ 4, 6 }, vim.api.nvim_win_get_cursor(source_win))
		end
	end)

	it("flips below the anchor when there is no room above", function()
		local buf = make_buf({
			"describe User do",
			'  it "is valid" do',
			"    expect(user).to be_valid",
			"  end",
			"",
			"  let(:user) { build(:user) }",
			"end",
		})
		vim.api.nvim_set_current_buf(buf)
		vim.api.nvim_win_set_cursor(0, { 3, 6 })

		rspec_state.show()

		local _, config = find_float()
		assert.are.equal("NW", config.anchor)
		assert.are.same({ 2, 0 }, { config.bufpos[1], config.bufpos[2] })
	end)

	it("notifies instead of opening a float outside any group", function()
		local buf = make_buf({
			"class User",
			"  def valid?",
			"    true",
			"  end",
			"end",
		})
		vim.api.nvim_set_current_buf(buf)
		vim.api.nvim_win_set_cursor(0, { 3, 4 })
		local notified
		local original_notify = vim.notify
		vim.notify = function(msg)
			notified = msg
		end

		rspec_state.show()

		vim.notify = original_notify
		assert.is_nil(find_float())
		assert.are.equal("rspec_state: no enclosing it/context/describe", notified)
	end)
end)

describe("ruby ftplugin", function()
	it("defines a buffer-local RspecState command", function()
		local buf = make_buf({ "describe User do", "end" })
		vim.api.nvim_set_current_buf(buf)
		vim.bo[buf].filetype = "ruby"

		assert.is_not_nil(vim.api.nvim_buf_get_commands(buf, {}).RspecState)
	end)
end)
