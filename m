From: "Max S." <max@schneidersoft.net>
Subject: max is back
Date: Sat, 29 Dec 2012 22:50:15 +0000
Message-ID: <1356821415.6901.159.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:51518 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2L2Xye (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 29 Dec 2012 18:54:34 -0500
Received: from [192.168.1.54] (unknown [177.118.231.210])
	(Authenticated sender: max@schneidersoft.net)
	by mail.schneidersoft.net (Postfix) with ESMTPSA id 546CF1A12B
	for <linux-can@vger.kernel.org>; Sat, 29 Dec 2012 17:50:24 -0600 (CST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all,

If anyone remembers I was working on a usb to can adapter. The Dev-kit I
was using was defective and put the project on hiatus. I've got a fresh
kit now and the first working firmware version.

I'm using a user-space driver for now, and have the basic workings
hashed out as follows. (for reception)

1) open the usb device.
2) send byte order indicator and host frame format to each can
interface.

char data[10];
uint16_t ekey = 0xbeef;
int len = sprintf(data,"%c%c""%c%c%c%c\n",
	((uint8_t *)&ekey)[0],((uint8_t *)&ekey)[1],
	(char)sizeof(struct can_frame),
	(char)((size_t)(&((struct can_frame *)0)->can_id)),
	(char)((size_t)(&((struct can_frame *)0)->can_dlc)),
	(char)((size_t)(&((struct can_frame *)0)->data))
);

libusb_control_transfer( .... data, ... );

3) send baudrate/mode/other settings to each interface.
3) prepare/submit some usb requests

libusb_fill_bulk_transfer(transfer_object,
	usb_device, endpoint,
	(unsigned char *)&frame, sizeof(struct can_frame), transfer_callback,
NULL, 1000 );


4) callbacks are really clean and look something like this:

void transfer_callback(struct libusb_transfer *transfer){
	struct can_frame *frame = (struct can_frame *)transfer->buffer;
	switch(transfer->status){
		case LIBUSB_TRANSFER_COMPLETED:;
			//pass frame to can system
			break;
		//handle errors
	}
	libusb_submit_transfer(transfer);
}

I remember in an earlier discussion with Marc and Oliver describing this
method. Is this what you had in mind?

I can signal bus errors by creating genuine struct can_frame errors this
way as well. How would I signal buffer overrun on the device?

Regarding setting the baudrate. How is this normally done? direct access
to the TQs, propseg, phas1/2 seg, etc?

Now I have some questions regarding sending messages. actually I'd just
like more help understanding this:

>> To provide a state-of-the-art echo functionality the sk pointer
(skb->sk) is
>> sent along with the CAN frame. This allows to skb_free() the original
tx skb
>> and create a new one at rx time with the correct sk pointer, when the
frame is
>> echoed after successful transmission. As we are endian safe the sk
pointer can
>> be taken from the USB URB as-is. (For security reasons we should
probably not
>> take the pointer directly but double check with stored echo-skbs)

You are saying that the host sends an extra identifier with the can
frame to be sent, and that the firmware sends the entire frame with this
identifier back to indicate completion? so I need some message header?

How is time-stamping done with socket-can? struct can_frame (at least on
my system) has no 'time_stamp' member. How does an application using
socketcan benefit from time-stamping?

Best Regards,
Max S.

