From: Richard Andrysek <richard.andrysek@gomtec.de>
Subject: c_can driver sometimes sends first two bytes filled with zeros
Date: Thu, 12 May 2016 09:23:11 +0000
Message-ID: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from apollon.gomtec.de ([80.153.46.48]:53822 "EHLO post.gomtec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbcELJWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 May 2016 05:22:35 -0400
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

We can reproduce an issue with the canutils. We send messages in the lo=
op with non-zero bytes and from time to time we get first two bytes of =
the message with zero values. The test script looks so:

#!/bin/sh

echo "Press [CTRL+C] to stop.."
while true
do
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cansend can1 --loop=3D15 -i =
933 0xde 0xde 0xde 0xde 0xde 0xde
done

With CAN analyzer we see normally the right message, but in cycles ~1mi=
n we see first two bytes are zero.

If we add some delays between messages, like this:

do
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cansend can1 --loop=3D1 -i 9=
33 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5
	cansend can1 --loop=3D1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep 5

done

It works fine.

We use Altera Cyclone V, where the=A0 c_can driver is used. It runs wit=
h Linux kernel 3.16, but I've checked 4.5 version of a driver and it is=
 a same one.

Have somebody idea how to find a reason for that?=20

Richard

