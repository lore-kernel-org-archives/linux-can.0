From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/peak_usb: fix memset() usage
Date: Mon, 01 Dec 2014 20:37:12 +0100
Message-ID: <547CC368.6080509@hartkopp.net>
References: <1417180128-28509-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:22659 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaLAThR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 1 Dec 2014 14:37:17 -0500
In-Reply-To: <1417180128-28509-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

Hello Stephane,

these two patches look good for stable.
I assume Marc will take them, when he has time for it.

What about the other patches?

Best regards,
Oliver

On 11/28/2014 02:08 PM, Stephane Grosjean wrote:
> This patchs fixes a misplaced call to memset() that fills the request
> buffer with 0. The problem was with sending PCAN_USBPRO_REQ_FCT
> requests, the content set by the caller was thus lost.
> 
> With this patch, the memory area is zeroed only when requesting info
> from the device.
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index 263dd92..f7f796a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -333,8 +333,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
>  	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>  		return 0;
>  
> -	memset(req_addr, '\0', req_size);
> -
>  	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
>  
>  	switch (req_id) {
> @@ -345,6 +343,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
>  	default:
>  		p = usb_rcvctrlpipe(dev->udev, 0);
>  		req_type |= USB_DIR_IN;
> +		memset(req_addr, '\0', req_size);
>  		break;
>  	}
>  
> 
