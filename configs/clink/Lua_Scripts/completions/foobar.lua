clink.argmatcher("foobar")
:addflags("-foo", "-bar")          -- Flags.
:addarg({ "hello", "hi" })         -- Completions for arg #1.
:addarg({ "world", "wombles" })    -- Completions for arg #2.