From: "Max S." <max@schneidersoft.net>
Subject: Re: SocketCAN over Ethernet
Date: Thu, 03 Apr 2014 16:51:23 +0000
Message-ID: <1396543883.12659.25.camel@blackbox>
References: <loom.20140403T134741-892@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:46645 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbaDCQzW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 12:55:22 -0400
In-Reply-To: <loom.20140403T134741-892@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel =?ISO-8859-1?Q?Bostr=F6m?= <daniel.bostrom@maximatecc.com>
Cc: linux-can@vger.kernel.org

Hello,

I don't know of a direct way of hooking up two socket can interfaces
over eth.

If this is just a quick fix or development crutch and not for productio=
n
you could try the following: Create a VCAN interface on both machines.
Create a simple userspace program (perhaps in C) to listen to the VCAN
interface, and transmit the frames read, via UDP (or TCP), to the other
machine. Create another program to listen to the UDP traffic and dumps
it into the VCAN interface on the other host. invert the roles and
you've got duplex.

If the arch of the two hosts is binary compatible you don't even need t=
o
encode data.

I have done this while I was working on a display software, It allowed
me to work on the laptop on the sofa using live can data aggregated by
sensors and a server elsewhere.

Regards,
Maximilian Schneider.

On Thu, 2014-04-03 at 11:52 +0000, Daniel Bostr=C3=B6m wrote:
> Hello,
>=20
> I am going to try to explain our scenario briefly.
>=20
> We want to setup a simulation environment for our system running on U=
buntu=20
> so that we can use it together with our Windows based simulation tool=
=20
> suite. Currently we are running Ubuntu in a virtual machine using=20
> VirtualBox on a Windows host. In Ubuntu we use SocketCAN and we would=
 like=20
> to continue to do so but instead of using real CAN hardware somehow s=
etup=20
> CAN communication over Ethernet to the Windows host.
>=20
> I am new to CAN on Linux but I have been reading about SocketCAN and =
was=20
> wondering if we could use virtual can (vcan) somehow?
>=20
> I appreciate any help clarifying if, and if so, how SocketCAN over=20
> Ethernet could be achieved. If you need additional information about =
our=20
> scenario please let me know.
>=20
> Best regards
> Daniel
> =20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


