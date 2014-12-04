# Fact: java_version
#
# Purpose: store java versions in the config DB
#
# Resolution:
#   tests for presence of java;
#   returns output of "java -version" and splits on \n + '"'
#
# Caveats:
#   none
#
# Notes:
#   None

Facter.add(:java_version) do
  setcode do
    t_java = Facter::Util::Resolution.exec("java -version 2>&1")
    if t_java.nil?
      java_version = "NOT_INSTALLED"
    else
      j_version = t_java.to_s.lines.first.strip.split(/version/)[1].gsub(/"/, "").strip
    end
  end
end