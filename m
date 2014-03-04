From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Tue, 04 Mar 2014 21:44:03 +0100
Message-ID: <53163B13.90900@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de> <53108210.6070700@hartkopp.net> <5310867F.8060503@pengutronix.de> <531087FB.6010008@hartkopp.net> <531089AB.2010602@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oEqxFJk5a3ackruq19OfRcQGNs40BcL0O"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54675 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782AbaCDUoJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:44:09 -0500
In-Reply-To: <531089AB.2010602@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oEqxFJk5a3ackruq19OfRcQGNs40BcL0O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 02:05 PM, Marc Kleine-Budde wrote:
> On 02/28/2014 01:58 PM, Oliver Hartkopp wrote:
>>>>> A new do_set_data_bittiming() callback is not needed, as it's bette=
r do
>>>>> set the data and "normal" bit timing registers during open().
>>>>
>>>> With this argumentation do_set_bittiming() has to be removed too.
>>>>
>>>> Is this your intention?
>>>
>>> Yes. But it's in many drivers so let's keep it, for now.
>>>
>>
>> Good.
>>
>> Btw. this could be a general simplification topic for the future.
>=20
> Yes, removing do_set_bittiming() is a different topic.
>=20
>> I do not have any objections to remove the callbacks in can_priv and c=
all the
>> device specific functions for the (data) bittiming setting in the open=

>> function then.

It's still present in v9, I'll send a v10 which removes the
"priv->do_set_data_bittiming()" callback.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oEqxFJk5a3ackruq19OfRcQGNs40BcL0O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMWOxQACgkQjTAFq1RaXHMAyQCeOYLHKral8HC+YGgI4i7u+WKe
xW4An2BUWBX+r0sz77TDzq+JFpNBtRAD
=qTF9
-----END PGP SIGNATURE-----

--oEqxFJk5a3ackruq19OfRcQGNs40BcL0O--
