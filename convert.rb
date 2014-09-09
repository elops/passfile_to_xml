#!/usr/bin/env ruby

text = $stdin.read
t = Time.new

header = /^\s+Name:\s+.*$/
record_blocks = text.scan(/(?m)#{header}.*?(?=#{header}|\Z)/)

puts <<-eos
<database>
  <group>
    <title>I MADE THIS!</title>
      <icon>1</icon>
eos

record_blocks.each do |block|
  name = block.match(/^\s*Name:\s+(.*)$/).captures[0]
  url = block.match(/^\s*URL:\s+(.*)$/).captures[0]
  username = block.match(/^\s*Username:\s+(.*)$/).captures[0]
  password = block.match(/^\s*Password:\s+(.*)$/).captures[0]

  puts <<-eos
        <entry>
          <title>#{name}</title>
          <username>#{username}</username>
          <password>#{password}</password>
          <url>#{url}</url>
          <icon>0</icon>
          <creation>#{t.strftime("%Y-%m-%dT%H:%M:%S")}</creation>
        </entry>
  eos
end

puts <<-eos
  </group>
</database>
eos
