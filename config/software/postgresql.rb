#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
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

name "postgresql"
version "9.2.1"

dependencies ["zlib",
              "openssl",
              "libedit",
              "ncurses"]

source :url => "http://ftp.postgresql.org/pub/source/v9.2.1/postgresql-9.2.1.tar.bz2",
       :md5 => "c0b4799ea9850eae3ead14f0a60e9418"

relative_path "postgresql-9.2.1"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--with-libedit-preferred",
           "--with-openssl --with-includes=#{install_dir}/embedded/include",
           "--with-libraries=#{install_dir}/embedded/lib"].join(" "), :env => configure_env
  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end
