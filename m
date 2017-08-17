From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:02:00 +0200
Message-ID: <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Pvc2Uv8fsQe7x79uEevQqiHtUqrl5aGT0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42719 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751850AbdHQNCH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:02:07 -0400
In-Reply-To: <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pvc2Uv8fsQe7x79uEevQqiHtUqrl5aGT0
Content-Type: multipart/mixed; boundary="AhR0pcUiP1PGBVkwcpDg0U1NSWlgTPo4j";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
In-Reply-To: <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>

--AhR0pcUiP1PGBVkwcpDg0U1NSWlgTPo4j
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 02:57 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> On 08/17/2017 01:57 PM, Marc Kleine-Budde wrote:
>=20
>>
>> Have you found some time to look at these issues?
>>
>=20
> I'm going through the code just now ;-)
>=20
> One question:
>=20
> All the midlayer private stuff was also done to cleanly separate the=20
> network layer stuff in net/can from the driver layer stuff in=20
> drivers/net/can.
>=20
> Now you introduce a network layer data structure into the driver layer.=

> I'm not against this - and in fact I can see a bunch of advantages and =

> simplifications as you intended.

> But do you think it's a proper approach from the perspective of layer=20
> separation?

No. Another approach is keep the memory allocation in the
NETDEV_REGISTER hook, but refuse to start the netdev with NOTIFY_DONE.
Then we can skip all the NULL pointer checks, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AhR0pcUiP1PGBVkwcpDg0U1NSWlgTPo4j--

--Pvc2Uv8fsQe7x79uEevQqiHtUqrl5aGT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVk8gACgkQHv7KIOw4
HPYYXQf/cXjblWgvY39RfRNcAhBm+2wQ6iMiNFzByVapUAtd6TIVLWLCFPt/xAbk
7TK7Xq+A2jrOboBOf9vV6Rwm0LWpf16C8kJBwqgwE0qJ23bpeWaMpbJrIbEfAY/G
1gQY/qSngPP32gMicIiKI3mOltIZNs+K8eVdcLCSIVzkxTbgesiHgLvjz6oaagVb
7t3rZnRG+8wSRWXagZLaYbSiph6xlwdU4a5a1elrma7rfs0ZEUivM1ystDBxuBAX
3wQ3ablQzwyAQWZirrdKImzi0DPbBtqmFPVmUKj0Wf+4rvLx8HKnMeJytNYncATu
j7SjLfWhrANVrRhOy65nD+pSOfwoWA==
=uYTp
-----END PGP SIGNATURE-----

--Pvc2Uv8fsQe7x79uEevQqiHtUqrl5aGT0--
