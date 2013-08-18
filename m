From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] linux/can: add explicit copyrights to can headers
Date: Sun, 18 Aug 2013 22:41:37 +0200
Message-ID: <1376858497-1700-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32791 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3HRUlt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Aug 2013 16:41:49 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Urs Thuermann <urs.thuermann@volkswagen.de>, Wolfgang Grandegger <wg@grandegger.com>

These files are copied to the source code of user space applications (i=
n
this case can-utils) and so it makes sense to mention explicitly their
copyright. I added the terms of C code that was introduced in the same
commit as these headers.

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Urs Thuermann <urs.thuermann@volkswagen.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I think it is necessary to get the Ack of the three people mentioned in
the Cc: commit footers. @Wolfgang: I added a statement

    The provided data structures and external interfaces from this code
    are not restricted to be used by software with a GPL compatible lic=
ense.

similar to the other can headers. Does that suit you?

Best regards
Uwe

 include/uapi/linux/can/bcm.h     | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/can/error.h   | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/can/gw.h      | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/can/netlink.h | 11 +++++++++++
 include/uapi/linux/can/raw.h     | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)

diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.=
h
index 3ebe387..382251a 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -7,6 +7,38 @@
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * All rights reserved.
  *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
  */
=20
 #ifndef CAN_BCM_H
diff --git a/include/uapi/linux/can/error.h b/include/uapi/linux/can/er=
ror.h
index 7b7148b..b632045 100644
--- a/include/uapi/linux/can/error.h
+++ b/include/uapi/linux/can/error.h
@@ -7,6 +7,38 @@
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * All rights reserved.
  *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
  */
=20
 #ifndef CAN_ERROR_H
diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
index ae07bec..730c540 100644
--- a/include/uapi/linux/can/gw.h
+++ b/include/uapi/linux/can/gw.h
@@ -7,6 +7,38 @@
  * Copyright (c) 2011 Volkswagen Group Electronic Research
  * All rights reserved.
  *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
  */
=20
 #ifndef CAN_GW_H
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
diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.=
h
index a814062..c7d8c33 100644
--- a/include/uapi/linux/can/raw.h
+++ b/include/uapi/linux/can/raw.h
@@ -8,6 +8,38 @@
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * All rights reserved.
  *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
+ *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
  */
=20
 #ifndef CAN_RAW_H
--=20
1.8.4.rc2

