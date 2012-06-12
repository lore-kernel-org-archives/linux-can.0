From: yegorslists@googlemail.com
Subject: [PATCH] socketcan: provide GPL2 notion for the headers
Date: Tue, 12 Jun 2012 08:58:32 +0200
Message-ID: <1339484312-4281-2-git-send-email-yegorslists@googlemail.com>
References: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:36259 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab2FLG64 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 02:58:56 -0400
In-Reply-To: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 include/linux/can.h         |   15 +++++++++++++--
 include/linux/can/bcm.h     |   15 +++++++++++++--
 include/linux/can/core.h    |   15 +++++++++++++--
 include/linux/can/dev.h     |   12 ++++++++++++
 include/linux/can/error.h   |   15 +++++++++++++--
 include/linux/can/gw.h      |   15 +++++++++++++--
 include/linux/can/netlink.h |   12 ++++++++++++
 include/linux/can/raw.h     |   15 +++++++++++++--
 8 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 9a19bcb..4e6b853 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -3,11 +3,22 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_H
diff --git a/include/linux/can/bcm.h b/include/linux/can/bcm.h
index 3ebe387..e4352b0 100644
--- a/include/linux/can/bcm.h
+++ b/include/linux/can/bcm.h
@@ -3,10 +3,21 @@
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
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_BCM_H
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 0ccc1cd..bb34f8f 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -3,11 +3,22 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_CORE_H
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..81320d5 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -8,6 +8,18 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_DEV_H
diff --git a/include/linux/can/error.h b/include/linux/can/error.h
index 63e855e..2149f93 100644
--- a/include/linux/can/error.h
+++ b/include/linux/can/error.h
@@ -3,10 +3,21 @@
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
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_ERROR_H
diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
index 8e1db18..b394af5 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -3,10 +3,21 @@
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
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_GW_H
diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index 14966dd..ecf22b4 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -5,6 +5,18 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_NETLINK_H
diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
index 781f3a3..a85c69e 100644
--- a/include/linux/can/raw.h
+++ b/include/linux/can/raw.h
@@ -3,11 +3,22 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #ifndef CAN_RAW_H
-- 
1.7.7

