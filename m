From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [can-utils PATCH] can-calc-bit-timing: add a proper GNU license agreement
Date: Thu, 27 Feb 2014 21:56:26 +0100
Message-ID: <530FA67A.2090007@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40331 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaB0U43 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 15:56:29 -0500
Received: from [10.0.30.2] (p4FE61926.dip0.t-ipconnect.de [79.230.25.38])
	(Authenticated sender: wg)
	by ngcobalt02.manitu.net (Postfix) with ESMTPA id B9DD65A4198
	for <linux-can@vger.kernel.org>; Thu, 27 Feb 2014 21:56:27 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-CAN <linux-can@vger.kernel.org>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 can-calc-bit-timing.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/can-calc-bit-timing.c b/can-calc-bit-timing.c
index ba50cdc..36ff1e9 100644
--- a/can-calc-bit-timing.c
+++ b/can-calc-bit-timing.c
@@ -9,7 +9,10 @@
  *   Copyright 2005      Stanislav Marek
  *   email:pisa@cmp.felk.cvut.cz
  *
- *   This software is released under the GPL-License.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * any later version.
  */

 #include <errno.h>
-- 
1.7.9.5

