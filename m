From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v5 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Thu, 06 Nov 2014 17:13:01 +0100
Message-ID: <545B9E0D.5020907@denx.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-3-git-send-email-sbabic@denx.de> <545A230A.4020107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52030 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbaKFQNI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 11:13:08 -0500
In-Reply-To: <545A230A.4020107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

On 05/11/2014 14:15, Marc Kleine-Budde wrote:
> On 07/28/2014 06:38 PM, Stefano Babic wrote:
>> This driver implements a simple protocol
>> to transfer CAN messages to and from an external
>> microcontroller via SPI interface.
>> Multiple busses can be tranfered on the same SPI channel.
>>
>> It was tested on a i.MX35 connected to a Freescale's
>> HCS12 16-bit controller with 5 CAN busses.
>>
>> Signed-off-by: Stefano Babic <sbabic@denx.de>
> 
> No line by line review, but some fundamental comments and questions:
> 

Fine.

> Can you please use a consistent indention scheme for struct and enums, I
> favour a single space against aligning with tab, as it ony fits 95% of
> the time and breaks during upgrades.

ok - but let see if I well understood. I confess I align always with
tab, using the rule:

struct something {
<tab>.....<tab>/* comment if any */

Because this is largely rule in kernel. You mean:

struct something {
<spaces>....<spaces> /*comment if any */

but this is reported as warning by checkpatch as :
WARNING: please, no spaces at the start of a line

I see only (or mainly) <tab> for structs/enum in kernel. Can you better
explain what are you meaning ? Thanks !


> 
> Please only use u16, u32 and friends where the size of the register is
> important, use plain int, unsinged int otherwise.
> 

ok

> I'm not sure of fiddling with the GPIO which you requested as an
> interrupt is a good idea. This is probably not available on all platforms.

I see in this way: SPI is a master/slave protocol and there is no
standard way for the slave to send an event when it needs a transfer.
Not only, the microcontroller is very simple and what it can generally
do is to assert or to release a line - this can be done by all controllers.

The same way to operate is done by several touchscreen driver.
Communication runs on the SPI/I2C bus, a GPIO is used to generate an
interrupt. My driver makes exactly the same, no new invention.

> 
> Why do you have two functions calculating the checksum? Have you checked
> if the kernel offers you a library for this?

I have checked inside lib/, but I see only the functions for computing
the checksum on a UDP header. But it looks very strange for me to call
some ip_* function inside the driver code, because the drivers has
nothing to do with IP. Anyway these functions sum only all bytes
together - a very simple checksum.

> 
> Can you explain me the endianess, I don't get why you need
> format_frame_output() and format_frame_input() and while your structs
> that go over the wire have no specific endianess (i.e. no __be32 in the
> struct msg_*).

On the SPI bus, data are big endian. This is defined in the
documentation of the protocol.
All structs in the driver are defined without endianess and the messages
are converted before and after each transfer on the bus.

> 
> Have you thought about using threaded interrupts? Or even better make
> use of the asynchronous SPI framework?

Yes, I did, but I have to revert back.

The main issue is that I have to reduce the delay between the slave has
asserted the IRQ line and the SPI frame is put on the bus. In fact, the
slave controller has very limited way to store incoming CAN packets, and
if the Master does not react very soon, packets are lost.

I see that moving to the async framework, the delay before the frame was
put on the bus was not acceptable. The current design has given the best
results, with a kernel thread dealing the SPI transfer and a work queue
to process the received messages.

Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
