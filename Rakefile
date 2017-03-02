# frozen_string_literal: true
require 'json'
require 'find'

def coverage_data
  coverage_file_name = '/usr/src/app/coverage/bashtestdummy/coverage.json'
  coverage_json = File.read(coverage_file_name)
  JSON.parse(coverage_json)
end

def code_coverage_lines_from_json
  coverage_data['covered_lines']
end

def total_lines_from_json
  coverage_data['total_lines']
end

def scripts_in_bin_dir
  Find.find('/usr/src/app/bin').reject do |file|
    File.directory?(file)
  end
end

def covered_scripts_in_bin_dir
  coverage_data['files'].map do |file_mapping|
    file_mapping['file']
  end
end

def shell_script?(file)
  `file --brief --mime-type #{file}`.chomp == 'text/x-shellscript'
end

def uncovered_scripts_in_bin_dir
  (scripts_in_bin_dir - covered_scripts_in_bin_dir).select do |file|
    shell_script?(file)
  end
end

def file_lines(filename)
  `wc -l #{filename}`.split.first.to_i
end

def total_script_lines_from_bin_dir
  total_lines_from_json +
    uncovered_scripts_in_bin_dir.map do |filename|
      file_lines(filename)
    end.reduce(0, :+)
end

def code_coverage_from_json
  new_covered_lines = code_coverage_lines_from_json
  total_lines = total_script_lines_from_bin_dir
  new_covered_lines.to_f / total_lines
end

HIGH_WATER_MARK_FILE =
  '/usr/src/app/metrics/coverage_high_water_mark'.freeze

task :test do
  sh 'kcov ' +
     # The default method (PS4) dumps some remnents of multi-line bash
     # variables out to the console at the end accidentally.
     '--bash-method=DEBUG ' \
     '--include-path=/usr/src/app/bin ' \
     '/usr/src/app/coverage ' \
     '/usr/bashtestdummy/bashtestdummy'
  new_coverage = code_coverage_from_json.to_f * 100

  unless File.exist? HIGH_WATER_MARK_FILE
    File.open(HIGH_WATER_MARK_FILE, 'w') { |f| f.write('0') }
  end

  new_coverage_rounded_str = format('%0.2f', new_coverage)
  new_coverage_rounded = new_coverage_rounded_str.to_f

  high_water_mark = IO.read(HIGH_WATER_MARK_FILE).to_f
  uncovered = uncovered_scripts_in_bin_dir
  puts "Uncovered scripts: #{uncovered}" unless uncovered.empty?
  if new_coverage_rounded < high_water_mark
    puts "Coverage used to be #{high_water_mark}; down to " \
          "#{new_coverage_rounded}% " \
          "(#{code_coverage_lines_from_json}/" \
          "#{total_script_lines_from_bin_dir}).  "\
          "Fix by viewing 'coverage/index.html'"
    exit(1)
  elsif new_coverage_rounded > high_water_mark
    IO.write(HIGH_WATER_MARK_FILE, new_coverage_rounded_str)
    puts("Just ratcheted coverage up to #{new_coverage_rounded_str}%"\
         " in #{HIGH_WATER_MARK_FILE}")
    puts('Please commit the ratchet, push and try again')
    exit(2)
  else
    puts "Code coverage steady at #{new_coverage_rounded}%"
  end
end
