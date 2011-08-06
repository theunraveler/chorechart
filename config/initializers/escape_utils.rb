# This is to fix error when rack encounters URL queries w/ UTF-8
# Found here: http://crimpycode.brennonbortz.com/?p=42
module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end
