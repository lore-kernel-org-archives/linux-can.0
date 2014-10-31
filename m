From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Fri, 31 Oct 2014 19:23:48 +0100
Message-ID: <5453D3B4.2090107@hartkopp.net>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-3-git-send-email-sbabic@denx.de> <545154BE.8000603@hartkopp.net> <54536B10.4000201@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34018 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaJaSX4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Oct 2014 14:23:56 -0400
In-Reply-To: <54536B10.4000201@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 31.10.2014 11:57, Stefano Babic wrote:

>>> diff --git a/drivers/net/can/spi/spi_can.c
>>> b/drivers/net/can/spi/spi_can.c
>>> new file mode 100644
>>> index 0000000..087e6b7
>>> --- /dev/null
>>> +++ b/drivers/net/can/spi/spi_can.c
>>
>>
>>> +struct msg_cfg_get_data {
>>> +    u8    channel;
>>> +    u8    tseg1_min;
>>> +    u8    tseg1_max;
>>> +    u8    tseg2_min;
>>> +    u8    tseg2_max;
>>> +    u8    sjw_max;
>>> +    u32    brp_min;
>>> +    u32    brp_max;
>>> +    u32    brp_inc;
>>> +    u8    ctrlmode;
>>
>> u32 ?
>
> Yes, I will set it back to u32.

Please add an additional

u8 capability;

or something like this to get the possible IFF_ECHO support information.
When e.g. (capability & SPI_CAP_ECHO) is true at startup,
dev->flags |= IFF_ECHO can be set.


>>
>>
>> Finally I would like to ask you about IFF_ECHO support (again).
>> I know that you had some concerns about the SPI performance when putting
>> the sent CAN frame into the SPI receive path.
>
> Maybe because I have in mind my use case, and due also to the low SPI
> frequency allowed by the microcontroller (up to 6 Mhz), adding echo
> frames will strongly reduce the throughput. Anyway, I agree that a more
> powerful microcontroller could raise the frequency and reduce the gap.
>

Yep.

>>
>> But I would at least suggest to make the SPI message interface capable
>> to support IFF_ECHO on the slave CPU. E.g. by sending some index (!=0)
>> from an echo skb store to/from the slave to detect originated frames in
>> the receive path.
>>
>> The SPI slave should announce if it supports IFF_ECHO.

(already addressed above)

>> And some 8 bit
>> value which goes down to the slave and is received together with a CAN
>> frame would help to detect local frames.
>>
>> Probably we can also use the high nibble from the dlc for that.
>
> I agree on that. Maybe in the high nibble we can use three bits to have
> up to 7 echoed messages. The index will be sent by the master, and the
> slave will answer sending back the index in the encoded dlc, with data
> length = 0. This is enough to understand if it is a local or remote
> frame. If we agree, I'll update the documentation.

I would suggest to simply use the high nibble (as low nibble is always DLC - 
even in the CAN FD case).

When IFF_ECHO is supported a high nibble != 0 indicates the echo_skb index.

When you receive a frame and the high nibble is != 0 this was a locally sent 
frame.

>
> Nevertheless I am asking if this can be implemented in a follow up
> patch, when a real use case arises.

Yes. When the documentation for dlc-handling and capability is describing the 
entire communication protocol the missing IFF_ECHO support should be 
documented as TODO in the comments IMO.

> It is not a big change, but I will
> not get the firmware for the microcontroller supporting this and I
> cannot test this functionality.

Ok. Changing struct msg_cfg_get_data is probably enough work for them ;-)

Best regards,
Oliver

