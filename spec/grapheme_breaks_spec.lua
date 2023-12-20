local uni = require("uni")

describe("uni.grapheme_breaks", function()
   it("exists", function()
      assert.is_not_nil(uni.grapheme_breaks)
   end)

   it("errors when the input is not a string", function()
      assert.has_error(function()
         uni.grapheme_breaks(nil)
      end, "bad argument #1 to 'grapheme_breaks' (string expected, got nil)")
   end)

   it("returns a function", function()
      local next = uni.grapheme_breaks("hello")
      assert.is_function(next)
   end)

   it("works with an empty string", function()
      local next = uni.grapheme_breaks("")
      assert.is_nil(next())
   end)

   it("works with ASCII text", function()
      local next = uni.grapheme_breaks("hello")
      assert.are.equal(1, next())
      assert.are.equal(2, next())
      assert.are.equal(3, next())
      assert.are.equal(4, next())
      assert.are.equal(5, next())
      assert.is_nil(next())
      assert.is_nil(next())
   end)

   it("works with multi-code point grapheme clusters", function()
      local next = uni.grapheme_breaks("he👩‍🚀llo")
      assert.are.equal(1, next())
      assert.are.equal(2, next())
      assert.are.equal(3, next())
      assert.are.equal(14, next())
      assert.are.equal(15, next())
      assert.are.equal(16, next())
      assert.is_nil(next())
      assert.is_nil(next())
   end)
end)