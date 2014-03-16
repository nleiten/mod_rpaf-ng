

bin_echo = $(shell which echo)
bin_apxs = $(shell T=`which apxs2 2>>/dev/null`;if [ "$$T" == "" ];then T=`which apxs 2>>/dev/null`;fi; echo $$T;)
ver_major = $(shell httpd -v|grep 'version'|awk '{print $$3}'|sed -e 's/^Apache\///'|cut -d. -f1)
ver_minor = $(shell httpd -v|grep 'version'|awk '{print $$3}'|sed -e 's/^Apache\///'|cut -d. -f2)
ver_minor_ge_4 = $(shell if [ "$(ver_minor)" -ge "4" ];then echo -n 1;else echo -n 0;fi )


ifeq ($(ver_major),1)
apxs_args = -i -a -c
mod_rpaf-c = mod_rpaf.c
else
ifeq ($(ver_major),2)
apxs_args = -i -c -n mod_rpaf.so
ifeq ($(ver_minor_ge_4),0)
mod_rpaf-c = mod_rpaf-2.0.c
else
mod_rpaf-c = mod_rpaf-2.4.c
endif #ifeq $(ver_minor_ge_4),1
endif #ifeq $(ver_major),2
endif #ifeq $(ver_major),1

#If you want to see all commands execute 'make V=1'
#Default in silent mode.
V ?=0

verbose = $(verbose_$(V))
verbose_0 = @set -e;

ifeq ($(V),0)
SILENT_POSTF = 1>>/dev/null 2>>/dev/null
else
SILENT_POSTF =
endif


.DEFAULT_GOAL := all

all:
	$(verbose)$(bin_echo) "Start make and install with parameters:";
	$(verbose)$(bin_echo) "  Apache version:";
	$(verbose)$(bin_echo) "      major: [$(ver_major)] minor: [$(ver_minor)]"; 
	$(verbose)$(bin_echo) "      is minor version >= 4: [$(ver_minor_ge_4)]";
	$(verbose)$(bin_echo) "  APXS path: $(bin_apxs)";
	$(verbose)$(bin_echo) ;
	$(verbose)$(bin_echo) "Executing: $(bin_apxs) $(apxs_args) $(mod_rpaf-c)";
	$(verbose)$(bin_apxs) $(apxs_args) $(mod_rpaf-c) $(SILENT_POSTF)
	$(verbose)$(bin_echo) "Done.";

