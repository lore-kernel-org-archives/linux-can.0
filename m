From: David Jander <david@protonic.nl>
Subject: [PATCH 14/15] can: flexcan: Add MB/Fifo specific column to comment table of IP versions
Date: Fri, 10 Oct 2014 17:46:59 +0200
Message-ID: <1412956020-21489-15-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18411 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbaJJPrD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:03 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Flexcan V10 and newer are able to receive RTR frames in a MB. Older
versions are not. Those should use flexcan in FIFO mode.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 5e37ce4..b8d8058 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -197,14 +197,14 @@
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

