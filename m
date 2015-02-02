From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: [PATCH] can: kvaser_usb: Ignore spurious error events after a busoff
Date: Mon, 2 Feb 2015 15:15:55 -0500
Message-ID: <20150202201555.GA29327@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33296 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238AbbBBUQA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Feb 2015 15:16:00 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so40923653wgh.6
        for <linux-can@vger.kernel.org>; Mon, 02 Feb 2015 12:15:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

From: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Sending data in high speed then introducing a busoff results
in spurious BUS_ERROR events from the USBCan-II firmware directly
_after_ the triggered BUS_OFF event.

In the current CAN state handling code, this will lead to an
invalid can state of ACTIVE, ERROR, or PASSIVE even though the
CAN controller has been already shut down due to the busoff.

Guard the state handling code from such invalid events.

Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

The patch is generated above linux-can-next tag:

	`linux-can-next-for-3.20-20150128'

Scenario #1) Before the patch, send data then introduce a bus-off:

 (1422904150.823691)  can0  20000080   [8]  00 00 00 00 00 00 30 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422904150.823703)  can0  20000084   [8]  00 20 00 00 00 00 80 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{128}{0}}
 (1422904150.823703)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422904150.824039)  can0  20000080   [8]  00 00 00 00 00 00 90 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{144}{0}}
 (1422904150.824039)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422904150.824040)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422904150.825038)  can0  20000080   [8]  00 00 00 00 00 00 A8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{168}{0}}
 (1422904150.827325)  can0  20000084   [8]  00 40 00 00 00 00 30 00   ERRORFRAME
	controller-problem{back-to-error-active}
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422904150.827334)  can0  20000084   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422904150.827335)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422904150.827536)  can0  20000080   [8]  00 00 00 00 00 00 90 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{144}{0}}
 (1422904150.827536)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422904150.827536)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422904150.828714)  can0  20000080   [8]  00 00 00 00 00 00 A8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{168}{0}}
 (1422904150.828716)  can0  20000080   [8]  00 00 00 00 00 00 B0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{176}{0}}

 [[ Same transitions as in above 'active -> passive -> back_to_active'
    several times... ]]

 (1422904150.907488)  can0  20000084   [8]  00 40 00 00 00 00 30 00   ERRORFRAME
	controller-problem{back-to-error-active}
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422904150.907496)  can0  20000084   [8]  00 20 00 00 00 00 78 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{120}{0}}
 (1422904150.907497)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422904150.908722)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422904150.908724)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422904151.933234)  can0  200000C0   [8]  00 00 00 00 00 00 00 7F   ERRORFRAME
	bus-off
	bus-error
	error-counter-tx-rx{{0}{127}}

 [[ Spurious bus error events after bus off ]]

 (1422904151.933248)  can0  20000084   [8]  00 40 00 00 00 00 38 00   ERRORFRAME
	controller-problem{back-to-error-active}
	bus-error
	error-counter-tx-rx{{56}{0}}
 (1422904151.933659)  can0  20000084   [8]  00 20 00 00 00 00 80 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{128}{0}}
 (1422904151.933659)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422904151.933660)  can0  20000080   [8]  00 00 00 00 00 00 90 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{144}{0}}
 (1422904151.935096)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422904151.935098)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422904151.935100)  can0  20000080   [8]  00 00 00 00 00 00 A8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{168}{0}}

 [[ then silence ... ]]

$ ip -details link show can0
  ...
  can state ERROR_PASSIVE
  ...

*********************************************************************

Scenario #2) After the patch, send data then introduce a bus-off:

 (1422906019.370441)  can0  20000080   [8]  00 00 00 00 00 00 30 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422906019.370449)  can0  20000084   [8]  00 20 00 00 00 00 80 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{128}{0}}
 (1422906019.370450)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422906019.370834)  can0  20000080   [8]  00 00 00 00 00 00 90 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{144}{0}}
 (1422906019.370836)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422906019.370836)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422906019.371860)  can0  20000080   [8]  00 00 00 00 00 00 A8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{168}{0}}
 (1422906019.374248)  can0  20000084   [8]  00 40 00 00 00 00 30 00   ERRORFRAME
	controller-problem{back-to-error-active}
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422906019.374256)  can0  20000084   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422906019.374257)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422906019.374441)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}

 [[ Same transitions as in above 'active -> passive -> back_to_active'
    several times... ]]

 (1422906019.454078)  can0  20000084   [8]  00 40 00 00 00 00 30 00   ERRORFRAME
	controller-problem{back-to-error-active}
	bus-error
	error-counter-tx-rx{{48}{0}}
 (1422906019.454086)  can0  20000084   [8]  00 20 00 00 00 00 78 00   ERRORFRAME
	controller-problem{tx-error-passive}
	bus-error
	error-counter-tx-rx{{120}{0}}
 (1422906019.454086)  can0  20000080   [8]  00 00 00 00 00 00 88 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{136}{0}}
 (1422906019.454426)  can0  20000080   [8]  00 00 00 00 00 00 90 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{144}{0}}
 (1422906019.454427)  can0  20000080   [8]  00 00 00 00 00 00 98 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{152}{0}}
 (1422906019.454427)  can0  20000080   [8]  00 00 00 00 00 00 A0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{160}{0}}
 (1422906019.455310)  can0  20000080   [8]  00 00 00 00 00 00 A8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{168}{0}}
 (1422906019.455311)  can0  20000080   [8]  00 00 00 00 00 00 B0 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{176}{0}}
 (1422906019.455312)  can0  20000080   [8]  00 00 00 00 00 00 B8 00   ERRORFRAME
	bus-error
	error-counter-tx-rx{{184}{0}}
 (1422906020.470092)  can0  200000C0   [8]  00 00 00 00 00 00 00 0A   ERRORFRAME
	bus-off
	bus-error
	error-counter-tx-rx{{0}{10}}

 [[ then silence ... ]]

$ ip -details link show can0
  ...
  can state BUS_OFF
  ...

*********************************************************************

Scenario #3) regular cangen, then unplug, then re-plug:

 [[ No change in behavior before or after the patch, as expected ]]

 (1422897112.214942)  can0  51D   [4]  FF 02 00 00
 (1422897112.225063)  can0  701   [8]  00 03 00 00 00 00 00 00
 (1422897112.235218)  can0  010   [5]  01 03 00 00 00
 (1422897112.245331)  can0  53B   [8]  02 03 00 00 00 00 00 00
 (1422897112.255331)  can0  2DA   [5]  03 03 00 00 00
 (1422897112.265469)  can0  20000080   [8]  00 00 00 00 00 00 00 01   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{1}}
 (1422897112.265571)  can0  20000080   [8]  00 00 00 00 00 00 00 0A   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{10}}
 (1422897112.266216)  can0  20000080   [8]  00 00 00 00 00 00 00 13   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{19}}
 (1422897112.266219)  can0  20000080   [8]  00 00 00 00 00 00 00 1C   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{28}}
 (1422897112.266584)  can0  20000080   [8]  00 00 00 00 00 00 00 40   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{64}}
 (1422897112.266586)  can0  20000080   [8]  00 00 00 00 00 00 00 49   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{73}}
 (1422897112.266587)  can0  20000080   [8]  00 00 00 00 00 00 00 52   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{82}}
 (1422897112.266693)  can0  20000080   [8]  00 00 00 00 00 00 00 5B   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{91}}
 (1422897112.267609)  can0  20000084   [8]  00 04 00 00 00 00 00 64   ERRORFRAME
	controller-problem{rx-error-warning}
	bus-error
	error-counter-tx-rx{{0}{100}}
 (1422897112.267610)  can0  20000080   [8]  00 00 00 00 00 00 00 75   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{117}}
 (1422897112.267821)  can0  20000084   [8]  00 10 00 00 00 00 00 87   ERRORFRAME
	controller-problem{rx-error-passive}
	bus-error
	error-counter-tx-rx{{0}{135}}
 (1422897112.267822)  can0  20000080   [8]  00 00 00 00 00 00 00 87   ERRORFRAME
	bus-error
	error-counter-tx-rx{{0}{135}}

 [[ Then same of the above ]]

 (1422897119.890745)  can0  190   [8]  04 03 00 00 00 00 00 00
 (1422897119.890890)  can0  749   [8]  05 03 00 00 00 00 00 00
 (1422897119.891297)  can0  3B5   [8]  06 03 00 00 00 00 00 00
 (1422897119.891417)  can0  74B   [8]  07 03 00 00 00 00 00 00
 (1422897119.891880)  can0  5F6   [8]  08 03 00 00 00 00 00 00

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 17d28d7..2928f70 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2002-2006 KVASER AB, Sweden. All rights reserved.
  * Copyright (C) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
  * Copyright (C) 2012 Olivier Sobrie <olivier@sobrie.be>
- * Copyright (C) 2015 Valeo A.S.
+ * Copyright (C) 2015 Valeo S.A.
  */
 
 #include <linux/completion.h>
@@ -824,14 +824,15 @@ static void kvaser_usb_rx_error_update_can_state(struct kvaser_usb_net_priv *pri
 	else if (es->status & M16C_STATE_BUS_PASSIVE)
 		new_state = CAN_STATE_ERROR_PASSIVE;
 	else if (es->status & M16C_STATE_BUS_ERROR) {
-		if ((es->txerr >= 256) || (es->rxerr >= 256))
-			new_state = CAN_STATE_BUS_OFF;
-		else if ((es->txerr >= 128) || (es->rxerr >= 128))
-			new_state = CAN_STATE_ERROR_PASSIVE;
-		else if ((es->txerr >= 96) || (es->rxerr >= 96))
-			new_state = CAN_STATE_ERROR_WARNING;
-		else if (cur_state > CAN_STATE_ERROR_ACTIVE)
-			new_state = CAN_STATE_ERROR_ACTIVE;
+		/* Guard against spurious error events after a busoff */
+		if (cur_state < CAN_STATE_BUS_OFF) {
+			if ((es->txerr >= 128) || (es->rxerr >= 128))
+				new_state = CAN_STATE_ERROR_PASSIVE;
+			else if ((es->txerr >= 96) || (es->rxerr >= 96))
+				new_state = CAN_STATE_ERROR_WARNING;
+			else if (cur_state > CAN_STATE_ERROR_ACTIVE)
+				new_state = CAN_STATE_ERROR_ACTIVE;
+		}
 	}
 
 	if (!es->status)
-- 
1.9.1

