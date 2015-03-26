From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <oe@emtas.de>
Subject: Re: newbi Question: NMEA2000 and BeagleBone
Date: Thu, 26 Mar 2015 17:35:05 +0100
Message-ID: <3106872.8FfSxeHsfU@heinz>
References: <55140B67.9060207@arcor.de> <3468382.ObYm91FbAa@heinz> <551432DB.8010406@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53025 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbCZQfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2015 12:35:09 -0400
In-Reply-To: <551432DB.8010406@arcor.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: vklein <vk4514@arcor.de>
Cc: linux-can@vger.kernel.org

Am Donnerstag, 26. M=C3=A4rz 2015, 17:24:59 schrieb vklein:
> Am 26.03.2015 um 16:50 schrieb Heinz-J=C3=BCrgen Oertel:
> > Am Donnerstag, 26. M=C3=A4rz 2015, 14:36:39 schrieb vklein:
> >> At the moment I use a Actisense NTG-1 USB and a Raspberry pi with =
the
> >> canboat software.
> >
> > It looks like the
> > Actisense NTG-1 USB
> > http://www.actisense.com/products/nmea-2000/ngt-1/ngt1-specs.html
> > is already a CAN interface and canboat can interprete the NMEA2000 =
PGNs.
> > What else do you need?
> > And if the software runs on the Raspberry it will run on the Beagle=
Bone=20
too.
> >
> >
> The actisense-NTG1  is exactly the hardware I use.
> But its rather expensive (189 =E2=82=AC ) and there may be another wa=
y to get=20
> the data.
>=20
>=20

There are many cheaper CAN USB interfaces.
And of course you can use the integrated CAN in the BeagleBone.
You have to add a transceiver and for system security galvanic isolatio=
n.

Because canboat is open source, it should be easy to adopt the SocketCA=
N or=20
can4linux CAN message format. In any case you don't need the J1939 soft=
ware.
Only receiving NMEA frames is easy, decoding the PGNs requires knowledg=
e of=20
it.
  =20

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen

Heinz-J=C3=BCrgen Oertel
	emtas GmbH


