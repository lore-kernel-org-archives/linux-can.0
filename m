From: Bjorn Van Tilt <bjorn.vantilt@gmail.com>
Subject: [PATCH: 3.11] usb_8dev: Fix memory leak in usb_8dev_start_xmit
Date: Mon, 24 Mar 2014 15:13:54 +0100
Message-ID: <CAMEA=P1AaDL94S8kaep-F012WAseimAyB7ME11Qzd0UMbp-BGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:41832 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbaCXONz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Mar 2014 10:13:55 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: krumboeck@universalnet.at, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fixed a memory leak when an error occurred in the transmit function.
In the error handling the urb wasn't freed before returning. There was
also a call to the usb_unanchor_urb() function but the urb wasn't
anchored.

Signed-off-by: Bjorn Van Tilt <bjorn.vantilt@gmail.com>

---
--- drivers/net/can/usb/usb_8dev.c.orig 2014-03-24 13:40:45.000000000 +0100
+++ drivers/net/can/usb/usb_8dev.c 2014-03-24 13:44:32.076086036 +0100
@@ -698,8 +698,8 @@ static netdev_tx_t usb_8dev_start_xmit(s
  return NETDEV_TX_OK;

 nofreecontext:
- usb_unanchor_urb(urb);
  usb_free_coherent(priv->udev, size, buf, urb->transfer_dma);
+ usb_free_urb(urb);

  netdev_warn(netdev, "couldn't find free context");
