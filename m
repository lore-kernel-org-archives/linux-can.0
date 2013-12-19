From: "Glen, Andrew" <AGlen@bepmarine.com>
Subject: [PATCH] can: c_can: tx interrupts can be missed, check for tx
 outside of just the tx interrupt routine
Date: Thu, 19 Dec 2013 19:38:57 +0000
Message-ID: <F29A6C278512904F884221EFA2821933C357@AMEHLEX01.ehl.pri>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.10]:22479 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754556Ab3LSTi7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Dec 2013 14:38:59 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Using the c_can driver on an AM335x platform (the Beaglebone Black) I have found that tx interrupts can be occasionally missed, causing the tx queue to halt indefinitely (i.e. until manually restarted with a can down/up).

The fault occurs when there is a high can-bus load (~40% @ 250k) and I hot-swapping a usb devices (i.e. continuously plugging and unplugging a usb flash drive the fault will occur about 1/10 of the time) - I'd assume there would be other processor intensive combinations of things that would also cause this problem.

The can device continues to rx fine, and reports no obvious fault, other than rejecting new message writes due to a tx buffer overflow, which can then only be cleared by bringing the device down and then back up again.

To ensure tx events are always handled even if a tx interrupt is missed, I propose the following patch to check for a successful tx on every can interrupt, including rx and state changes. If a successful tx is detected in any of these cases a conditional call to netif_wake_queue is called.

My initial thought was to perform this check the 'c_can_start_xmit' function, but it is my understanding that once 'netif_stop_queue' has been called there will be no further calls made to 'c_can_start_xmit' until 'netif_wake_queue' has been called - which is only ever occurs after a tx interrupt has been handled - which as noted earlier can be problematic. So even checking for a successful tx in 'c_can_start_xmit' would catch most cases of missed tx interrupts, it would still leave open the corner case that if the tx buffer did become full and then very next successful tx was missed, the tx queue would become stuck.

This obviously introduces some redundancy, in terms of the frequency at which the tx register is checked, but I think this is a necessary backstop for missed interrupts under all circumstances.

Reported-by: Andrew Glen <AGlen@bepmarine.com>
Tested-by: Andrew Glen <AGlen@bepmarine.com>
---

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 77061ee..447c873 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -756,6 +756,7 @@ static void c_can_do_tx(struct net_device *dev)
        u32 msg_obj_no;
        struct c_can_priv *priv = netdev_priv(dev);
        struct net_device_stats *stats = &dev->stats;
+       bool tx_done = false;

        for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
                msg_obj_no = get_tx_echo_msg_obj(priv);
@@ -770,15 +771,19 @@ static void c_can_do_tx(struct net_device *dev)
                        stats->tx_packets++;
                        can_led_event(dev, CAN_LED_EVENT_TX);
                        c_can_inval_msg_object(dev, 0, msg_obj_no);
+                       tx_done = true;
                } else {
                        break;
                }
        }

-       /* restart queue if wrap-up or if queue stalled on last pkt */
-       if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
-                       ((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
-               netif_wake_queue(dev);
+    if (tx_done)
+    {
+               /* restart queue if wrap-up or if queue stalled on last pkt */
+               if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
+                               ((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
+                   netif_wake_queue(dev);
+       }
 }

 /*
@@ -1082,6 +1087,9 @@ static int c_can_poll(struct napi_struct *napi, int quota)
                c_can_do_tx(dev);
        }

+       /* Always check for successful tx */
+       c_can_do_tx(dev);
+
 end:
        if (work_done < quota) {
                napi_complete(napi);

________________________________

Actuant Corporation Email Notice

This message is intended only for the use of the Addressee and may contain information that is PRIVILEGED and/or CONFIDENTIAL.
This email is intended only for the personal and confidential use of the recipient(s) named above. If the reader of this email is not an intended recipient, you have received this email in error and any review, dissemination, distribution or copying is strictly prohibited.
If you have received this email in error, please notify the sender immediately by return mail and permanently delete the copy you received.

Thank you.
