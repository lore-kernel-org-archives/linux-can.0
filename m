From: Richard Andrysek <richard.andrysek@gomtec.de>
Subject: AW: c_can driver sometimes sends first two bytes filled with zeros
Date: Tue, 17 May 2016 17:18:46 +0000
Message-ID: <0120733A154AE74CA608A286CE7FFD2621D9C80F@rg-contact.RG.local>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
 <573A0E08.4010008@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from post.gomtec.de ([80.153.46.48]:29885 "EHLO post.gomtec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbcEQRSu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 May 2016 13:18:50 -0400
In-Reply-To: <573A0E08.4010008@opensource.altera.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Thor,

I've made two use cases with can0:

a)	RAW socket can with 200us steps
b)	8 CAN messages with 150us step in a broadcast mode

Both works perfect, only my PCAN USB has from time to time an overrun. =
I think I need another logger:)

But if I take case b) and reduce steps to 128us I get two frames with w=
rong two first bytes per 3min.
Similar behavior in case a).

Questions:
   Q1) What I still don't understand, if there is a failure I do not ge=
t any error value. Why that?
   Q2) Is there somewhere missing some kind of locking mechanism?

-----Urspr=FCngliche Nachricht-----
Von: Thor Thayer [mailto:tthayer@opensource.altera.com]=20
Gesendet: Montag, 16. Mai 2016 20:15
An: Richard Andrysek <richard.andrysek@gomtec.de>; linux-can@vger.kerne=
l.org
Betreff: Re: c_can driver sometimes sends first two bytes filled with z=
eros

Hi Richard,

On 05/12/2016 04:23 AM, Richard Andrysek wrote:
> We can reproduce an issue with the canutils. We send messages in the =
loop with non-zero bytes and from time to time we get first two bytes o=
f the message with zero values. The test script looks so:
>
> #!/bin/sh
>
> echo "Press [CTRL+C] to stop.."
> while true
> do
>                 cansend can1 --loop=3D15 -i 933 0xde 0xde 0xde 0xde 0=
xde=20
> 0xde done
>
> With CAN analyzer we see normally the right message, but in cycles ~1=
min we see first two bytes are zero.
>
> If we add some delays between messages, like this:
>
> do
>                 cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0x=
de 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
>
> done
>
> It works fine.
>
> We use Altera Cyclone V, where the  c_can driver is used. It runs wit=
h Linux kernel 3.16, but I've checked 4.5 version of a driver and it is=
 a same one.
>
> Have somebody idea how to find a reason for that?
>
> Richard
>
How old are your canutils? I had a similar issue on an older version of=
 cansend (4.0.6 from the Pengutronix site - with a copyright date of 20=
09).

There is an old thread (http://comments.gmane.org/gmane.linux.can/2339)
that suggests adding a delay in the cansend utility to work around a po=
ll/select bug.

I added a delay for 4.0.6 but you may want to grab the latest from gith=
ub (https://github.com/linux-can/can-utils).

> --
> To unsubscribe from this list: send the line "unsubscribe linux-can"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>
