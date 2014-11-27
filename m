From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files modifications
Date: Thu, 27 Nov 2014 12:44:08 +0100
Message-ID: <54770E88.3080907@hartkopp.net>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com> <1417084329-8997-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:46003 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbaK0LoM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 06:44:12 -0500
In-Reply-To: <1417084329-8997-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

On 27.11.2014 11:32, Stephane Grosjean wrote:

> @@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
>   	return (i >= PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
>   }
>
> -static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
> -				 int req_value, void *req_addr, int req_size)
> +int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
> +			  int req_value, void *req_addr, int req_size)
>   {
>   	int err;
>   	u8 req_type;
> @@ -333,8 +325,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
>   	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>   		return 0;
>
> -	memset(req_addr, '\0', req_size);
> -
>   	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
>
>   	switch (req_id) {
> @@ -345,6 +335,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
>   	default:
>   		p = usb_rcvctrlpipe(dev->udev, 0);
>   		req_type |= USB_DIR_IN;
> +		memset(req_addr, '\0', req_size);
>   		break;
>   	}
>

This movement of the memset also looks like a stable candidate, right?

Best regards,
Oliver

