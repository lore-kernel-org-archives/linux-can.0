From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: Fwd: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Wed, 14 Jan 2015 13:00:16 +0000
Message-ID: <20150114130016.26007.31476@shannon>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
 <54B65B9E.1000608@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0086.outbound.protection.outlook.com ([157.55.234.86]:5632
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752954AbbANNAY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Jan 2015 08:00:24 -0500
In-Reply-To: <54B65B9E.1000608@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Quoting Stephane Grosjean (2015-01-14 12:05:50)
> Hi Wolfgang and Andri,
> 
> So, Marc told me to start a discussion around the handling of the status 
> information this CANFD driver is able to receive from the hardware.
> This, how to proceed next, please? FYI, everything is located in 
> "pcan_usb_fd_decode_status()" below...
> 
Hi Stephane,

A lot of the state-transition logic is the same between platforms, but because
everyone implements their own logic, things don't behave exactly the same way
between platforms (as they should).

See:
http://article.gmane.org/gmane.linux.can/7162
http://article.gmane.org/gmane.linux.can/7163
http://article.gmane.org/gmane.linux.can/7164

...
> +
> +/* handle uCAN status message */
> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
> +                                    struct pucan_msg *rx_msg)
> +{
> +       struct pucan_status_msg *st = (struct pucan_status_msg *)rx_msg;
> +       struct peak_usb_device *dev = usb_if->dev[PUCAN_STMSG_CHANNEL(st)];
> +       struct pcan_usb_fd_device *pdev =
> +                       container_of(dev, struct pcan_usb_fd_device, dev);
> +       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
> +       struct net_device *netdev = dev->netdev;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +
> +       /* nothing should be sent while in BUS_OFF state */
> +       if (dev->can.state == CAN_STATE_BUS_OFF)
> +               return 0;
> +
> +       if (PUCAN_STMSG_BUSOFF(st)) {
> +               new_state = CAN_STATE_BUS_OFF;
> +       } else if (PUCAN_STMSG_PASSIVE(st)) {
> +               new_state = CAN_STATE_ERROR_PASSIVE;
> +       } else if (PUCAN_STMSG_WARNING(st)) {
> +               new_state = CAN_STATE_ERROR_WARNING;
> +       } else {
> +               /* no error bit (so, no error skb, back to active state) */
> +               dev->can.state = CAN_STATE_ERROR_ACTIVE;
> +               pdev->tx_error_counter = 0;
> +               pdev->rx_error_counter = 0;
> +               return 0;
> +       }
> +
> +       /* donot post any error if current state didn't change */
> +       if (dev->can.state == new_state)
> +               return 0;
> +
> +       /* allocate an skb to store the error frame */
> +       skb = alloc_can_err_skb(netdev, &cf);
> +       if (!skb)
> +               return -ENOMEM;
> +
You can replace this:
> +       switch (new_state) {
> +       case CAN_STATE_BUS_OFF:
> +               cf->can_id |= CAN_ERR_BUSOFF;
> +               can_bus_off(netdev);
> +               break;
> +
> +       case CAN_STATE_ERROR_PASSIVE:
> +               cf->can_id |= CAN_ERR_CRTL;
> +               if (pdev->rx_error_counter > 127)
> +                       cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
> +               if (pdev->tx_error_counter > 127)
> +                       cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
> +
> +               dev->can.can_stats.error_passive++;
> +               break;
> +
> +       case CAN_STATE_ERROR_WARNING:
> +               cf->can_id |= CAN_ERR_CRTL;
> +               if (pdev->rx_error_counter > 96)
> +                       cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
> +               if (pdev->tx_error_counter > 96)
> +                       cf->data[1] |= CAN_ERR_CRTL_TX_WARNING;
> +
> +               dev->can.can_stats.error_warning++;
> +               break;
> +
> +       default:
> +               /* default case never happens, only for warnings */
> +               new_state = CAN_STATE_ERROR_ACTIVE;
> +
> +       case CAN_STATE_ERROR_ACTIVE:    /* fallthrough */
> +               pdev->tx_error_counter = 0;
> +               pdev->rx_error_counter = 0;
> +               break;
> +       }
> +
> +       dev->can.state = new_state;
With something like this:
    if(state != dev->can.state) {
        tx_state = get_state_from_counter(pdev->rx_error_counter);
        rx_state = get_state_from_counter(pdev->tx_error_counter);

        can_change_state(dev, cf, tx_state, rx_state);

        if(state == CAN_STATE_BUS_OFF)
            can_bus_off(dev);
    }

> +
> +       peak_usb_netif_rx(skb, &usb_if->time_ref,
> +                         le32_to_cpu(st->ts_low), le32_to_cpu(st->ts_high));
> +
> +       netdev->stats.rx_packets++;
> +       netdev->stats.rx_bytes += cf->can_dlc;
> +
> +       return 0;
> +}
> +

You can test the state transitions by disconnecting and connecting the can-bus
and verify that the state goes active -> warning -> passive when you disconnect
then passive -> warning -> active when you connect the bus again.

This shows how I tested my code: http://article.gmane.org/gmane.linux.can/7164

Best regards,
Andri
