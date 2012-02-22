From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 08:30:19 +0100
Message-ID: <4F44998B.3040302@hartkopp.net>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com> <4F44939D.9050703@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:18371 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544Ab2BVHan (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 02:30:43 -0500
In-Reply-To: <4F44939D.9050703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 22.02.2012 08:05, Oliver Hartkopp wrote:


> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519539] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-71)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519592] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-71)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519632] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519707] peak_usb 2-1.3:1.0: can3: Rx URB aborted (-71)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.519746] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!


(..)

> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615114] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-108)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615117] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615120] peak_usb 2-1.3:1.0: can2: Tx URB aborted (-108)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615124] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.615130] peak_usb 2-1.3:1.0: can_put_echo_skb: BUG! echo_skb is occupied!
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623962] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)
> Feb 21 20:27:10 vwagwolkf484 kernel: [ 3162.623969] peak_usb 2-1.3:1.0: can3: Tx URB aborted (-108)


-71  => EPROTO          71      /* Protocol error */
-108 => ESHUTDOWN       108     /* Cannot send after transport endpoint shutdown */

+/*
+ * callback for bulk Tx urb
+ */
+static void peak_usb_write_bulk_callback(struct urb *urb)
+{
+       struct peak_tx_urb_context *context = urb->context;
+       struct peak_usb_device *dev;
+       struct net_device *netdev;
+
+       BUG_ON(!context);
+
+       dev = context->dev;
+       netdev = dev->netdev;
+
+       atomic_dec(&dev->active_tx_urbs);
+
+       if (!netif_device_present(netdev))
+               return;
+
+       switch (urb->status) {
+       case 0: /* tx ok */
+               netdev->trans_start = jiffies;
+
+               /* transmission complete interrupt */
+               netdev->stats.tx_packets++;
+               netdev->stats.tx_bytes += context->dlc;
+
+               can_get_echo_skb(netdev, context->echo_index);
+               break;
+
+       case -ENOENT: /* on ifconfig down */
+               break;
+       default:
+               netdev_err(netdev, "Tx URB aborted (%d)\n", urb->status);

Just printing this status and continue with business as usual (netif_wake_queue!) is probably not the right approach 8-)

Please check if it makes sense to check (urb->status != 0) earlier in this callback function.
 
+       }
+
+       /* release context */
+       context->echo_index = PCAN_USB_MAX_TX_URBS;
+
+       netif_wake_queue(netdev);
+}


