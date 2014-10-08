From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Wed, 08 Oct 2014 12:43:40 +0200
Message-ID: <5435155C.6030709@pengutronix.de>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <20141008110839.489a786d@archvile> <54350A34.1020402@pengutronix.de> <1544714.FueVS1KdZh@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="N2982pBOnauEoeBJJiWVLK5xNltlkx5GI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57518 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbaJHKno (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Oct 2014 06:43:44 -0400
In-Reply-To: <1544714.FueVS1KdZh@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: David Jander <david@protonic.nl>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N2982pBOnauEoeBJJiWVLK5xNltlkx5GI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2014 12:36 PM, Alexander Stein wrote:
[...]
>>> In this piece of code, suppose that fifo->next is in the upper half a=
nd a
>>> message is being written to the MB it is pointing at, but it is still=
 not
>>> pending. The lower half has already been enabled and filled up comple=
tely (due
>>> to latency). In that case, fifo-next will jump back to fifo->low_firs=
t and
>>> leave a lonely filled MB in the middle of the upper half, that will t=
rigger
>>> and infinite loop between IRQ and can_rx_fifo_poll(). The interrupt w=
ill never
>>> get cleared again.
>>> I know this is an extreme case of latency being so high as to fill mo=
re than
>>> the complete lower half, but if it strikes, it results in a lock-up. =
Am I
>>> right, or did I screw up somewhere?
>>
>> Correct analysis :( At least it shows it makes sense to have this code=

>> in a central place.....
>=20
> I didn't reviewed that piece of code, I just read David's
> description. Well, I actually saw this scenario on pch_can where the
> rx mailboxes are split in lower and upper half. The current upper MB
> was empty and rx_poll left handling MBs and freed the lower MB.
> Meanwhile a frame was about beeing inserted in the current upper MB.
> Upon next interrupt reception started on lower MBs until eventually
> the remained frame in upper MB was read. But at this time the order
> is messed up. There was no lockup, because the interrupt signaling
> worked a bit different.
>=20
>> If we handle the low_first mailbox, we might have to check if the "old=
"
>> next, or better, if any of the mailboxes >=3D old_next are pending *an=
d*
>> there is a non pending mailbox < "old" next. This should be possible
>> with one or two clever bitmasks.
>=20
> If we detect that (all) MBs before the old one are pending again, we
> even can't ensure proper CAN frame order. All MBs below and even

ACK, this is why I suggested the "non pending MB in front of old next"
check.

> after old_next coul have been written meanwhile. That's why I hate
> those MB interfaces and prefer a real FIFO.

If you have a FIFO, which is big enough....(for no various definitions
of big enough) of course a FIFO is preferred.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--N2982pBOnauEoeBJJiWVLK5xNltlkx5GI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ1FVwACgkQjTAFq1RaXHMu5ACghGFXaPrqgKv04W8bqQ8cvWnH
D8AAn1gXqJmvacyOwOzB9EN7fjHJUGn6
=heOr
-----END PGP SIGNATURE-----

--N2982pBOnauEoeBJJiWVLK5xNltlkx5GI--
