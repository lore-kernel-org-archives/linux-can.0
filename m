From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] uapi/linux/can: add explicit copyrights to can's netlink header
Date: Sat,  7 Sep 2013 21:34:38 +0200
Message-ID: <1378582478-9484-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1b45fb94c09a6ee453fd1606cc21e111@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40403 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab3IGTeo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Sep 2013 15:34:44 -0400
In-Reply-To: <1b45fb94c09a6ee453fd1606cc21e111@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

This file is copied to the source code of user space applications (in
this case can-utils) and so it makes sense to mention explicitly their
copyright.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to the previous post the headers covered by VM copyright were
dropped as Marc already fixed them and the GPL exception was skipped as
this is what Wolfgang seems to prefer.

Best regards
Uwe

 include/uapi/linux/can/netlink.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
index 14966dd..df944ed 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -5,6 +5,14 @@
  *
  * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
  *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the version 2 of the GNU General Public Licen=
se
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
  */
=20
 #ifndef CAN_NETLINK_H
--=20
1.8.4.rc3

