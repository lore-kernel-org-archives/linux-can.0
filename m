From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v5 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Fri, 31 Oct 2014 11:57:20 +0100
Message-ID: <54536B10.4000201@denx.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-3-git-send-email-sbabic@denx.de> <545154BE.8000603@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46480 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757338AbaJaK50 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Oct 2014 06:57:26 -0400
In-Reply-To: <545154BE.8000603@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

On 29/10/2014 21:57, Oliver Hartkopp wrote:

> This ccflags stuff already has been remove - so it needs a tiny rebase
> here.
> Sorry.

Dropped in next version, thanks !

> 
>> diff --git a/drivers/net/can/spi/spi_can.c
>> b/drivers/net/can/spi/spi_can.c
>> new file mode 100644
>> index 0000000..087e6b7
>> --- /dev/null
>> +++ b/drivers/net/can/spi/spi_can.c
> 
> 
>> +struct msg_cfg_get_data {
>> +    u8    channel;
>> +    u8    tseg1_min;
>> +    u8    tseg1_max;
>> +    u8    tseg2_min;
>> +    u8    tseg2_max;
>> +    u8    sjw_max;
>> +    u32    brp_min;
>> +    u32    brp_max;
>> +    u32    brp_inc;
>> +    u8    ctrlmode;
> 
> u32 ?

Yes, I will set it back to u32.

> 
> What is this ioctl() intended for?
> 
> Can this be handled by the standard Linux configuration interface for
> hardware timestamping?

Yes - I remove this ioctl.

> 
> 
> Finally I would like to ask you about IFF_ECHO support (again).
> I know that you had some concerns about the SPI performance when putting
> the sent CAN frame into the SPI receive path.

Maybe because I have in mind my use case, and due also to the low SPI
frequency allowed by the microcontroller (up to 6 Mhz), adding echo
frames will strongly reduce the throughput. Anyway, I agree that a more
powerful microcontroller could raise the frequency and reduce the gap.

> 
> But I would at least suggest to make the SPI message interface capable
> to support IFF_ECHO on the slave CPU. E.g. by sending some index (!=0)
> from an echo skb store to/from the slave to detect originated frames in
> the receive path.
> 
> The SPI slave should announce if it supports IFF_ECHO. And some 8 bit
> value which goes down to the slave and is received together with a CAN
> frame would help to detect local frames.
> 
> Probably we can also use the high nibble from the dlc for that.

I agree on that. Maybe in the high nibble we can use three bits to have
up to 7 echoed messages. The index will be sent by the master, and the
slave will answer sending back the index in the encoded dlc, with data
length = 0. This is enough to understand if it is a local or remote
frame. If we agree, I'll update the documentation.

Nevertheless I am asking if this can be implemented in a follow up
patch, when a real use case arises. It is not a big change, but I will
not get the firmware for the microcontroller supporting this and I
cannot test this functionality.

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
