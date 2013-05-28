From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: problem to using CAN on beaglebone black A5A
Date: Tue, 28 May 2013 19:02:06 +0200
Message-ID: <51A4E30E.1080504@hartkopp.net>
References: <CABMxt4idBKa8tH4b4T4Z5AQir3UOOjvR1ocTv3OAN6Aqqtccpw@mail.gmail.com> <51A0A264.9060505@hartkopp.net> <CABMxt4hj-tqRD_aDk6QNMNyNiAjt9vNzb=4ziTpB28ZYAgH08A@mail.gmail.com> <51A1E56B.4010604@hartkopp.net> <CABMxt4h-0zYYBvjUqBdf=eChKXxJv77OPhQmh_y7rkwj18mdcQ@mail.gmail.com> <CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:20008 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934805Ab3E1RCJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 May 2013 13:02:09 -0400
In-Reply-To: <CABMxt4jMmBeMqFeyRMQ=5PtQtt6SHDGNGXUGm-WzPsW6Er9+SQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 28.05.2013 01:04, Mohamed HAMZAOUI wrote:
> I created a simple card with two CAN transeiver and connected to bbb =
card
> in accordance with bbb datasheet.
>=20

I'm not really familiar with the BBB, but i heard something about an EE=
PROM
which is part of the "Standard BBB capes", which contains the hardware
description and pin assignment of the capes, see:

http://circuitco.com/support/index.php?title=3DBeagleBone_Capes

e.g. http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape

http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape#EEPROM

AFAIK the EEPROM is read by the kernel and the devices and the pin assi=
gnments
are configured according to the EEPROM data ...

But i'm not really sure about all this.

A Problem of this board

http://circuitco.com/support/index.php?title=3DTT3201_CAN_Cape#EEPROM

is, that the pins for the second D_CAN are assigned to the I2C to read =
the
EEPROM. I have no idea how to solve this right now.

Regards,
Oliver



> Regards,
> Mohamed
>=20
> Le 26 mai 2013 12:35, "Oliver Hartkopp" <socketcan@hartkopp.net
> <mailto:socketcan@hartkopp.net>> a =E9crit :
>>
>> Hi Mohamed,
>>
>> obviously your kernel does not detect the hardware.
>>
>> AFAIK the beaglebone black has two D_CAN controllers onboard.
>>
>> So the c_can driver (which supports the d_can hardware too) should w=
ork.
>> But i don't know how the platform data has to be configured to make =
your
>> kernel detect the CAN controllers and attach them to the correct pin=
s.
>>
>> What kind of CAN hardware (add-on board) do you use with your beagle=
bone black?
>>
>> Regards,
>> Oliver
>>
>> On 25.05.2013 13:55, Mohamed HAMZAOUI wrote:
>> > I run this command because i can't found any can device :
>> > root@beaglebone:~# cat /proc/net/dev
>> > Inter-|   Receive                                                |=
  Transmit
>> >  face |bytes    packets errs drop fifo frame compressed
>> > multicast|bytes    packets errs drop fifo colls carrier compressed
>> >     lo:     280       4    0    0    0     0          0         0
>> > 280       4    0    0    0     0       0          0
>> >   eth0:       0       0    0    0    0     0          0         0
>> >   0       0    0    0    0     0       0          0
>> >   usb0:   11042      79    0    0    0     0          0         0
>> > 13479      59    0    0    0     0       0          0
>> >
>> > Any Idea ?
>> >
>> > Regards,
>> > Mohamed
>> >
>> > On Sat, May 25, 2013 at 1:37 PM, Oliver Hartkopp <socketcan@hartko=
pp.net
> <mailto:socketcan@hartkopp.net>> wrote:
>> >> On 25.05.2013 00:56, Mohamed HAMZAOUI wrote:
>> >>
>> >>> I started with beaglebone black A5A, i installed on it the lates=
t
>> >>> Angstrom image with : Linux beaglebone 3.8.13 #1 SMP Mon May 20
>> >>> 17:07:58 CEST 2013 armv7l GNU/Linux
>> >>>
>> >>> I have a problem when I try to add a can device, i load with mod=
probe
>> >>> all necessary kernel module (can, ti_hecc, c_can, c_can_platform=
,
>> >>> can-raw, can-bcm) but when i execute
>> >>>> ip link add can0 type can
>> >>> I have : RTNETLINK answers: Operation not supported
>> >>> I used a recent version of iproute2.
>> >>
>> >> You can NOT add real hardware devices with "ip link add ...".
>> >> This only works to create virtual CAN devices (vcan).
>> >>
>> >> If you have a working CAN hardware in your system a 'can0' should=
 already be
>> >> created by the CAN driver.
>> >>
>> >> Please send the output of
>> >>
>> >> cat /proc/net/dev
>> >>
>> >> to see if there's a CAN device.
>> >>
>> >> Or you might check the content of 'dmesg' output for CAN devices.
>> >>
>> >> Regards,
>> >> Oliver
>> >>
>>
>=20

