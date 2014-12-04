# Fact: java_patch_level
#
# Purpose: store java patch level
#
# Resolution:
#   tests for presence of java;
#   returns output of "java -version" and splits on the patch number (after _)
#
# Caveats:
#   none
#
# Notes:
#   None
Facter.add(:java_patch_level) do
  setcode do
    t_java = Facter::Util::Resolution.exec("java -version 2>&1")
    if t_java.nil?
      java_version = "NOT_INSTALLED"
    else
      j_version = t_java.to_s.lines.first.strip.split(/version/)[1].gsub(/"/, "").strip.split('_')[1]
    end
  end
end