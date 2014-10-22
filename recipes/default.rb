#
# Cookbook Name:: vim74
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{wget ncurses-devel lua-devel perl-ExtUtils-Embed python-devel}.each do |package_name|
    package package_name do 
        action [:install, :upgrade]
    end
end

bash "vim install" do
    code <<-EOH
        cd /usr/local/src/
        wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
        tar xvf vim-7.4.tar.bz2
        cd vim74/
        ./configure \
            --enable-multibyte \
            --with-features=huge \
            --enable-luainterp \
            --enable-perlinterp \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib64/python2.6/config \
            --enable-rubyinterp \
            --with-ruby-command=/usr/bin/ruby \
        make
        make install
    EOH
    not_if { File.exists?("/usr/local/src/vim74") }
end
