From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <oe@port.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Mon, 17 Sep 2012 21:40:41 +0200
Message-ID: <3033577.LU3ttOr8xL@linux-edhj>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <4283CE44E963D741A50240F32D185B9F109AA1@SBSPORT3.portgmbh.local>
Reply-To: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <oe@port.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64457 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab2IQTkr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Sep 2012 15:40:47 -0400
In-Reply-To: <4283CE44E963D741A50240F32D185B9F109AA1@SBSPORT3.portgmbh.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp =?utf-8?B?4oCO?= <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org


Hallo Oliver,
Danke f=FCr Deine Antwort.

>=20
> Hello Heinz,
>=20
> On 17.09.2012 15:58, Heinz-J=FCrgen Oertel wrote:
>=20
> >
> > is there a way to empty the tx buffer ?
>=20
>=20
> Usually the buffer does not get empty due to a problem of the CAN con=
troller
> and/or the CAN network.

I know :-)

>=20
> So even if you could flush the queue the CAN controller is probably s=
till
> stuck with his processed frame.

At least the SJA1000 (I'm using most often)
allows to abort a pending transmission.

>=20
> Setting the interface to DOWN and UP again re-initializes the CAN con=
troller
> and flushes all the queues.
>=20
> This would work - but all open sockets would get a notification of th=
e
> interface went down.

May be in my current case this is acceptable.

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
>         ip link set can0 type can restart
>=20
> should do it for 'can0'.
>=20
> > Or read out the occupied size of it
> > to get the mumber of CAN frames waiting for transmission?
>=20
>=20
> I'll take a look, if there's a programming interface to get this valu=
e.
> Or is this request obsolete now after my answer above?

No. This is still of interest.
Knowing if the transmit queue is mostly empty is a good thing.
Otherwise the application is sending to fast,
or a lot of higher priority messages are on the network.
>=20
> Regards,
> Oliver
>=20

Thanks for your effort.
Regards
    Heinz



