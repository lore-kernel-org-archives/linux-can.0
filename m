From: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: Re: ems_usb: endianess warning
Date: Tue, 24 Mar 2015 19:02:29 +0100
Message-ID: <5511A6B5.2010507@ems-wuensche.com>
References: <55044620.60903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ems-wuensche.com ([85.214.92.62]:44838 "EHLO
	mail.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbbCXSLB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Mar 2015 14:11:01 -0400
In-Reply-To: <55044620.60903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Sebastian Haas <haas@ems-wuensche.com>, Sebastian Haas <dev@sebastianhaas.info>

Hi Marc,

this took some time, sorry.

Regards
Gerhard

The device expects the id in le format.

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 9376f5e..481f539 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -123,7 +123,7 @@ MODULE_LICENSE("GPL v2");
  * CPC_MSG_TYPE_EXT_CAN_FRAME or CPC_MSG_TYPE_EXT_RTR_FRAME.
  */
 struct cpc_can_msg {
-       u32 id;
+       __le32 id;
        u8 length;
        u8 msg[8];
 };
@@ -765,7 +765,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne

        msg = (struct ems_cpc_msg *)&buf[CPC_HEADER_SIZE];

-       msg->msg.can_msg.id = cf->can_id & CAN_ERR_MASK;
+       msg->msg.can_msg.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
        msg->msg.can_msg.length = cf->can_dlc;

        if (cf->can_id & CAN_RTR_FLAG) {
@@ -783,9 +783,6 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
                msg->length = CPC_CAN_MSG_MIN_SIZE + cf->can_dlc;
        }

-       /* Respect byte order */
-       msg->msg.can_msg.id = cpu_to_le32(msg->msg.can_msg.id);
-
        for (i = 0; i < MAX_TX_URBS; i++) {
                if (dev->tx_contexts[i].echo_index == MAX_TX_URBS) {
                        context = &dev->tx_contexts[i];

--

Am 14.03.2015 um 15:30 schrieb Marc Kleine-Budde:
> Hello,
> 
> when compiling with sparse (make C=2), the ems driver throws the
> following warning, can someone, preferred the driver author :), take
> care of fixing them?
> 
>> drivers/net/can/usb/ems_usb.c:312:22: warning: cast to restricted __le32
>> drivers/net/can/usb/ems_usb.c:787:29: warning: incorrect type in assignment (different base types)
>> drivers/net/can/usb/ems_usb.c:787:29:    expected unsigned int [unsigned] [usertype] id
>> drivers/net/can/usb/ems_usb.c:787:29:    got restricted __le32 [usertype] <noident>
> 
> regards,
> Marc
> 

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HRA Neuburg a.d. Donau, HR-Nr. 70.106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
