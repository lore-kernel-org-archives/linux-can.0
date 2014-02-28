From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 14:18:15 +0100
Message-ID: <53108C97.9060603@pengutronix.de>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de> <53108210.6070700@hartkopp.net> <5310867F.8060503@pengutronix.de> <531087FB.6010008@hartkopp.net> <531089AB.2010602@pengutronix.de> <53108A8D.6040404@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6osfPWR1aG8ee6IBRC0qFcuMd7jOB6CCs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42742 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaB1NSS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 08:18:18 -0500
In-Reply-To: <53108A8D.6040404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6osfPWR1aG8ee6IBRC0qFcuMd7jOB6CCs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2014 02:09 PM, Oliver Hartkopp wrote:
> On 28.02.2014 14:05, Marc Kleine-Budde wrote:
>> On 02/28/2014 01:58 PM, Oliver Hartkopp wrote:
>=20
>=20
>>> Btw. this could be a general simplification topic for the future.
>>
>> Yes, removing do_set_bittiming() is a different topic.
>>
>>> I do not have any objections to remove the callbacks in can_priv and =
call the
>>> device specific functions for the (data) bittiming setting in the ope=
n
>>> function then.
>>
>> \o/
>>
>> Can you can an Acked-by from Kurt for the whole series?
>=20
> I assume you talk about Stephane ?!?

Yes, of course. Thanks for following my thoughts:)

> I'll send out a v8 for him for a final review.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6osfPWR1aG8ee6IBRC0qFcuMd7jOB6CCs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMQjJcACgkQjTAFq1RaXHNXOwCfdeNv20yVO9MAEagi6fwn687T
MFoAnR/5dRLbT6hLTrPQek6Mnt4yPLNV
=wQ5P
-----END PGP SIGNATURE-----

--6osfPWR1aG8ee6IBRC0qFcuMd7jOB6CCs--
