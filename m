From: "Max S." <max@schneidersoft.net>
Subject: Re: Usb to can driver
Date: Wed, 26 Jun 2013 18:55:12 +0000
Message-ID: <1372272912.3805.27.camel@blackbox>
References: <1372204758.9593.13.camel@blackbox>
	 <a32451031b577e68f4c79750800c5d71@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:58873 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3FZSro (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2013 14:47:44 -0400
In-Reply-To: <a32451031b577e68f4c79750800c5d71@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On Wed, 2013-06-26 at 09:10 +0200, wg wrote:
> Hi Max,
...
> > My firmware implements LOOPBACK by default. That is all frames sent by
> > the can hardware are also returned over usb. I use this effect to call
> > can_get_echo_skb() during bulk in. To support LOOPBACK mode as per
> > socketcan; should i also call netif_rx() durring bulk in if
> > CAN_CTRLMODE_LOOPBACK is
> > set?
> 
> Message echo (normally via echo_skbs) and loopback (via
> CAN_CTRLMODE_LOOPBACK)
> are somehow different things. The first is a local loopback of sent
> frames,
> which is described here:
> 
>   http://lxr.linux.no/#linux+v3.9.7/Documentation/networking/can.txt#L178

I was confused because i was not sure if 'sent frame' meant either a)
'frame that has left Linux', or b) 'frame that actually made it onto the
CAN bus'. Appears I can choose either :P

For usb_8dev and ems_usb, echo via put_echo_skb happens in the USB write
callback. (a)

For esd_usb2 a frame is only recognized as sent when the device reports
it as sent. (b)

I also noticed esd_usb2 does: dev->nets[msg->msg.txdone.net]
Is that safe? msg->msg.txdone.net is never check if its in range...

> Does the hardware communicate a TX done event as well?
Yes, The controller produces a TX event which happens after successful
frame transmission. I place successfully TXed frames in the USB IN fifo
with their corresponding echo_ids.

> CAN_CTRLMODE_LOOPBACK is a real hardware loopback. Normally the message
> does not even go out to the bus mainly useful for testing. For the software the
> loopback message should be handled like any other incoming message.

Ah. so CAN_CTRLMODE_LOOPBACK could be used to test data path from
application->Linux->driver->can_hardware and back. without the need of
an actual physical CAN bus.

Thanks Wolfgang,
Max Schneider.


