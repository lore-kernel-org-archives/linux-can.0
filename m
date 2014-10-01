From: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Wed, 01 Oct 2014 09:26:56 +0200
Message-ID: <542BACC0.4050707@ep1.ruhr-uni-bochum.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mi.ruhr-uni-bochum.de ([134.147.64.33]:39247 "HELO
	mx5.rz.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750850AbaJAHdj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 03:33:39 -0400
In-Reply-To: <53E9E614.7060303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hey all,

I still have some problems with the socket CAN driver for
my Raspberry Pi CAN interface.
I added a printk statement in the read/write register functions to
see what happens.

Looking into the output of `dmesg` after loading the kernel module
I see in an endless loop appearing the lines

[  129.210361] sja1000_raspi: Read register 0: 0x21
[  129.210394] sja1000_raspi: Write register 4: 0x00
[  129.210423] sja1000_raspi sja1000_raspi.0 can0: bit-timing not yet=20
defined

Is this an expected behavior?

After setting the bitrate using
$> ip link set can0 type can bitrate 250000
The above messages stop.

dmesg output at this point:
[  172.870195] sja1000_raspi: Read register 15: 0xff
[  172.870231] sja1000_raspi: Read register 14: 0xff
[  172.872933] sja1000_raspi sja1000_raspi.0 can0: setting BTR0=3D0x01=20
BTR1=3D0x1c
[  172.872971] sja1000_raspi: Write register 6: 0x01
[  172.872987] sja1000_raspi: Write register 7: 0x1c
[  173.269190] sja1000_raspi: Read register 0: 0x21
[  173.269221] sja1000_raspi: Write register 4: 0x00
[  173.269287] sja1000_raspi: Write register 15: 0x00
[  173.269303] sja1000_raspi: Write register 14: 0x00
[  173.269319] sja1000_raspi: Read register 12: 0xff
[  173.269336] sja1000_raspi: Read register 0: 0x21
[  173.269348] sja1000_raspi: Write register 0: 0x00
[  173.269369] sja1000_raspi: Read register 0: 0x20
[  173.269381] sja1000_raspi: Write register 4: 0x7f
[  173.269446] sja1000_raspi: Read register 15: 0x0c
[  173.269462] sja1000_raspi: Read register 14: 0x03

The main problem is: If I now try to change the bitrate again
I get a "Device or resource busy" error.
demsg shows in this case simply these to lines:
[  445.848207] sja1000_raspi: Read register 15: 0x0c
[  445.848241] sja1000_raspi: Read register 14: 0x03

After bringing the interface up and trying to listen on the CANbus
using candump from the can-utils I get nothing, although a second
node is sending frames and bitrate settings are correct.

I'm working with the raspberry pi kernel=20
(https://github.com/raspberrypi/linux)
version 3.12.y commit c256eb9968c8997dce47350d2075e42f1b3991d3

Source of my own kernel module is also on github
https://github.com/ffeldbauer/epics_RPi_can/blob/ver3.0.0/CAN_interface=
/driver/sja1000_raspi.c

As written before, I could not find a documentation of socketCAN and=20
simply tried
to "copy" the sja1000_isa.c driver...naybe I did something completely=20
wrong or missed
something?

Any help is very much appreciated!

Best regards,
=46lorian

On 08/12/2014 12:01 PM, Marc Kleine-Budde wrote:
> On 08/12/2014 10:57 AM, Florian Feldbauer wrote:
>> On 08/12/2014 10:24 AM, Marc Kleine-Budde wrote:
>>> On 08/12/2014 09:51 AM, Florian Feldbauer wrote:
>>>> I have developed a CAN interface for the Raspberry Pi computer usi=
ng the
>>>> SJA1000 directly connected to the GPIOs of the CPU.
>>> This sounds very slow :)
>> Actually no. At least with the chardev driver it was faster than the
>> PEAK USB-CAN-PRO
>> connected to my laptop.
>> But I'm using direct memory manipulation to set/clear the GPIOs.
>> This is much faster than using the designated GPIO functions from th=
e
>> kernel...
> Portability comes with a price.
>
>>>> So far this interface is used as chardev and works fine.
>>>> But I'm also developing a user-space program using this CAN interf=
ace.
>>>> This program should also be compatible with other CAN interfaces l=
ike
>>>> the ones from PEAK or Kvazer. So I thought using socketCAN would b=
e a
>>>> good idea.
>>> Yes.
>>>
>>>> Is there any documentation on how to write a socketCAN compatible =
kernel
>>>> module for my own hardware?
>>>> I tried writing something similar to the sja1000_isa driver...
>>> IMHO sja1000_platform.c is a better blueprint, as it uses the devic=
e
>>> tree to describe the hardware and does not rely on module parameter=
s.
>> Ok. I will have a look at it.
>>>> So far my modified kernel compiles and I can change bitrate and br=
ing
>>>> the interface up.
>>>> But as soon as I try to send a CAN frame I get the error:
>>>> Error 105: No buffer space available
>>> You are sending CAN frames faster than the driver is able to send t=
hem,
>>> you have to wait a bit, before sending new CAN frames.
>> I'm using
>>    int nbytes =3D write( fd, pframe, sizeof(can_frame_t) );
>> to send a message. I thought this function blocks until the write is
>> finished?
> No. It will return with a errno if the message cannot be queued.
>
>> My old chardev module was based on the kernel module from PEAK syste=
ms and
>> thus had a FIFO buffer for sending and receiving messages.
>>  From the above error, I assume, socketCAN has no internal buffer?
> There are buffers for RX and TX.
>
>> What happens if there are many messages received on a small timescal=
e?
> If the system can handle the RX load all messages will be queued. The=
n
> there are per socket queues for your userspace applications. If a que=
ue
> if full, CAN frames will be dropped. You can get information about
> dropped CAN frames with the recvmsg() system call. See candump.c from
> the gitorious can-utils for an exmaple.
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

