#!/usr/bin/env ruby
require 'tempfile'

def pipe_stdin_to tempf
  loop do
    file_segment = $stdin.readpartial(4096)
    tempf.write file_segment
    tempf.flush
  end
rescue EOFError => e
  # fucking finally.
end



if $stdin.tty?
  em_pid = spawn('/usr/local/bin/emacsclient', '-t', *ARGV)
  Process.wait em_pid

else
  tempfile = Tempfile.new 'emacs-stdin'
  tempfile.set_encoding 'ASCII-8BIT', 'ASCII-8BIT'
  $stdin.set_encoding 'ASCII-8BIT'

  begin
    pipe_stdin_to tempfile

    em_pid = spawn('/usr/local/bin/emacsclient', '-t', *ARGV, tempfile.path)
    Process.wait em_pid

  ensure
    tempfile.close
    tempfile.unlink
  end

end
