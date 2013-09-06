From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Fri,  6 Sep 2013 16:30:11 +0200
Message-ID: <1378477811-3606-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37296 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3IFOaU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Sep 2013 10:30:20 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

This file is copied to the source code of user space applications (in
this case can-utils) and so it makes sense to mention explicitly its
copyright. I added the terms of C code that was introduced in the same
commit as this header.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Wolfgang,

this is the remaining hunk from Uwe's patch that has not been Acked. Co=
ntinuing
with Uwe's words (adopted):

I think it is necessary to get the Ack of the people mentioned in
the Cc: commit footers. @Wolfgang: I added a statement

    The provided data structures and external interfaces from this code
    are not restricted to be used by software with a GPL compatible lic=
ense.

similar to the other can headers. Does that suit you?

Best regards
Uwe

 include/uapi/linux/can/netlink.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
index 14966dd..8bbb885 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -5,6 +5,17 @@
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
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by software with a GPL compatible lic=
ense.
  */
=20
 #ifndef CAN_NETLINK_H
--=20
1.8.4.rc3

