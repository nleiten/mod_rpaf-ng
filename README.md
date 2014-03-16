mod_rpaf-ng
===========

Apache reverse proxy module with additional options:
1. Apache 2.4 now supported due to API change.
2. New headers check for double or more proxy on path.
   This done for special cases for cloudflare-nginx-apache
   like situations where there are many headers on each
   proxy added.


INSTALL
===========
1. Just do 'make'. It'll do compilation and install module.

2. Copy 'mod_rpaf.conf' file to configuration directory (default is '/etc/httpd/',
    but in some distributives it is likely '/etc/httpd/extra/' or '/etc/httpd/conf.d/')

3. Change 'mod_rpaf.conf' for your case.


NOTES
===========
There is new option added - 'RPAFHeaderLast'.
Module now check this field at first point and then checks 'RPAFHeader' if 'RPAFHeaderLast' not set.


CHANGES
===========
New version of apache supported with new headers check by Vadim Gamov (aka N.Leiten).

Keep Alive Problem reported and patched by Christian Schneider
 Also reported by Hiroyuki OYAMA and Vladimir Klebanov
mod_rpaf was incorrectly using r->pool to allocate memory for the
ip. The correct pool for this when you are dealing wth keep-alive
requests was r->connection->pool.

Adding configurable header to work with common Russian setups that
use X-Real-Ip instead of X-Forwarded-For.

Fixing problems with keep-alive connections reusing the original
X-Forwarded-For ip as the 'remote_ip'. 

Move the `change_remote_ip' handler from being APR_HOOK_MIDDLE to
APR_HOOK_FIRST to make the module run before modules like mod_geoip.

Thanks to bug reports from 

Yar Odin
Michael Cramer
Sridhar Komandur
Heddy Boubaker
Mitar
Sergey Mokryshev
Günter Knaf
