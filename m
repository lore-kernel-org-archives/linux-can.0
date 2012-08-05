From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] Error handling when writing socketcan drivers
Date: Sun, 05 Aug 2012 16:28:13 +0200
Message-ID: <501E82FD.2060505@hartkopp.net>
References: <CABsbf=H3jFOOV0eGXNKLVybDauL_=i2C=Krxb7j9NYS=rqWZfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:16143 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab2HEO2K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Aug 2012 10:28:10 -0400
In-Reply-To: <CABsbf=H3jFOOV0eGXNKLVybDauL_=i2C=Krxb7j9NYS=rqWZfg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin.linux@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Austin,

first please move to the linux-can ML i put into CC for former discussions.

On 02.08.2012 20:00, Austin Schuh wrote:

> I have been working on writing a socketcan driver for a usb device that I'm
> making, and I'm having trouble understanding how transmission errors are
> communicated back to userspace code.


There are no transmission errors as you would like address here.
Generally CAN frames are sent correctly or they are not 'sent'.

When a CAN frame is transmitted to the wire, the CAN controller (not the
transceiver!) wait's for an ACK from a different CAN node on the bus.

If this ACK is not received (e.g. due to a missing receiving node or to a
wrong bitrate) the frame is not 'sent'.

When a CAN frame is sent correctly the CAN driver sends this CAN frame back
into the local system to allow other applications to get the correct CAN bus
content. See:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L175
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L580

> From what I can currently see from
> reading working kernel modules and the docs, there is no mechanism for
> information from the USB device that a particular packet failed to send to be
> correlated back with which packet was sent.  Am I missing something, or is
> this correct?  To me, that also means that CAN traffic can't be treated as
> reliable.  Is that true?  I guess I find this surprising since, for example,
> the transceiver reports back if the packet wasn't ACKed, and could report that
> back up the chain so that the user can know if their packet was received by
> somebody or not.  That isn't the same as the correct client receiving the
> packet and responding back, but is better than nothing.


You can filter e.g. with your CAN RAW socket to get the CAN frames back that
were sent from this particular socket. With this option you can double check
if your frame has been sent by the CAN controller and someone on the CAN bus
has ACK'ed the frame. See Chapter 4.1.4 and 4.1.5:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L459

When your CAN frame could not be sent the TX error counters will increase and
finally the CAN controller state will become error-passive and finally bus-off.

For these problems and the error counters the CAN error messages can be
enabled. See:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L225
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L433

So things go well until you get error messages from the CAN controller.

When there's a NO-ACK problem the CAN controller driver can create a CAN error
message with the CAN_ERR_ACK bit set.

http://lxr.free-electrons.com/source/include/linux/can/error.h#L23

You can display the error messages e.g. with candump:

candump -e any,0~0,#FFFFFFFF    (show only error frames but no(!) data frames)
candump -e any,0:0,#FFFFFFFF    (show error frames and also all data frames)

I hope that helped to get behind the ideas and concepts.

Regards,
Oliver

