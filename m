From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 14:14:22 +0200
Message-ID: <5058659E.2010804@grandegger.com>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47920 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab2IRM1P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 08:27:15 -0400
In-Reply-To: <505777BC.3000705@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/17/2012 09:19 PM, Oliver Hartkopp wrote:
> Hello Heinz,
>=20
> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>=20
>>
>> is there a way to empty the tx buffer ?
>=20
>=20
> Usually the buffer does not get empty due to a problem of the CAN con=
troller
> and/or the CAN network.
>=20
> So even if you could flush the queue the CAN controller is probably s=
till
> stuck with his processed frame.
>=20
> Setting the interface to DOWN and UP again re-initializes the CAN con=
troller
> and flushes all the queues.
>=20
> This would work - but all open sockets would get a notification of th=
e
> interface went down.
>=20
> Btw. IIRC there's a IFLA_CAN_RESTART functionality to kick the CAN co=
ntroller
> if it got stuck. It can by triggered by a netlink message. This is th=
e same
> configuration interface that's used to set the bittiming:
>=20
> http://lxr.linux.no/#linux+v3.5.4/include/linux/can/netlink.h#L103
>=20
> But i have currently no source code example as i always use the 'ip' =
tool from
> the iproute2 package to configure my CAN interfaces:
>=20
> http://lxr.linux.no/#linux+v3.5.4/Documentation/networking/can.txt#L6=
46
>=20
> Following that documentation
>=20
> 	ip link set can0 type can restart
>=20
> should do it for 'can0'.

No, this does only works if a bus-off is pending. See:

http://lxr.linux.no/#linux+v3.5.4/drivers/net/can/dev.c#L413

Well, the name IFLA_CAN_RESTART is not really well chosen.

Wolfgang.

