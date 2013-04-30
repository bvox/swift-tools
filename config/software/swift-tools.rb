#
# Copyright:: Copyright (c) 2013 BVox, S.L.U.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name "swift-tools"

dependency "libxml2"
dependency "libxslt"
dependency "ruby"
dependency "rubygems"
dependency "yajl"
dependency "bundler"

gem_deps = %w[fog colored thor]

relative_path "swift-tools"
always_build true

env = {
    "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
    "LDFLAGS" => "-Wl,-rpath #{install_dir}/embedded/lib -L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include"
}

build do
  # Install required gem deps
  gem_deps.each do |g|
    gem "install #{g} -n #{install_dir}/bin --no-rdoc --no-ri", :env => env
  end

  Dir["#{Omnibus::Config.project_root}/scripts/*"].each do |s|
    sname = File.basename(s)
    dest = "#{install_dir}/bin/#{sname}"
    FileUtils.mkdir_p "#{install_dir}/bin/"
    File.open(dest, 'w') do |f|
      f.puts "#!#{install_dir}/embedded/bin/ruby"
      f.puts File.read(s)
    end
    FileUtils.chmod 0755, dest
  end
end
