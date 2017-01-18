From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v6] can: dev: add CAN interface termination API
Date: Wed, 18 Jan 2017 18:48:49 +0100
Message-ID: <a8143a03-7218-a37c-7851-d1d6f9e68f3e@hartkopp.net>
References: <20170118145916.10580-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:29996 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbdARRtD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 12:49:03 -0500
In-Reply-To: <20170118145916.10580-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Just a small issue in the commit message:

On 01/18/2017 03:59 PM, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> This patch adds a netlink interface to configure the CAN bus termination of
> CAN interfaces.
>
> Inside the driver an array of supported termination values is defined:
>
> const u16 drvname_termination[] = { 60, 120, CAN_TERMINATION_DISABLED };
>
> struct drvname_priv *priv;
> priv = netdev_priv(dev);
>
> priv->termination_const = &drvname_termination;

This has to be:
priv->termination_const = drvname_termination;

or we will get a incompatible pointer warning.

Found the issue by adding the documentation PoC in usb_8dev for testing:

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 108a30e15097..e17c123c2214 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -896,6 +896,11 @@ static const struct can_bittiming_const 
usb_8dev_bittiming_const = {
         .brp_inc = 1,
  };

+static const u16 usb_8dev_termination[] = { 60, 120, 
CAN_TERMINATION_DISABLED };
+static int usb_8dev_set_termination(struct net_device *netdev, u16 term) {
+       return 0;
+}
+
  /* Probe USB device
   *
   * Check device and firmware.
@@ -929,7 +934,10 @@ static int usb_8dev_probe(struct usb_interface *intf,

         priv->udev = usbdev;
         priv->netdev = netdev;
-
+       priv->can.termination_const = usb_8dev_termination;
+       priv->can.termination_const_cnt = ARRAY_SIZE(usb_8dev_termination);
+       priv->can.termination = CAN_TERMINATION_DISABLED;
+       priv->can.do_set_termination = usb_8dev_set_termination;
         priv->can.state = CAN_STATE_STOPPED;
         priv->can.clock.freq = USB_8DEV_ABP_CLOCK;
         priv->can.bittiming_const = &usb_8dev_bittiming_const;

Besides this nitpick the patch is ready to be committed :-)

Regards,
Oliver

