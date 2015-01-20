From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v5] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Tue, 20 Jan 2015 13:08:46 +0000
Message-ID: <20150120130846.13173.9714@shannon>
References: <1421757005-17271-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0053.outbound.protection.outlook.com ([157.56.112.53]:17632
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751241AbbATNIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 08:08:55 -0500
In-Reply-To: <1421757005-17271-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

Quoting Stephane Grosjean (2015-01-20 12:30:05)
> +/* handle uCAN status message */
> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
> +                                    struct pucan_msg *rx_msg)
> +{
> +       struct pucan_status_msg *sm = (struct pucan_status_msg *)rx_msg;
> +       struct peak_usb_device *dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
> +       struct pcan_usb_fd_device *pdev =
> +                       container_of(dev, struct pcan_usb_fd_device, dev);
> +       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> +       struct net_device *netdev = dev->netdev;
> +       struct can_frame *cf;
> +       struct sk_buff *skb = NULL;
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
> +       if (new_state != dev->can.state) {
> +               enum can_state rx_state, tx_state;
> +
> +               tx_state = (pdev->bec.txerr >= pdev->bec.rxerr) ?
> +                       new_state : 0;
> +               rx_state = (pdev->bec.txerr <= pdev->bec.rxerr) ?
> +                       new_state : 0;
> +
> +               /* allocate an skb to store the error frame */
> +               skb = alloc_can_err_skb(netdev, &cf);
> +               if (skb)
> +                       can_change_state(netdev, cf, tx_state, rx_state);
> +
> +               if (new_state == CAN_STATE_BUS_OFF)
> +                       can_bus_off(netdev);
> +       }
> +
> +       if (!skb)
> +               return -ENOMEM;
Consider if new_state != dev->can.state, then skb == NULL, ergo function will
return -ENOMEM here.
> +
> +       peak_usb_netif_rx(skb, &usb_if->time_ref,
> +                         le32_to_cpu(sm->ts_low), le32_to_cpu(sm->ts_high));
Nothing is applied to skb/cf outside of the scope within which it is allocated.
Placing this rx call inside the if-statement's scope would solve the problem
that I described above. The OOM check should of course also be moved into said
scope.
> +
> +       netdev->stats.rx_packets++;
> +       netdev->stats.rx_bytes += cf->can_dlc;
> +
> +       return 0;
> +}

See comments above.

Best regards,
Andri
