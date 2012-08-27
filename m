From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb-can device
Date: Mon, 27 Aug 2012 08:20:08 +0200
Message-ID: <503B1198.3010506@hartkopp.net>
References: <1345996339.6610.10.camel@slaptop> <503A4E9B.9060308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:26765 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab2H0GUL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Aug 2012 02:20:11 -0400
In-Reply-To: <503A4E9B.9060308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Max S." <max@schneidersoft.net>
Cc: linux-can@vger.kernel.org

Hello Marc,

On 26.08.2012 18:28, Marc Kleine-Budde wrote:

> Hello Max,
> 
> On 08/26/2012 05:52 PM, Max S. wrote:
>> I am developing a usb to can adapter.
>>
>> Does there exist a standard usb-can interface on the linux side? Or will
>> I have to create my own device driver?
> 
> There is no standard driver, however I was thinking last week that
> someone should write a CDC CAN driver. CDC Ethernet is a standard to
> send ethernet frames over USB.


Yes. I've been thinking about something similar for CAN USB recently too. See
below.

(..)

>> What are my options for getting a usb device, that exposes two can
>> nodes, supported under linux? I have complete access to the usb device,
>> so it would not be a problem for me to build a firmware that behaves a
>> certain standard way.
> 
> The kvaser driver basically just sends and receives binary messages.
> They have a common header (len+type of message+CAN interface) and the
> message itself. There are messages to send and receive a CAN frame,
> TX-complete, for error handling, and for configuration. If you want to
> make your device's firmware update able, implement dfu (device firmware
> update). Optional stuff is abort tx of CAN frames, timestamps for rx and tx.


Due to the lack of USB CAN Hardware, where i could implement my own firmware i
thought about using http://www.8devices.com/product/2/usb2can which is pretty
cheap and also provides schematics to be able to alter the firmware with it's
onboard JTAG interface (see schematic):

http://www.8devices.com/uploads/downloads/usb2can.pdf

The idea is to bring the USB CAN interface as near as possible to the
SocketCAN network interface:

- send struct can_frames
- receive struct can_frames (for instant CAN data forwarding)
- receive struct can_frames (for instant CAN error messages(!) forwarding)
- send an endian pattern inside the USB URB (*1)
- send skb->sk pointers along with CAN data (*2)
- define a simple interface for open/close/bitrate-setting

*1:
The idea is to reduce the CAN network driver to make simple memcpy()
operations instead of do any bitshifting or endian conversions. For that
reason an endian pattern (e.g. 0xAA00AA00) is added to the USB URB at
send/configuration, so that the CAN USB adapter switches to the host endian
mode and replies with the same endian pattern before the CAN data.
This allows to simply memcpy() the received CAN frame into skb->data.

*2:
To provide a state-of-the-art echo functionality the sk pointer (skb->sk) is
sent along with the CAN frame. This allows to skb_free() the original tx skb
and create a new one at rx time with the correct sk pointer, when the frame is
echoed after successful transmission. As we are endian safe the sk pointer can
be taken from the USB URB as-is. (For security reasons we should probably not
take the pointer directly but double check with stored echo-skbs)

So the general idea is not to design an USB CAN API and adapt this to the CAN
network interface driver - BUT to design an USB CAN API supporting the CAN
netdev driver concepts and native data structures directly. This would be
similar to the CDC Ethernet approach and could become a "standard USB-CAN
interface" - which was originally requested by Max.

Without any legal interference when using other vendors USB CAN API ;-)

@Max: If you thinking about adopting this idea it would be great to discuss
about the driver details here. If you are free in your current USB CAN API
right now, it's worth a try :-)

> Oliver, do you remember the talk about the CAN in FPGA we heart at the
> CAN CIA conference, do you have a link to the presentation. It was FPGA
> based, but all concept mentioned there also apply to USB based devices.


This was the Advanced CAN Controller from www.esd.eu :

http://www.can-cia.org/fileadmin/cia/files/icc/13/arlt.pdf

Regards,
Oliver
