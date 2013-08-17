From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when provided via the environment
Date: Sat, 17 Aug 2013 21:28:10 +0200
Message-ID: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58066 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab3HQT2l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Aug 2013 15:28:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

=46or creating a Debian package providing PREFIX and DESTDIR via the
environment is the easiest option. So use ?=3D to assign these two
variables to honor the values in the environment.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c3e6d9c..2f79ee7 100644
--- a/Makefile
+++ b/Makefile
@@ -38,8 +38,8 @@
 #
 #  Send feedback to <linux-can@vger.kernel.org>
=20
-DESTDIR =3D
-PREFIX =3D /usr/local
+DESTDIR ?=3D
+PREFIX ?=3D /usr/local
=20
 MAKEFLAGS =3D -k
=20
--=20
1.8.4.rc0

