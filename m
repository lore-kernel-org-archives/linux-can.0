From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb-can device
Date: Tue, 28 Aug 2012 13:58:38 +0200
Message-ID: <503CB26E.7010106@hartkopp.net>
References: <1345996339.6610.10.camel@slaptop>  <503A4E9B.9060308@pengutronix.de> <503B1198.3010506@hartkopp.net> <1346071259.3928.33.camel@slaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:26318 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab2H1L6m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Aug 2012 07:58:42 -0400
In-Reply-To: <1346071259.3928.33.camel@slaptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 27.08.2012 14:40, Max S. wrote:

> On Mon, 2012-08-27 at 08:20 +0200, Oliver Hartkopp wrote:

>> The idea is to bring the USB CAN interface as near as possible to the
>> SocketCAN network interface:
> 
> Exactly. The device should know what a struct can_frame is. The device i
> have is more than powerful enough to do some extra converting, endian
> etc (its an atmel devboard).
> I have been reading the Peak CAN-USB driver source, they seem to do the
> conversion on the host with a simple
> #ifdef ENDIAN be or le ... 
> 
> compiling either the big endian or the little endian code.
> 
> but a single memcpy would be allot cleaner.


Yes. In general the content from the CAN registers needs to be copied into the
URB from the CAN USB CPU anyway. So the idea is to do it in host-byteorder.
This has a very small impact to the CAN CPU complexity and makes it really
easy on the host driver side.

>> - send struct can_frames
>> - receive struct can_frames (for instant CAN data forwarding)
>> - receive struct can_frames (for instant CAN error messages(!) forwarding)
>> - send an endian pattern inside the USB URB (*1)
>> - send skb->sk pointers along with CAN data (*2)
>> - define a simple interface for open/close/bitrate-setting
>>
>> *1:
>> The idea is to reduce the CAN network driver to make simple memcpy()
>> operations instead of do any bitshifting or endian conversions. For that
>> reason an endian pattern (e.g. 0xAA00AA00) is added to the USB URB at
>> send/configuration, so that the CAN USB adapter switches to the host endian
>> mode and replies with the same endian pattern before the CAN data.
>> This allows to simply memcpy() the received CAN frame into skb->data.
>>
>> *2:
>> To provide a state-of-the-art echo functionality the sk pointer (skb->sk) is
>> sent along with the CAN frame. This allows to skb_free() the original tx skb
>> and create a new one at rx time with the correct sk pointer, when the frame is
>> echoed after successful transmission. As we are endian safe the sk pointer can
>> be taken from the USB URB as-is. (For security reasons we should probably not
>> take the pointer directly but double check with stored echo-skbs)
> 
> hm. I also don't think it would be wise to accept a pointer from the
> outside in kernel space. maybe accept an index(that can be checked) into
> a pointer array?.. I don't know, I'm not at that point yet :P.
> 


I found a very interesting implementation in the Bosch M_CAN specification:

http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/m_can/m_can.asp

http://www.semiconductors.bosch.de/media/en/pdf/ipmodules_1/m_can/mcan_users_manual.pdf

Section 2.4.3 Tx Buffer Element (page 45)

---8<---

T1 Bits 31:24 MM[7:0]: Message Marker

Written by CPU during Tx Buffer configuration. Copied into Tx Event FIFO
element for identification of Tx message status.

---8<---

So you can see in the Tx event FIFO, which marked CAN frame has been sent.

This is probably enough to provide just a byte and to create an array of
skb pointers which is referenced by this Message Marker. Maybe 256 markers
are too much ... we could only use 8 markers IMO.

>>
>> So the general idea is not to design an USB CAN API and adapt this to the CAN
>> network interface driver - BUT to design an USB CAN API supporting the CAN
>> netdev driver concepts and native data structures directly. This would be
>> similar to the CDC Ethernet approach and could become a "standard USB-CAN
>> interface" - which was originally requested by Max.
> 
> I have started work on this, since the last email, although i am only at
> the very beginning of the task.
> 


No problem. Every journey begins with a first step. [Lao Tze]

Regards,
Oliver
