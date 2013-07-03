From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: [PATCH] net: can: esd_usb2: check index of array before accessing
Date: Wed, 3 Jul 2013 12:00:24 +0200
Message-ID: <51D3F638.3080207@esd.eu>
References: <1372840409-13481-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from emita2.mittwald.de ([188.94.250.252]:53017 "EHLO
	emita2.mittwald.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab3GCKID (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 06:08:03 -0400
Received: from mx51.mymxserver.com (mail5120.internal [172.16.51.20])
	by emita2.mittwald.de (Postfix) with ESMTP id 084DE2302A4
	for <linux-can@vger.kernel.org>; Wed,  3 Jul 2013 12:02:16 +0200 (CEST)
In-Reply-To: <1372840409-13481-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Maximilian Schneider <max@schneidersoft.net>

Hi,

did anybody encounter an issue with invalid net codes comming from the
device?

Well, you may add my

Acked-by: Matthias Fuchs <matthias.fuchs@esd.eu>

Matthias

On 03.07.2013 10:33, Marc Kleine-Budde wrote:
> From: Maximilian Schneider <max@schneidersoft.net>
> 
> The esd_usb2_read_bulk_callback() function is parsing the data that comes from
> the USB CAN adapter. One datum is used as an index to access the dev->nets[]
> array. This patch adds the missing bounds checking.
> 
> Cc: Matthias Fuchs <matthias.fuchs@esd.eu>
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> Maximilian, I've added a more detailed patch description and the error message
> printing. What do you think.
> 
> Marc
> 
>  drivers/net/can/usb/esd_usb2.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
> index 6aa7b32..ac6177d 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -412,10 +412,20 @@ static void esd_usb2_read_bulk_callback(struct urb *urb)
>  
>  		switch (msg->msg.hdr.cmd) {
>  		case CMD_CAN_RX:
> +			if (msg->msg.rx.net >= dev->net_count) {
> +				dev_err(dev->udev->dev.parent, "format error\n");
> +				break;
> +			}
> +
>  			esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
>  			break;
>  
>  		case CMD_CAN_TX:
> +			if (msg->msg.txdone.net >= dev->net_count) {
> +				dev_err(dev->udev->dev.parent, "format error\n");
> +				break;
> +			}
> +
>  			esd_usb2_tx_done_msg(dev->nets[msg->msg.txdone.net],
>  					     msg);
>  			break;
> 

