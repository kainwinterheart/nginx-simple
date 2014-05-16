name             "nginx-simple"
maintainer       "Gennadiy Filatov"
maintainer_email "gfilatov@cpan.org"
license          "MIT"
description      "Installs and configures nginx"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

recipe "nginx-simple", "Installs and configures nginx"
