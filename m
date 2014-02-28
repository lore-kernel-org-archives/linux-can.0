From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 14:05:47 +0100
Message-ID: <531089AB.2010602@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de> <53108210.6070700@hartkopp.net> <5310867F.8060503@pengutronix.de> <531087FB.6010008@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b134ouVTJG1d3AJuAjiFtQlujI4E61JBI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52151 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaB1NFu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 08:05:50 -0500
In-Reply-To: <531087FB.6010008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b134ouVTJG1d3AJuAjiFtQlujI4E61JBI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 01:58 PM, Oliver Hartkopp wrote:
>>>> A new do_set_data_bittiming() callback is not needed, as it's better=
 do
>>>> set the data and "normal" bit timing registers during open().
>>>
>>> With this argumentation do_set_bittiming() has to be removed too.
>>>
>>> Is this your intention?
>>
>> Yes. But it's in many drivers so let's keep it, for now.
>>
>=20
> Good.
>=20
> Btw. this could be a general simplification topic for the future.

Yes, removing do_set_bittiming() is a different topic.

> I do not have any objections to remove the callbacks in can_priv and ca=
ll the
> device specific functions for the (data) bittiming setting in the open
> function then.

\o/

Can you can an Acked-by from Kurt for the whole series?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--b134ouVTJG1d3AJuAjiFtQlujI4E61JBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQiasACgkQjTAFq1RaXHO7WACdEEiTpJTPy2MYWQ9LmpFt5DOo
1p8AnA1Fugzokrr9MrUi8tvhJLu4UuaQ
=cdiF
-----END PGP SIGNATURE-----

--b134ouVTJG1d3AJuAjiFtQlujI4E61JBI--
