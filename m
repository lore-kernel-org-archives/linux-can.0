From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Fwd: [PATCH] can: use namespace aware procfs function
Date: Tue, 25 Apr 2017 10:59:31 +0200
Message-ID: <59e144f6-2bed-26fd-9cef-545e3ffed176@pengutronix.de>
References: <20170415180629.2268-1-socketcan@hartkopp.net>
 <da6d2ac9-a6b1-2cdc-b80c-a47fef8ae887@hartkopp.net>
 <82acaf2e-20d8-b6af-1853-292ceb5c1d43@pengutronix.de>
 <1e953bd5-9538-1d11-85bf-c9d30a911836@hartkopp.net>
 <2e398801-8723-881e-7666-1da6af4616d5@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1rw7SJVlMrPWargVF7pSad4T19iUNGmj8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42661 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1177034AbdDYI7g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 04:59:36 -0400
In-Reply-To: <2e398801-8723-881e-7666-1da6af4616d5@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Mario Kicherer <dev@kicherer.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1rw7SJVlMrPWargVF7pSad4T19iUNGmj8
Content-Type: multipart/mixed; boundary="NtWqpXHIgsc58J5gLuK0Lm4n2uOvwFMKP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Mario Kicherer <dev@kicherer.org>
Message-ID: <59e144f6-2bed-26fd-9cef-545e3ffed176@pengutronix.de>
Subject: Re: Fwd: [PATCH] can: use namespace aware procfs function
References: <20170415180629.2268-1-socketcan@hartkopp.net>
 <da6d2ac9-a6b1-2cdc-b80c-a47fef8ae887@hartkopp.net>
 <82acaf2e-20d8-b6af-1853-292ceb5c1d43@pengutronix.de>
 <1e953bd5-9538-1d11-85bf-c9d30a911836@hartkopp.net>
 <2e398801-8723-881e-7666-1da6af4616d5@hartkopp.net>
In-Reply-To: <2e398801-8723-881e-7666-1da6af4616d5@hartkopp.net>

--NtWqpXHIgsc58J5gLuK0Lm4n2uOvwFMKP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 12:55 PM, Oliver Hartkopp wrote:
> On 04/15/2017 10:56 PM, Oliver Hartkopp wrote:
>> On 04/15/2017 08:21 PM, Marc Kleine-Budde wrote:
>>> On 04/15/2017 08:12 PM, Oliver Hartkopp wrote:
>>>> can you squash this fix into my original RFC v2 patch?
>>>
>>> will do.
>>>
>>
>> Great!
>>
>> I finalized a namespace patch for CAN BCM some minutes ago.
>>
>> I'll do some more testing tomorrow and post it then.
>=20
> Done :-)
>=20
> Will you push these patches to can-next?

done.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NtWqpXHIgsc58J5gLuK0Lm4n2uOvwFMKP--

--1rw7SJVlMrPWargVF7pSad4T19iUNGmj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlj/D/MACgkQHv7KIOw4
HPadlQf6AqxJfw4b4CyJtHUd+NzaVCH4ow9f1ujO0w8yf62oReaERNFlouzlXICT
IYaw38K5AExHVZSKWAHQ6603YpsTnG3ep3P2phzeDcjBUpG8lJD1j7rH9rsnk3d8
fB0+lxvElwC55uxzrXuRcP1EWPKMbpMKMDCslC080e616NCnIjczqBgmRcGRFBim
iVytv7Al/c2iRQwfyKK8FTFI1EpCeYxAzc5VlsB1dHlbtHTjFUVlOH13GWjiMeLU
QQ+lzUDt46aLno4bahjfRA2xvn9wP3EQkPpULi7q+DXXC1kLsK2p0AXxkUvQ6OBf
+VEkGUhR8EEr6t8TY1+96TVTs2LuVQ==
=H8Ai
-----END PGP SIGNATURE-----

--1rw7SJVlMrPWargVF7pSad4T19iUNGmj8--
