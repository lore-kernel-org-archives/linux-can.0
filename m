From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: c_can: (newbie) high system load when frame not acked?
Date: Tue, 13 Jan 2015 16:16:22 +0100
Message-ID: <54B536C6.6030406@pengutronix.de>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="beh8fm66IMFKuUHL2otKKG3A8KVL6Sk8J"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54847 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbAMPQg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 10:16:36 -0500
In-Reply-To: <alpine.DEB.2.02.1501131523290.12789@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>, Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--beh8fm66IMFKuUHL2otKKG3A8KVL6Sk8J
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2015 04:10 PM, Viktor Babrian wrote:
>> Maybe you can turn the error interrupts off and still have it
>> function. Maybe it won't (may be required for bus off recovery).
>=20
> Thanks for the detailed answer. I read the pages and took a look into
> the code.
>=20
> Regarding state-change behavior, DCAN controller is similar to the one
> in i.MX6. (It has explicit interrupt source for Act->Warn and Pass->BOF=
F
> transitions).
> Although as I understand CAN, you have to have a successful RX or TX
> event to have the counters decrease. That  means that you will have an
> immediate report (i.e. interrupt) on Warn->Active, Pass->Warn and
> BOFF->Active. As far as I see, this latter is explicitly handled by
> upper layers so driver will have to know it anyway.
> This means that if I turn off bus error monitoring, the only event I
> will not get immediate report of is Warn->Pass. (Pass->Warn can be
> reported on successful message events if the driver is implemented
> accordingly. Currently it isn't). However it could be reported later
> upon the first successful message event. I beleive missing an accurate
> report of active->passive state change is far better than having a
> non-responding system in the field in scenarios that do happen.
>=20
> Anyway I modified the code so that state change interrupt is not enable=
d
> when user sets berr-reporting off (as you kindly suggested). It solves
> the load issue. Bus-off recovery behavior did not change (I made a few
> tests only). Btw the driver disables all interrupts in bus off so I
> guess it does not matter what exact flags were set.
>=20
>> The consequence (depending on the CPU and Linux build options) is
>> 10%-100% CPU utilisation when there's nothing to ACK the packet, and a=

>> higher figure again when the bus isn't terminated.
>>
>> CAN is meant to be used in cars or factories. Running with only one
>> node or a disconnected bus is not a "normal" condition, so the
>> hardware and drivers don't handle those conditions well.
> Well error states are defined by the spec so they ARE normal. What is
> not normal is to bring down system performace when they happen.
>=20
>=20
> I alose added a line to put the controller in init mode in c_can_stop()=

> so that bringing the bus down will actually cause the controller stop
> transmitting. I hope it's the way to do this, it would be nice if some
> expert could verify this.

Can you send patches?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--beh8fm66IMFKuUHL2otKKG3A8KVL6Sk8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtTbGAAoJECte4hHFiupUJpQQAIa0i9N6pxDXKF6niaeMVn3M
SEV4o5GHr0UeiVTAEomoRqO9h1E2/pXUQ2S+DXjw2J/wLhy8V30es0KW+QJwqc03
i/pDTPfJRoE8DUNfFPaYSDy8pbW5eu26QMjaP0T1B/GjgC4hKnCLPadRhs2D6ZIN
2jRl4S6O87dFc5PYuuH1hXAAf/sFX0Z2FViPLL7lRK5hTwj0kQjHQZKprk0ZqHmq
GaJUHPkIpWXZFyB1r/v3g8WfyMFeeNyBXyrEFrLQz2ys5kskKmO0dAN2//Djis9p
fwe+sawRafGO4FzPi4IvfK4ZJdgl6xs2IVR18Sb2tNO9dTfTiHl8EjhFzM86i0Dw
jKS6h357FIfwwWDOsQHVus/NSAIJg3C0hQvUyX6V0QGTmVFYUdznpegjxfCZ2G5E
NH4sfvQEgaVxYe/MMlAExWR4/OjXWuSYgxXVIdQQnDEZQm8x/kfWnefRcwN+XWy6
FMjBqeENGErTSphXbCk34jCP784AjHiEM0MGe2k3H3gtyU64DQGA7KbJxt0TEQ9b
MimpTbCHmEYeWEt4WTXN9DEs2+J1z4zpxZc70eoyP2RW0n5NqWCLep4Nw1vKfMi4
AvxgJ14V/gJaJmG6d6xRaLkb215As9eoCSnYwNRprTuQMFr/mQglLZa348y3+ChB
7tRJd10ScNjTTm99NrPP
=vpw/
-----END PGP SIGNATURE-----

--beh8fm66IMFKuUHL2otKKG3A8KVL6Sk8J--
