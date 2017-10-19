From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: gs_usb: fix busy loop if no more TX context is
 available
Date: Thu, 19 Oct 2017 10:07:21 +0200
Message-ID: <7e8d89c3-b7af-81c1-cbed-04e83b396162@grandegger.com>
References: <081cdc97-4633-f9b2-2c48-dd4f036c576f@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:35414 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdJSIHX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Oct 2017 04:07:23 -0400
In-Reply-To: <081cdc97-4633-f9b2-2c48-dd4f036c576f@grandegger.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

any comments/feedback about that issue? I wonder why it has not been 
showed up earlier.

Wolfgang.

Am 14.09.2017 um 18:37 schrieb Wolfgang Grandegger:
> If sending messages with no cable connected, it quickly happens that
> there is no more TX context available. Then "gs_can_start_xmit()"
> returns with "NETDEV_TX_BUSY" and the upper layer does retry
> immediately keeping the CPU busy. To fix that issue, I moved
> "atomic_dec(&dev->active_tx_urbs)" from "gs_usb_xmit_callback()" to
> the TX done handling in "gs_usb_receive_bulk_callback()". Renaming
> "active_tx_urbs" to "active_tx_contexts" and moving it into
> "gs_[alloc|free]_tx_context()" would also make sense.
> 
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>   drivers/net/can/usb/gs_usb.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index afcc131..68ac3e8 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -375,6 +375,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>   
>   		gs_free_tx_context(txc);
>   
> +		atomic_dec(&dev->active_tx_urbs);
> +
>   		netif_wake_queue(netdev);
>   	}
>   
> @@ -463,14 +465,6 @@ static void gs_usb_xmit_callback(struct urb *urb)
>   			  urb->transfer_buffer_length,
>   			  urb->transfer_buffer,
>   			  urb->transfer_dma);
> -
> -	atomic_dec(&dev->active_tx_urbs);
> -
> -	if (!netif_device_present(netdev))
> -		return;
> -
> -	if (netif_queue_stopped(netdev))
> -		netif_wake_queue(netdev);
>   }
>   
>   static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
> 
