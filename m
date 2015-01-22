From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Thu, 22 Jan 2015 16:02:38 +0000
Message-ID: <20150122160238.12081.76464@shannon>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
 <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0060.outbound.protection.outlook.com ([157.56.112.60]:30944
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752067AbbAVQIN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 11:08:13 -0500
In-Reply-To: <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Quoting Stephane Grosjean (2015-01-22 15:24:26)
[...]
> +/* handle uCAN status message */
> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
> +                                    struct pucan_msg *rx_msg)
> +{
> +       struct pucan_status_msg *sm = (struct pucan_status_msg *)rx_msg;
> +       struct peak_usb_device *dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
> +       struct pcan_usb_fd_device *pdev =
> +                       container_of(dev, struct pcan_usb_fd_device, dev);
> +       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> +       enum can_state rx_state, tx_state;
> +       struct net_device *netdev = dev->netdev;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +
> +       /* nothing should be sent while in BUS_OFF state */
> +       if (dev->can.state == CAN_STATE_BUS_OFF)
> +               return 0;
> +
> +       if (sm->channel_p_w_b & PUCAN_BUS_BUSOFF) {
> +               new_state = CAN_STATE_BUS_OFF;
> +       } else if (sm->channel_p_w_b & PUCAN_BUS_PASSIVE) {
> +               new_state = CAN_STATE_ERROR_PASSIVE;
> +       } else if (sm->channel_p_w_b & PUCAN_BUS_WARNING) {
> +               new_state = CAN_STATE_ERROR_WARNING;
> +       } else {
> +               /* no error bit (so, no error skb, back to active state) */
> +               dev->can.state = CAN_STATE_ERROR_ACTIVE;
> +               pdev->bec.txerr = 0;
> +               pdev->bec.rxerr = 0;
> +               return 0;
> +       }
> +
> +       /* state hasn't changed */
> +       if (new_state == dev->can.state)
> +               return 0;
> +
> +       /* handle bus state change */
> +       tx_state = (pdev->bec.txerr >= pdev->bec.rxerr) ?  new_state : 0;
> +       rx_state = (pdev->bec.txerr <= pdev->bec.rxerr) ?  new_state : 0;
You seem to have extra spaces here -------------------------^
> +
> +       /* allocate an skb to store the error frame */
> +       skb = alloc_can_err_skb(netdev, &cf);
> +       if (skb)
> +               can_change_state(netdev, cf, tx_state, rx_state);
> +
> +       /* things must be done even in case of OOM */
> +       if (new_state == CAN_STATE_BUS_OFF)
> +               can_bus_off(netdev);
> +
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       peak_usb_netif_rx(skb, &usb_if->time_ref,
> +                         le32_to_cpu(sm->ts_low), le32_to_cpu(sm->ts_high));
> +
> +       netdev->stats.rx_packets++;
> +       netdev->stats.rx_bytes += cf->can_dlc;
> +
> +       return 0;
> +}
> +
[...]

ACK, but you'll probably want to remove those extra spaces *if* you post another
version of the patch set.

Best regards,
Andri
