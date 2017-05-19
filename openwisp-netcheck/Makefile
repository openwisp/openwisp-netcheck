# Copyright (C) 2017 openwisp.org
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=openwisp-netcheck
PKG_VERSION:=$(shell cat ../VERSION)
PKG_RELEASE:=1
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/openwisp-netcheck
	SECTION:=admin
	CATEGORY:=Administration
	TITLE:=OpenWISP network connectivity check tool.
	PKGARCH:=all
	MAINTAINER:=Riccardo Bloise <r.bloise@cineca.it>
	URL:=http://openwisp.org
endef

define Package/openwisp-netcheck/description
	OpenWISP network connectivity check tool.
endef

define Build/Compile
endef

define Package/openwisp-netcheck/install
	$(INSTALL_DIR) \
		$(1)/etc/init.d \

	$(INSTALL_DIR) \
		$(1)/etc/config \

	$(INSTALL_DIR) \
		$(1)/usr/sbin \

	$(CP)  files/openwisp-netcheck.init \
		$(1)/etc/init.d/openwisp_netcheck

	$(CP)  files/openwisp-netcheck.config \
		$(1)/etc/config/openwisp_netcheck

	$(CP) -r files/sbin/* \
		$(1)/usr/sbin/

endef

$(eval $(call BuildPackage,openwisp-netcheck))
