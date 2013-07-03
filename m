From: "Max S." <max@schneidersoft.net>
Subject: Re: [PATCH] net: can: esd_usb2: check index of array before
 accessing
Date: Wed, 03 Jul 2013 11:51:39 +0000
Message-ID: <1372852299.15632.13.camel@blackbox>
References: <1372840409-13481-1-git-send-email-mkl@pengutronix.de>
	 <51D3F638.3080207@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:40232 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967Ab3GCLoL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Jul 2013 07:44:11 -0400
In-Reply-To: <51D3F638.3080207@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Wed, 2013-07-03 at 12:00 +0200, Matthias Fuchs wrote:
> Hi,
> 
> did anybody encounter an issue with invalid net codes comming from the
> device?
Technically one could write a usb device that sends a bad
netcode/crafted message.

through 
esd_usb2_read_bulk_callback()
	esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
	...
	esd_usb2_rx_event()
		...
		u8 state = msg->msg.rx.data[0];
		...
		priv->old_state = state;

one could write any u8 memory value to <255 past dev->nets.

... I think.

> 
> Well, you may add my
> 
> Acked-by: Matthias Fuchs <matthias.fuchs@esd.eu>
> 
> Matthias
> 
> On 03.07.2013 10:33, Marc Kleine-Budde wrote:
> > From: Maximilian Schneider <max@schneidersoft.net>
> > 
> > The esd_usb2_read_bulk_callback() function is parsing the data that comes from
> > the USB CAN adapter. One datum is used as an index to access the dev->nets[]
> > array. This patch adds the missing bounds checking.
> > 
> > Cc: Matthias Fuchs <matthias.fuchs@esd.eu>
> > Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
:D
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hello,
> > 
> > Maximilian, I've added a more detailed patch description and the error message
> > printing. What do you think. 
Looks good.

regards,
Max Schneider


