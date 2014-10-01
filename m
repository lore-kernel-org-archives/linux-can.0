From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 14:56:29 +0200
Message-ID: <542BF9FD.5060209@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.30]:36160 "HELO
	mx6.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750768AbaJAM4y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 08:56:54 -0400
In-Reply-To: <542BF687.1000800@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 10/01/2014 02:41 PM, Marc Kleine-Budde wrote:
> On 10/01/2014 02:32 PM, Florian Feldbauer wrote:
>>> Do you get any interrupts?
>> Seems not the case
>> Sending doesn't work either...
>>  From a very quick look, it seems the GPIOs are not set...But to be =
sure
>> I have to build a small adapter in order to properly connect our dig=
ital
>> scope to it...
> Let's see if there is actual output on the GPIO lines...
>
> BTW: what's the use-case of the rpi, better buy a beagle bone black.
> IIRC you need to attach the CAN phy, and you're ready to go. It comes
> with two internal CAN cores, the first one is quite easy to setup, th=
e
> second one uses the same pins as one the the I2C busses, which has to=
 be
> disabled then... And you can use a proper mainline kernel.
I'm working at the university for experimental hadron physik. And for
our experiment we need a low budget, high performance CANbus interface
running under Linux.
We came up with the idea of the Rpi, since it's small, it has ethernet,=
=20
and it is
cheap (~30 euro). And with the sja1000 connected to the GPIOs you can=20
achieve
the high data throughput (up to 6666 extended data frames with 8 byte=20
length @1Mbit/s)

Actually I don't know if any other embedded linux board like the beagle=
=20
bone
was considered...
>>>> I'm working with the raspberry pi kernel
>>>> (https://github.com/raspberrypi/linux)
>>>> version 3.12.y commit c256eb9968c8997dce47350d2075e42f1b3991d3
>>>>
>>>> Source of my own kernel module is also on github
>>>> https://github.com/ffeldbauer/epics_RPi_can/blob/ver3.0.0/CAN_inte=
rface/driver/sja1000_raspi.c
>>>>
>>>>
>>>>
>>>> As written before, I could not find a documentation of socketCAN a=
nd
>>>> simply tried
>>>> to "copy" the sja1000_isa.c driver...naybe I did something complet=
ely
>>>> wrong or missed
>>>> something?
>>> Yes, making a copy of the driver is probably not the right thing...=
=2E
>>> BTW: where's are the original copyright notes?
>> "Copy" in this case means: I looked into
>> sja1000_isa.c/sja1000_platform.c to see what function have
>> to be implemented and what parameters do they use.
>> I copied the corresponding functions from my chardev driver and modi=
fied
>> them
>> accordingly....
> IANAL, but it's best practice to state which parts of your driver is
> based on the work of others.
Yes, you're right! It will be added in the next commit...
(The current branch ver3.0.0 of my repo is currently still a developmen=
t=20
branch...)

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

