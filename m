From: David Jander <david@protonic.nl>
Subject: [PATCH 14/14] can: flexcan: Add MB/Fifo specific column to comment table of IP versions
Date: Thu,  6 Nov 2014 09:34:13 +0100
Message-ID: <1415262853-22907-15-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26410 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaKFIeI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:08 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Flexcan V10 and newer are able to receive RTR frames in a MB. Older
versions are not. Those should use flexcan in FIFO mode.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 304b164..717ccb3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -204,14 +204,14 @@
  * FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
- *    SOC   Version   IP-Version  Glitch-  [TR]WRN_INT  Memory err
- *                                Filter?   connected?  detection
- *   MX25  FlexCAN2  03.00.00.00     no         no         no
- *   MX28  FlexCAN2  03.00.04.00    yes        yes         no
- *   MX35  FlexCAN2  03.00.00.00     no         no         no
- *   MX53  FlexCAN2  03.00.00.00    yes         no         no
- *   MX6s  FlexCAN3  10.00.12.00    yes        yes         no
- *   VF610 FlexCAN3  ?               no        yes        yes
+ *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT  Memory err    RTR re-
+ *                                Filter?  connected?  detection   ception in MB
+ *   MX25  FlexCAN2  03.00.00.00     no        no         no         no
+ *   MX28  FlexCAN2  03.00.04.00    yes       yes         no         no
+ *   MX35  FlexCAN2  03.00.00.00     no        no         no         no
+ *   MX53  FlexCAN2  03.00.00.00    yes        no         no         no
+ *   MX6s  FlexCAN3  10.00.12.00    yes       yes         no        yes
+ *   VF610 FlexCAN3  ?               no       yes        yes        yes?
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
-- 
1.9.1

