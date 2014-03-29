From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH: 3.11] usb_8dev: Fix memory leak in usb_8dev_start_xmit
Date: Sat, 29 Mar 2014 08:17:44 +0100
Message-ID: <53367398.7010006@universalnet.at>
References: <CAMEA=P1AaDL94S8kaep-F012WAseimAyB7ME11Qzd0UMbp-BGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:55612 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750928AbaC2HZh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 29 Mar 2014 03:25:37 -0400
In-Reply-To: <CAMEA=P1AaDL94S8kaep-F012WAseimAyB7ME11Qzd0UMbp-BGg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bjorn Van Tilt <bjorn.vantilt@gmail.com>, linux-can@vger.kernel.org

Applied to the driver sources (outside kernel tree): https://github.com/krumboeck/usb2can

Thank you!


regards,
Bernd



Am 2014-03-24 15:13, schrieb Bjorn Van Tilt:
> Fixed a memory leak when an error occurred in the transmit function.
> In the error handling the urb wasn't freed before returning. There was
> also a call to the usb_unanchor_urb() function but the urb wasn't
> anchored.
>
> Signed-off-by: Bjorn Van Tilt <bjorn.vantilt@gmail.com>
>
> ---
> --- drivers/net/can/usb/usb_8dev.c.orig 2014-03-24 13:40:45.000000000 +0100
> +++ drivers/net/can/usb/usb_8dev.c 2014-03-24 13:44:32.076086036 +0100
> @@ -698,8 +698,8 @@ static netdev_tx_t usb_8dev_start_xmit(s
>    return NETDEV_TX_OK;
>
>   nofreecontext:
> - usb_unanchor_urb(urb);
>    usb_free_coherent(priv->udev, size, buf, urb->transfer_dma);
> + usb_free_urb(urb);
>
>    netdev_warn(netdev, "couldn't find free context");
>

