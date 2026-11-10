local rspec_let = require("rspec_let")

local function make_buf(lines)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	return buf
end

local function lines(buf)
	return vim.api.nvim_buf_get_lines(buf, 0, -1, false)
end

describe("rspec_let.to_assignment", function()
	it("turns a single let into a variable assignment", function()
		local buf = make_buf({ "  let(:user) { build(:user) }" })

		rspec_let.to_assignment(buf, 1, 1)

		assert.are.same({ "  user = build(:user)" }, lines(buf))
	end)

	it("handles let! and braces inside the body", function()
		local buf = make_buf({ "  let!(:post) { create(:post, opts: { a: 1 }) }" })

		rspec_let.to_assignment(buf, 1, 1)

		assert.are.same({ "  post = create(:post, opts: { a: 1 })" }, lines(buf))
	end)

	it("converts every let in the range and leaves other lines alone", function()
		local buf = make_buf({
			"  let(:user) { build(:user) }",
			"  subject { user }",
			"  let(:post) { build(:post) }",
		})

		rspec_let.to_assignment(buf, 1, 3)

		assert.are.same({
			"  user = build(:user)",
			"  subject { user }",
			"  post = build(:post)",
		}, lines(buf))
	end)
end)
