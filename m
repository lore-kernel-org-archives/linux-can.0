From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Wed, 15 Jan 2014 18:54:16 +0100
Message-ID: <52D6CB48.9010206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:10487 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaAORyT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Jan 2014 12:54:19 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

Introduce a second set of bitrate configuration for the (potential different)
data bitrate. The CAN FD arbitration bitrate is stored in the existing
bittiming configuration space.

TODO:
The functions can_calc_bittiming(), can_fixup_bittiming() should change their
parameters from

	(struct net_device *dev, struct can_bittiming *bt)
to
	(struct can_bittiming *bt, const struct can_bittiming_const *btc, const struct can_clock *clk)

to be able to pass the two sets of bittiming parameters (CAN / CAN FD).

And some more changes in dev.c taking care of the two bitrates (when FD is
enabled).

Btw. starting with the first idea of a separate bittiming setup. Any comments?

Regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..ce4d15c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -33,9 +33,10 @@ enum can_mode {
 struct can_priv {
 	struct can_device_stats can_stats;
 
-	struct can_bittiming bittiming;
-	const struct can_bittiming_const *bittiming_const;
-	struct can_clock clock;
+	struct can_bittiming bittiming, data_bittiming;
+	const struct can_bittiming_const *bittiming_const,
+		*data_bittiming_const;
+	struct can_clock clock, data_clock;
 
 	enum can_state state;
 	u32 ctrlmode;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index df944ed..bd0493a2 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -96,6 +96,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 
 /*
  * CAN device statistics
@@ -122,6 +123,9 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
+	IFLA_CAN_DATA_BITTIMING,
+	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_DATA_CLOCK,
 	__IFLA_CAN_MAX
 };
 
