From: yegorslists@googlemail.com
Subject: [PATCH v2] socketcan: provide GPL2 notion for the headers
Date: Tue, 12 Jun 2012 10:16:27 +0200
Message-ID: <1339488987-5632-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:47416 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab2FLIx2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 04:53:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
v2: remove FSF address

 include/linux/can.h         |   11 +++++++++--
 include/linux/can/bcm.h     |   11 +++++++++--
 include/linux/can/core.h    |   11 +++++++++--
 include/linux/can/dev.h     |    8 ++++++++
 include/linux/can/error.h   |   11 +++++++++--
 include/linux/can/gw.h      |   11 +++++++++--
 include/linux/can/netlink.h |    8 ++++++++
 include/linux/can/raw.h     |   11 +++++++++--
 8 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 9a19bcb..9c1e221 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -3,11 +3,18 @@
  *
  * Definitions for CAN network layer (socket addr / CAN frame / CAN filter)
  *
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  *          Urs Thuermann   <urs.thuermann@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
  *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_H
diff --git a/include/linux/can/bcm.h b/include/linux/can/bcm.h
index 3ebe387..c8194be 100644
--- a/include/linux/can/bcm.h
+++ b/include/linux/can/bcm.h
@@ -3,10 +3,17 @@
  *
  * Definitions for CAN Broadcast Manager (BCM)
  *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_BCM_H
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 0ccc1cd..0d3032f 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -3,11 +3,18 @@
  *
  * Protoypes and definitions for CAN protocol modules using the PF_CAN core
  *
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  *          Urs Thuermann   <urs.thuermann@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
  *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_CORE_H
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..b4e2a92 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -8,6 +8,14 @@
  *
  * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>
  *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_DEV_H
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index 63e855e..e1eed88 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -3,10 +3,17 @@
  *
  * Definitions of the CAN error frame to be filtered and passed to the user.
  *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_ERROR_H
diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
index 8e1db18..43dc261 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -3,10 +3,17 @@
  *
  * Definitions for CAN frame Gateway/Router/Bridge
  *
- * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  * Copyright (c) 2011 Volkswagen Group Electronic Research
- * All rights reserved.
+ * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_GW_H
diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 14966dd..e8eda88 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -5,6 +5,14 @@
  *
  * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
  *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_NETLINK_H
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index 781f3a3..2d82920 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -3,11 +3,18 @@
  *
  * Definitions for raw CAN sockets
  *
+ * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
  * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  *          Urs Thuermann   <urs.thuermann@volkswagen.de>
- * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
- * All rights reserved.
  *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #ifndef CAN_RAW_H
-- 
1.7.7

