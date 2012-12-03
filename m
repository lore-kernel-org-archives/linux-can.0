From: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Mon, 03 Dec 2012 21:42:07 +0100
Message-ID: <50BD0E9F.2060302@universalnet.at>
References: <50BBF73F.9080208@universalnet.at> <50BCB1E8.2070705@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:49431 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751383Ab2LCTmW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 3 Dec 2012 14:42:22 -0500
In-Reply-To: <50BCB1E8.2070705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi Marc!


>> +/* Send open command to device */
>> +static int usb_8dev_cmd_open(struct usb_8dev *dev)
>> +{
>> +    struct can_bittiming *bt = &dev->can.bittiming;
>> +    struct usb_8dev_cmd_msg outmsg;
>> +    struct usb_8dev_cmd_msg inmsg;
>> +    u32 flags = 0;
>> +    u32 beflags;
>> +    u16 bebrp;
>> +    u32 ctrlmode = dev->can.ctrlmode;
>> +
>> +    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
>> +        flags |= USB_8DEV_LOOPBACK;
>> +    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> +        flags |= USB_8DEV_SILENT;
>> +    if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>> +        flags |= USB_8DEV_DISABLE_AUTO_RESTRANS;
>> +
>> +    flags |= USB_8DEV_STATUS_FRAME;
>> +
>> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));
>> +    outmsg.command = USB_8DEV_OPEN;
>> +    outmsg.opt1 = USB_8DEV_BAUD_MANUAL;
>> +    outmsg.data[0] = (bt->prop_seg + bt->phase_seg1);
>> +    outmsg.data[1] = bt->phase_seg2;
>> +    outmsg.data[2] = bt->sjw;
>
> But you should not use usb_bulk_msg() to send data which is on the
> stack, please use you already allocated memory in priv or kmalloc
> something here.

The function usb_8dev_send_cmd copies the data to dev->cmd_msg_buffer (allocated with kzalloc, GFP_KERNEL).


>
>> +
>> +    /* BRP */
>> +    bebrp = cpu_to_be16((u16) bt->brp);
>> +    memcpy(&outmsg.data[3], &bebrp, sizeof(bebrp));
>
> Are you sure about the endianess? Some data types are BE some are LE?

Where is LE used?

>
>> +
>> +    /* flags */
>> +    beflags = cpu_to_be32(flags);
>> +    memcpy(&outmsg.data[5], &beflags, sizeof(beflags));
>> +
>> +    return usb_8dev_send_cmd(dev, &outmsg, &inmsg);
>> +}
>> +
>> +/* Send close command to device */
>> +static int usb_8dev_cmd_close(struct usb_8dev *dev)
>> +{
>> +    struct usb_8dev_cmd_msg    outmsg;
>> +    struct usb_8dev_cmd_msg    inmsg;
>> +
>> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));
>> +    outmsg.command = USB_8DEV_CLOSE;
>
> Same here, don't use stack allocated mem for usb_bulk_msg

All command functions use usb_8dev_send_cmd.

>
> Are you sure?....Do you really want to wake the queue?
>

No, I've removed.

>
> needed?
>

I don't know. -> removed.


Thanks for your comments.

best regards,
Bernd

