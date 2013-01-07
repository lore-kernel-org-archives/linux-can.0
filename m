From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: max is back
Date: Mon, 07 Jan 2013 20:23:44 +0100
Message-ID: <50EB20C0.4000201@hartkopp.net>
References: <1356821415.6901.159.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:59743 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab3AGTXq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jan 2013 14:23:46 -0500
In-Reply-To: <1356821415.6901.159.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org

Hi Max,

some answers for the points i probably can answer ... :-)

On 29.12.2012 23:50, Max S. wrote:

> 2) send byte order indicator and host frame format to each can
> interface.


Good idea.

> 
> char data[10];
> uint16_t ekey = 0xbeef;
> int len = sprintf(data,"%c%c""%c%c%c%c\n",
> 	((uint8_t *)&ekey)[0],((uint8_t *)&ekey)[1],
> 	(char)sizeof(struct can_frame),
> 	(char)((size_t)(&((struct can_frame *)0)->can_id)),
> 	(char)((size_t)(&((struct can_frame *)0)->can_dlc)),
> 	(char)((size_t)(&((struct can_frame *)0)->data))
> );
> 
> libusb_control_transfer( .... data, ... );
> 
> 3) send baudrate/mode/other settings to each interface.


dito

> 3) prepare/submit some usb requests
> 
> libusb_fill_bulk_transfer(transfer_object,
> 	usb_device, endpoint,
> 	(unsigned char *)&frame, sizeof(struct can_frame), transfer_callback,
> NULL, 1000 );
> 
> 
> 4) callbacks are really clean and look something like this:
> 
> void transfer_callback(struct libusb_transfer *transfer){
> 	struct can_frame *frame = (struct can_frame *)transfer->buffer;
> 	switch(transfer->status){
> 		case LIBUSB_TRANSFER_COMPLETED:;
> 			//pass frame to can system
> 			break;
> 		//handle errors
> 	}
> 	libusb_submit_transfer(transfer);
> }
> 
> I remember in an earlier discussion with Marc and Oliver describing this
> method. Is this what you had in mind?


Don't know.

> 
> I can signal bus errors by creating genuine struct can_frame errors this
> way as well. How would I signal buffer overrun on the device?


See CAN_ERR_CRTL and CAN_ERR_CRTL_RX_OVERFLOW in include/linux/can/error.h

> 
> Regarding setting the baudrate. How is this normally done? direct access
> to the TQs, propseg, phas1/2 seg, etc?


See:
http://lxr.linux.no/#linux+v3.7.1/Documentation/networking/can.txt#L766

You can specify a EITHER a bitrate OR the propseg1/2 stuff.

When using the bitrate the internal bitrate calculation is used to determine
propseg1/2 and friends. Otherwise the propseg1/2 stuff can be set manually.

To calculate the bitrate the struct can_bittiming_const is needed.

http://lxr.linux.no/#linux+v3.7.1/drivers/net/can/usb/ems_usb.c#L891

Each CAN driver / CAN controller has usually it's own function to put the
bittiming into the controllers registers, e.g.:

http://lxr.linux.no/#linux+v3.7.1/drivers/net/can/usb/ems_usb.c#L926

and

http://lxr.linux.no/#linux+v3.7.1/drivers/net/can/sja1000/sja1000.c#L209

> 
> Now I have some questions regarding sending messages. actually I'd just
> like more help understanding this:
> 
>>> To provide a state-of-the-art echo functionality the sk pointer
> (skb->sk) is
>>> sent along with the CAN frame. This allows to skb_free() the original
> tx skb
>>> and create a new one at rx time with the correct sk pointer, when the
> frame is
>>> echoed after successful transmission. As we are endian safe the sk
> pointer can
>>> be taken from the USB URB as-is. (For security reasons we should
> probably not
>>> take the pointer directly but double check with stored echo-skbs)
> 
> You are saying that the host sends an extra identifier with the can
> frame to be sent, and that the firmware sends the entire frame with this
> identifier back to indicate completion?


Yes.

> so I need some message header?


You need to put the CAN frame into the URB in some way anyway.
Is there any problem to add this additional unique identifier along with the
CAN frame?

E.g. a zero identifier in the rx-path could indicate a 'freshly received' CAN
frame, which was not sent by the local host.

> 
> How is time-stamping done with socket-can? struct can_frame (at least on
> my system) has no 'time_stamp' member.


The struct can_frame contains the CAN frame - oh, surprise! :-))

The timestamp is part ot the socket buffer (struct skbuff) where the CAN frame
is embedded inside the Linux kernel.

The timestamp can be retrieved by standard socket operations:

E.g. as cmsg element within a recvmsg() syscall
https://gitorious.org/linux-can/can-utils/blobs/master/candump.c#line605

or with an ioctl() after read()/recv()
https://gitorious.org/linux-can/can-utils/blobs/master/isotpdump.c#line198

Regards,
Oliver

