From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change
 handling.
Date: Tue, 02 Dec 2014 13:49:24 +0100
Message-ID: <547DB554.8050407@pengutronix.de>
References: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net> <547B7CDD.2080202@grandegger.com> <20141201110923.29602.38961@shannon> <6a5747c2d61b278876b6c3154c6a3130@grandegger.com> <20141201115158.1538.64214@shannon> <b4ad671712aef49ca40009d6d2ce6d24@grandegger.com> <20141201122255.3365.66370@shannon> <547CC491.3070705@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hS7cRkDP9OGPTWNE465EiUjmsKCpqacvx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56841 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbaLBMtb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 07:49:31 -0500
In-Reply-To: <547CC491.3070705@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hS7cRkDP9OGPTWNE465EiUjmsKCpqacvx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2014 08:42 PM, Wolfgang Grandegger wrote:
[...]
>> Yes. In any case, the warning interrupt is irrelevant, because we have=
 to poll
>> the state anyway for the other states. Thus the FLEXCAN_HAS_BROKEN_ERR=
_STATE
>> flag is irrelevant.
>=20
> Well, it improves the situation a little bit. But now I understand your=

> point. Yes the Flexcan core is buggy in this respect.

Yes, just a bit :) This is probably why they added the m_can core on the
new imx6 soloX.

>> The question that remains is: Should we enable bus error interrupts fo=
r all
>> flexcan cores or should we ignore the issue and allow the users to wor=
k around
>> it (if they wish) using the berr-reporting flag?
>=20
> Bus error reporting sometimes really harms and therefore I would leave
> it as-is. There are also more recent cores and it would be nice to know=
n
> if they have improved the reporting of state changes further. Anyway,
> this issue should be addressed by a separate patch series.

>> There is a middle-ground here: We could enable bus error interrupts wh=
en we get
>> the error-warning interrupt and disable them again when the state has =
reached
>> error-active again. In that case we would want to keep the BROKEN_ERR_=
STATE
>> flag.
>=20
> Puh, that's far too sophisticated.

I agree with Wolfgang. The Bus errors can make a system unresponsive to
unusable. There is still the bus error limiting patch lurking around,
which works around this problem.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hS7cRkDP9OGPTWNE465EiUjmsKCpqacvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbVUAAoJECte4hHFiupUtnsQAI/mPR+WTFwb2iil8Tb34d3d
vfc5zamg8t9VUCoReLj7DL/uezP68nTVygaZ5JkVlhj2l9ETjJKAhIbiBT3C1pqd
Eu10hQnBRe87HeIxT/i3xnhmqLK4WbR+DoJFJW7tpCIzae16tvA+x5k4DA2nRHty
VlcHgKPpHYwuuaZq/RLZv0tqQSPTwzX2KgjClENsp+tHXzqPP0harjNh5I1vtwlQ
rUsyXztW/89zzPRUKXBJ/F8sTocraBXD8KMEST+4tXm5t7nFICehAjbW2xbU2nM7
7r7qEW27DqLh3Q0tLkY5t95w1AsseUXZvWn+c4JhUSKOT0G9ByJbGpiWRREXovuu
r1q0XS8FqxRuofXHQYMPBCwN+EeweS8R8QUgu0PGbkHCWC8IqysyuVaQmAX4ioGX
Q24j0QTqzVXDbCahh6eCoOveu9ol7Alr2IxeHpHuG2PHkW/s4KWg5spmZ97bLtcU
B5gJTHr4vMImaLEGABi4mRd4G8b2aAq2uQhR//Ste1LiQ/egAvlKaw9AIvt/beEm
AuEIT/ke98lLfYMVU2jbbJAT97l34ik2RmUyg7n19XsgJJ8fUSni/cQ65zdQE8DT
PeC14w1O9d2JqCKstz23RKswmmo7wlYDC+9I5BnU8JVTfI7G9jTahvF6hQ2KT7R1
+jpqvp81kWaaIYbv3HLw
=FHSK
-----END PGP SIGNATURE-----

--hS7cRkDP9OGPTWNE465EiUjmsKCpqacvx--
