From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] configure: switch to new libtool macro
Date: Thu, 26 Feb 2015 09:45:07 +0100
Message-ID: <1424940307-24354-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33205 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbBZIpN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Feb 2015 03:45:13 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Andrew Lentvorski <bsder@allcaps.org>, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 GNUmakefile.am |  2 ++
 configure.ac   | 12 +++---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/GNUmakefile.am b/GNUmakefile.am
index 53dfb4ec47db..580e60d364c2 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -1,3 +1,5 @@
+ACLOCAL_AMFLAGS = -I config/m4
+
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
 	-I$(top_builddir)/include \
diff --git a/configure.ac b/configure.ac
index 2fa16ce35af2..3b695d3aa9ea 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,8 +1,8 @@
 # -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])
 
-AC_INIT([can-utils], [trunk], [linux-can@vger.kernel.org])
+AC_INIT([can-utils],[trunk],[linux-can@vger.kernel.org])
 AC_CONFIG_SRCDIR([lib.c])
 AC_CONFIG_MACRO_DIR([config/m4])
 AC_CONFIG_AUX_DIR([config/autoconf])
@@ -17,13 +17,7 @@ CFLAGS="${CFLAGS} -Wall"
 # Checks for programs.
 #
 AC_PROG_CC
-#AM_MISSING_PROG(PERL, perl, $missing_dir)
-# libtool, old:
-AC_LIBTOOL_WIN32_DLL
-#AC_LIBTOOL_TAGS([])
-AC_PROG_LIBTOOL
-# libtool, new:
-# LT_INIT(win32-dll)
+LT_INIT(win32-dll)
 
 AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
-- 
2.1.4

