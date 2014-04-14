From: Steffen Rose <ro@emtas.de>
Subject: Re: Error Active
Date: Mon, 14 Apr 2014 11:56:54 +0200
Message-ID: <11552477.qsHBqKfRM3@lisa>
References: <15704970.EHNVEi1RO0@lisa> <945463a5ffbafb3300795ee2636584f9@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59662 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbaDNJ6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Apr 2014 05:58:05 -0400
In-Reply-To: <945463a5ffbafb3300795ee2636584f9@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

Hello Wolfgang,

> > What is the standard way to get the state change from Error Passive=
 to
> > Error Active?
>=20
> Historically we only supported "increasing" state changes
> "active->warning->passive->bus-off". A few recent drivers do
> also support "passive->warning->active" but most don't (yet).

Historically:
What was the correct error handling in state error passive? Did you ign=
ore it=20
in the application? My concrete question is, how did you "define" an er=
ror free=20
system after this state change in earlier time?

=20
> > This will work with the Systec USB interface, but do not work with =
Peak,
> > Beagle bone, EMS CPC.
>=20
> Some time ago I have posted an RFC for providing "decreasing" state
> changes
> as well including proper bus-off recovery for the SJA1000. If would d=
ig it
> out in case you are interested.

I'm afraid, I do not write / change my supported socketcan drivers. But=
 I'm=20
interested to read the RFC.
=20
> > I have seen the implementation in the can utils.
> > I know, the libsocketcan implements a different way. But I cannot=20
> > extract=20
> > the relevant parts.
> > And I think a have to poll the current state with it and I search a=
n=20
> > event=20
> > based mechanism.
>=20
> It's not a matter of libsocketcan or ip/iproute2.

I have seen a difference of the can state between
candump -e can0,0~0,#FFFFFFFF
(increase errors - last was error passive)

and
ip -det -stat link show can0
(show error warning state)

This difference was during transmission on an open can bus with Ack err=
or and=20
state error passive.
ip got the correct state error passive after receiving a message later,=
 as I=20
did check the error active state change.

Do socketcan have different ways to get the current state? Is it a low =
level=20
driver part to read and hold the current state?

(I'm sorry. I'm unsure about the driver I tested in this situation. I t=
hink,=20
it was the EMS CPC driver and kernel 3.2.0-60-generic. )

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Regards
Steffen Rose
www.emtas.de

