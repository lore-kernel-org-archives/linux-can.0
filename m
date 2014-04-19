From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 5/5] can: slcan: Add CAN status flag support
Date: Sat, 19 Apr 2014 22:38:43 +0200
Message-ID: <5352DED3.8080900@hartkopp.net>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <1397573468-7619-6-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:8554 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaDSUir (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 19 Apr 2014 16:38:47 -0400
In-Reply-To: <1397573468-7619-6-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Alexander,

On 15.04.2014 16:51, Alexander Stein wrote:
> CAN status flags have to be polled from the serial device. So send the
> request every 10ms by default.

here's my suggestion for the status retrieval from the user space by
sending a CAN frame with CAN_ERR_FLAG to the slcan device.

(I don't have this hardware with me - therefore compile tested only)

Regards,
Oliver

---

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index f5b16e0..750b002 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -54,6 +54,7 @@
 #include <linux/kernel.h>
 #include <linux/can.h>
 #include <linux/can/skb.h>
+#include <linux/can/error.h>
 
 static __initconst const char banner[] =
 	KERN_INFO "slcan: serial line CAN interface driver\n";
@@ -78,6 +79,16 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 #define SLC_SFF_ID_LEN 3
 #define SLC_EFF_ID_LEN 8
 
+/* slcan status bits returned in 'F' response */
+#define SLC_CAN_FLAG_ERR_WARN   BIT(2)
+#define SLC_CAN_FLAG_OVERRUN    BIT(3)
+#define SLC_CAN_FLAG_ERR_PASV   BIT(5)
+#define SLC_CAN_FLAG_ARB_LOST   BIT(6)
+#define SLC_CAN_FLAG_BUS_ERR    BIT(7)
+#define SLC_CAN_FLAG_VALID (SLC_CAN_FLAG_ERR_WARN | SLC_CAN_FLAG_OVERRUN \
+			    | SLC_CAN_FLAG_ERR_PASV | SLC_CAN_FLAG_ARB_LOST \
+			    | SLC_CAN_FLAG_BUS_ERR)
+
 struct slcan {
 	int			magic;
 
@@ -135,6 +146,46 @@ static struct net_device **slcan_devs;
  *
  */
 
+void slc_fill_err_msg(struct can_frame *cf, int tmp)
+{
+	tmp &= SLC_CAN_FLAG_VALID;
+
+	cf->can_id = CAN_ERR_FLAG;
+	cf->can_dlc = CAN_ERR_DLC;
+	*(u64 *) (&cf->data) = 0; /* clear payload */
+
+	if (tmp & SLC_CAN_FLAG_ARB_LOST)
+		cf->can_id |= CAN_ERR_LOSTARB;
+
+	if (tmp & SLC_CAN_FLAG_OVERRUN) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+	}
+
+	/* CAN state: Check most severe problems first */
+
+	if (tmp & SLC_CAN_FLAG_BUS_ERR) {
+		cf->can_id |= CAN_ERR_BUSOFF;
+		return;
+	}
+
+	if (tmp & SLC_CAN_FLAG_ERR_PASV) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_RX_PASSIVE |	CAN_ERR_CRTL_TX_PASSIVE;
+		return;
+	}
+
+	if (tmp & SLC_CAN_FLAG_ERR_WARN) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_RX_WARNING |	CAN_ERR_CRTL_TX_WARNING;
+		return;
+	}
+
+	/* error active - no real problem detected */
+	cf->can_id |= CAN_ERR_PROT;
+	cf->data[2] = CAN_ERR_PROT_ACTIVE;
+}
+
  /************************************************************************
   *			STANDARD SLCAN DECAPSULATION			 *
   ************************************************************************/
@@ -151,6 +202,14 @@ static void slc_bump(struct slcan *sl)
 	cf.can_id = 0;
 
 	switch (*cmd) {
+	case 'F':
+		/* retrieve adapter status information */
+		cmd += SLC_CMD_LEN;
+		tmp = hex_to_bin(*cmd);
+		if (tmp < 0)
+			return;
+		slc_fill_err_msg(&cf, tmp);
+		goto send_cf;
 	case 'r':
 		cf.can_id = CAN_RTR_FLAG;
 		/* fallthrough */
@@ -203,6 +262,7 @@ static void slc_bump(struct slcan *sl)
 		}
 	}
 
+send_cf:
 	skb = dev_alloc_skb(sizeof(struct can_frame) +
 			    sizeof(struct can_skb_priv));
 	if (!skb)
@@ -229,7 +289,7 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    (sl->rcount > 4))  {
+		    (sl->rcount > 2))  {
 			slc_bump(sl);
 		}
 		sl->rcount = 0;
@@ -260,6 +320,11 @@ static void slc_encaps(struct slcan *sl, struct can_frame *cf)
 
 	pos = sl->xbuff;
 
+	if (cf->can_id & CAN_ERR_FLAG) {
+		*pos++ = 'F';
+		goto cmd_done;
+	}
+
 	if (cf->can_id & CAN_RTR_FLAG)
 		*pos = 'R'; /* becomes 'r' in standard frame format (SFF) */
 	else
@@ -292,6 +357,7 @@ static void slc_encaps(struct slcan *sl, struct can_frame *cf)
 			pos = hex_byte_pack_upper(pos, cf->data[i]);
 	}
 
+cmd_done:
 	*pos++ = '\r';
 
 	/* Order of next two lines is *very* important.


