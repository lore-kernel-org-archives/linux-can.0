From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 12/15] can: flexcan: Add support for RX-FIFO.
Date: Mon, 03 Nov 2014 14:34:24 +0100
Message-ID: <54578460.6000805@pengutronix.de>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>	<1412956020-21489-13-git-send-email-david@protonic.nl>	<5457665D.9030008@pengutronix.de> <20141103135532.7d0134bd@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ESch9BVMDwSMh0fA8EdmSBFwkcv8AsLgW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKCNe2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 08:34:28 -0500
In-Reply-To: <20141103135532.7d0134bd@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESch9BVMDwSMh0fA8EdmSBFwkcv8AsLgW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2014 01:55 PM, David Jander wrote:
> On Mon, 03 Nov 2014 12:26:21 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 10/10/2014 05:46 PM, David Jander wrote:
>>> This adds support for RX-FIFO simulating a FIFO from a linear array o=
f
>>> message- boxes. This breaks RTR reception on flexcan older than V10.
>>
>> Breaking things in one patch and fixing them later is not a good idea.=

>> Please squash this patch into 4/15, so that we don't have an
>> intermediate non-rx-fifo flexcan driver.
>=20
> Ok. I just thought that this series would be heavily squashed anyway be=
fore
> moving further upstream....

Yes, I'll squash all rx-fifo and flexcan related patches. But having my
first patch and your improvements seperate is better for a/my review, as
I'm (supposed to) know my patches :)

> Will try to squash that part.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ESch9BVMDwSMh0fA8EdmSBFwkcv8AsLgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUV4RgAAoJECte4hHFiupUxlEP/i0o2FZ7eF5J+1tpu10m+bHn
HNELJ6cLkicG7ZL6g6WGqcJuR20B8K9G4QbN26euWFpitoYGNaNWlje/4T3wnbgV
nm8DFF0x2pYdrgUdW7tRIAS6in0BUBa6cs8TnXLvx6w763SIiaPRBJnHA9IXoDVD
YzQqYf+nhwnnKNI1bJfHlfr9JhXSMIC+D3xorZ03Zws8fGPTOzekcPDnai+X2g99
pXCuaKSkx8tVbjzoXJLNMPA+YWopbMTh4jLz9Vs/7U4WNDAl463oHhJCRGoE2ATy
wbaY2g65JBy8FFKRkAf0KYwLgO8loRLcRZG8PhudlpsNr+uNyEBXJGIyT8j2C37R
MtSMiIbNasz537fOEMZcCZzP7KdZU95vUHTrYG7q84qoDLOrH+xLKR8VMZUJ0ZRm
qIvjMoaohVqv9Lp+M355Rm4QmR+vTOVO/rGHkmw/M4i1NSKFNu9q/U+xcsO/MI8M
ljDd7Mhg9qlMzkvLAbaj0JDtnK2DqNd24l9Ryb95SRVUuQ23LolZVaQBgKtV55MQ
kVR6fSfRzD4D1e0dReFBC7NhwYYQxrjrfhcR6eDEoJrwcPtuDnDxXbvQtSeRHwvy
RbUP90D2lxjCKXYSyqa+QvuWHGUeUQ0kD4Rw4cXIFXoYa8z4ez48ePM/CrNQBdIn
5/VDJ4g6w3UqkYydIfJy
=8plp
-----END PGP SIGNATURE-----

--ESch9BVMDwSMh0fA8EdmSBFwkcv8AsLgW--
