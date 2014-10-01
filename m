From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 14:32:22 +0200
Message-ID: <542BF456.3030201@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.33]:57981 "HELO
	mx5.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751047AbaJAMc0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 08:32:26 -0400
In-Reply-To: <542BB21B.4030200@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 10/01/2014 09:49 AM, Marc Kleine-Budde wrote:
> On 10/01/2014 09:26 AM, Florian Feldbauer wrote:
>> I still have some problems with the socket CAN driver for
>> my Raspberry Pi CAN interface.
>> I added a printk statement in the read/write register functions to
>> see what happens.
>>
>> Looking into the output of `dmesg` after loading the kernel module
>> I see in an endless loop appearing the lines
>>
>> [  129.210361] sja1000_raspi: Read register 0: 0x21
>> [  129.210394] sja1000_raspi: Write register 4: 0x00
>> [  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not ye=
t
>> defined
>>
>> Is this an expected behavior?
> Do you have network manager or a similar program running that is tryi=
ng
> to handle the CAN interface?
network-manager is not installed and looking at the active services and=
=20
processes
I don't see anything which looks like a network manager...
>> After setting the bitrate using
>> $> ip link set can0 type can bitrate 250000
>> The above messages stop.
>>
>> dmesg output at this point:
>> [  172.870195] sja1000_raspi: Read register 15: 0xff
>> [  172.870231] sja1000_raspi: Read register 14: 0xff
>> [  172.872933] sja1000_raspi sja1000_raspi.0 can0: setting BTR0=3D0x=
01
>> BTR1=3D0x1c
>> [  172.872971] sja1000_raspi: Write register 6: 0x01
>> [  172.872987] sja1000_raspi: Write register 7: 0x1c
>> [  173.269190] sja1000_raspi: Read register 0: 0x21
>> [  173.269221] sja1000_raspi: Write register 4: 0x00
>> [  173.269287] sja1000_raspi: Write register 15: 0x00
>> [  173.269303] sja1000_raspi: Write register 14: 0x00
>> [  173.269319] sja1000_raspi: Read register 12: 0xff
>> [  173.269336] sja1000_raspi: Read register 0: 0x21
>> [  173.269348] sja1000_raspi: Write register 0: 0x00
>> [  173.269369] sja1000_raspi: Read register 0: 0x20
>> [  173.269381] sja1000_raspi: Write register 4: 0x7f
>> [  173.269446] sja1000_raspi: Read register 15: 0x0c
>> [  173.269462] sja1000_raspi: Read register 14: 0x03
>>
>> The main problem is: If I now try to change the bitrate again
>> I get a "Device or resource busy" error.
> You'll get this busy error if the device is still "up", so there is
> someone who automatically does something similar to "ifconfig can0 up=
".
hmm....I just noticed that, the interface is always brought up=20
automatically.
Even if I run `if config can0 down` the interface is brought up again..=
=2E.


>> demsg shows in this case simply these to lines:
>> [  445.848207] sja1000_raspi: Read register 15: 0x0c
>> [  445.848241] sja1000_raspi: Read register 14: 0x03
>>
>> After bringing the interface up and trying to listen on the CANbus
>> using candump from the can-utils I get nothing, although a second
>> node is sending frames and bitrate settings are correct.
> Do you get any interrupts?
Seems not the case
Sending doesn't work either...
 From a very quick look, it seems the GPIOs are not set...But to be sur=
e
I have to build a small adapter in order to properly connect our digita=
l=20
scope to it...
>> I'm working with the raspberry pi kernel
>> (https://github.com/raspberrypi/linux)
>> version 3.12.y commit c256eb9968c8997dce47350d2075e42f1b3991d3
>>
>> Source of my own kernel module is also on github
>> https://github.com/ffeldbauer/epics_RPi_can/blob/ver3.0.0/CAN_interf=
ace/driver/sja1000_raspi.c
>>
>>
>> As written before, I could not find a documentation of socketCAN and
>> simply tried
>> to "copy" the sja1000_isa.c driver...naybe I did something completel=
y
>> wrong or missed
>> something?
> Yes, making a copy of the driver is probably not the right thing....
> BTW: where's are the original copyright notes?
"Copy" in this case means: I looked into=20
sja1000_isa.c/sja1000_platform.c to see what function have
to be implemented and what parameters do they use.
I copied the corresponding functions from my chardev driver and modifie=
d=20
them
accordingly....

>> Any help is very much appreciated!
> regards,
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

