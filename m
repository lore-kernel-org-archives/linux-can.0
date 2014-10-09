From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Thu, 09 Oct 2014 17:06:42 +0200
Message-ID: <5436A482.4040001@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.53]:35974 "HELO
	mx4.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752158AbaJIPGt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Oct 2014 11:06:49 -0400
In-Reply-To: <542BF687.1000800@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hey all,

I now checked everything with a mixed signal scope and
one thing came to my eye:

After loading the module, I get the error:
[   16.806860] sja1000_raspi sja1000_raspi.0: registering sja1000_raspi=
=20
device (reg_base=3D0xf2200000, irq=3D174)
[   16.836560] sja1000_raspi sja1000_raspi.0 (unregistered net_device):=
=20
setting SJA1000 into reset mode failed!
[   16.871684] sja1000_raspi sja1000_raspi.0: sja1000_raspi device=20
registered (reg_base=3D0xf2200000, irq=3D174)

Although I can see at the scope, that reading register 0 of the SJA1000=
=20
returns the value 1 as it should be.
Also, it seems that there is some kind of endless loop reading this=20
register.

Now, what I don't understand at all:
Removing the module and loading it again works.
I don't get the error that setting the SJA1000 into reset mode failed,
the register is only read once after loading the module,
and sending/reading CAN frames from the bus after setting a proper=20
bitrate works too....

Any Ideas why the first initialization of the kernel module doesn't wor=
k?
When is the probe function of the module actually called?

A completely other question: I wanted to use libsocketcan to check the=20
state of the interface,
bringing it up in case it's down, within my C/C++ Program.
Is there a way to use this lib as a normal user? Maybe some group the=20
user has to be in?

Regards,
=46lorian

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
>
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

