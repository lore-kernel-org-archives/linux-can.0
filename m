From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Tue, 12 Aug 2014 10:57:23 +0200
Message-ID: <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.kph.uni-mainz.de ([134.93.132.3]:39812 "EHLO
	mail.kph.uni-mainz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbaHLJKl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 05:10:41 -0400
In-Reply-To: <53E9CF27.90400@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hey,

Thanks for the quick answer.

On 08/12/2014 10:24 AM, Marc Kleine-Budde wrote:
> On 08/12/2014 09:51 AM, Florian Feldbauer wrote:
>> I have developed a CAN interface for the Raspberry Pi computer using=
 the
>> SJA1000 directly connected to the GPIOs of the CPU.
> This sounds very slow :)
Actually no. At least with the chardev driver it was faster than the=20
PEAK USB-CAN-PRO
connected to my laptop.
But I'm using direct memory manipulation to set/clear the GPIOs.
This is much faster than using the designated GPIO functions from the=20
kernel...
>
>> So far this interface is used as chardev and works fine.
>> But I'm also developing a user-space program using this CAN interfac=
e.
>> This program should also be compatible with other CAN interfaces lik=
e
>> the ones from PEAK or Kvazer. So I thought using socketCAN would be =
a
>> good idea.
> Yes.
>
>> Is there any documentation on how to write a socketCAN compatible ke=
rnel
>> module for my own hardware?
>> I tried writing something similar to the sja1000_isa driver...
> IMHO sja1000_platform.c is a better blueprint, as it uses the device
> tree to describe the hardware and does not rely on module parameters.
Ok. I will have a look at it.
>
>> So far my modified kernel compiles and I can change bitrate and brin=
g
>> the interface up.
>> But as soon as I try to send a CAN frame I get the error:
>> Error 105: No buffer space available
> You are sending CAN frames faster than the driver is able to send the=
m,
> you have to wait a bit, before sending new CAN frames.
I'm using
   int nbytes =3D write( fd, pframe, sizeof(can_frame_t) );
to send a message. I thought this function blocks until the write is=20
finished?

My old chardev module was based on the kernel module from PEAK systems =
and
thus had a FIFO buffer for sending and receiving messages.
 From the above error, I assume, socketCAN has no internal buffer?
What happens if there are many messages received on a small timescale?

   Florian
>
> Marc
>


--=20
----------------------------------------
| Dr. Florian Feldbauer                |
|                                      |
| Helmholtz-Institut Mainz /           |
| Johannes Gutenberg-Universit=C3=A4t Mainz |
| Johann-Joachim-Becher-Weg 36         |
| D-55128 Mainz                        |
|                                      |
| Office: SB1 / 00-213                 |
| Phone:  (+49)6131 / 39-29605         |
----------------------------------------

