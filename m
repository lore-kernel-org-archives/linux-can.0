From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 21:57:02 +0200
Message-ID: <523DFA0E.9010209@grandegger.com>
References: <1881932.U1kQQJkqCz@heinz.site> <523D643F.6040703@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33233 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3IUT5E (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 15:57:04 -0400
In-Reply-To: <523D643F.6040703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

On 09/21/2013 11:17 AM, Oliver Hartkopp wrote:
> On 21.09.2013 01:03, Heinz-J=FCrgen Oertel wrote:
>> Hello Linux CAN community,
>>
>> long before SocketCAN, which now is part of the Linux kernel drivers=
, can4linux was available as the CAN device driver for Linux.
>>
>> I now like to add it to the kernel source tree as well. What to you =
think about it. And how should I start and proceed?
>> I would like to start with the Xilinx XCANPS as can be found on the =
Zynq processor. Maybe also with one PCI board, the CPC-PCI (EMS W=FCnsc=
he).
>>
>> What is the best way? My current development for the PC is based on =
OpenSuse with kernel 3.7.10. for Xilinx it is kernel 3.10. Can I send a=
 patch against 3.7 and to whom can I send it?
>=20
> Hello Heinz,
>=20
> merging the two different approaches makes sense in that way that the
> different users of the can4linux character device API should be able =
to take
> part of the Linux mainline improvements.
>=20
> The question is how to make it a win-win for both sides without doing=
 double work:
>=20
> 1. SocketCAN & can4linux users should be able to use a common CAN dri=
ver pool
> 2. The netdev and the chardev should be able to run simultaneously
> 3. The chardev API preferably should support all chardev flavours
>=20
> Indeed i did some evaluations about the migration from the chardev AP=
I of
> can4linux to SocketCAN in my thesis on page 156ff
>=20
> (unfortunately in german)
> A.8 Migration existierender CAN Anwendungen
>=20
> You might get the thesis from here:
> http://edoc.bibliothek.uni-halle.de/servlets/DocumentServlet?id=3D973=
8
>=20
> In chapter 8.2 there's a concept describing the co-existence of a cha=
racter
> device emulator and how to connect it to the existing Linux CAN
> infrastructure. A screenshot from that picture is attached to this ma=
il.
>=20
> The advantages of this approach:
>=20
> - only one hardware driver pool to maintain (e.g. add Xilinx as netde=
v driver)
> - SocketCAN and can4linux apps can run simultaneously on the same CAN=
 hardware
> - SocketCAN protocols CAN_BCM and the CAN gateway CAN_GW are still op=
erational
> - a compact and easy maintainable chardev API adapter emulation
> - can4linux API users get access to all existing CAN netdev drivers (=
USB, ...)
>=20
> A real good thing would be if the chardev emulation adapter would sup=
port
> different chardev flavours like can4linux, PEAK, LinCAN, ...

*No*, please not, at least not as part of the Linux kernel. People
should port their applications to Linux-CAN and then they will
automatically profit from further improvements.

Wolfgang.

