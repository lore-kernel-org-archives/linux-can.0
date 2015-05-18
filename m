From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: Linux board with 10 CANs
Date: Mon, 18 May 2015 13:13:21 +0200
Message-ID: <5559C951.60705@orange.fr>
References: <5555A6A3.7090206@orange.fr> <55560FA4.4090300@optusnet.com.au>    <5559AFF6.3040509@orange.fr> <45240.212.149.48.43.1431942011.squirrel@webmail.rdts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:18470 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbbERLNZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 May 2015 07:13:25 -0400
In-Reply-To: <45240.212.149.48.43.1431942011.squirrel@webmail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

Le 18/05/2015 11:40, Gerhard Bertelsmann a =C3=A9crit :
> Hi Francois,
> Am Mo, 18.05.2015, 11:25, schrieb Fran=C3=A7ois Beaulier:
>> Hi Tom,
>>
>> Freescale MPC574X chips are MCUs, you can't run Linux on them.
>> Vybrid SOCs have 2 CANs max.
>> I know the MCP2515 may work in some situation but it depends on kern=
el
>> latency and that is very unpredictable.
>> What is helping in QSPI ? the main problem beeing latency between MC=
P
>> irq and effective SPI transfer ?
> Yes, latency is the main problem with the MCP2515 connected via SPI.
> But I have no doubt that it would be possible using a BeagleBone Blac=
k
> with it's two integrated PRUs (2x200 MHz MCUs). If you connect 4 MCP2=
515
> to each PRU they could be served even at 1MBit @ full speed. With
> the already 2 integrated CAN controller you can easily have 10 CANs.
>
> The only concern that I have is the latency/overhead of the SocketCAN
> API with 10 CANs at high packet rates on 1 GHz ARM ...
>
> Regards
>
> Gerd
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi Gerhard,

Yes i agree it should work with AM335x PRUs.
MCP2515 can easily be well managed with any MCU, whether it is a PRU or=
=20
a Cortex-M like those inside the Vybrid or the iMX6 soloX.
The problem is the associated socketcan Linux driver.
It is probably simpler to write the driver when the MCU is inside the=20
SOC than it is when the MCU is connected with SPI because we can=20
directly read / write values through shared memory (+ use of semaphores=
).
But still, there is a new driver to write !

Regards,

=46rancois
