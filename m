From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
Date: Thu, 17 Aug 2017 15:17:18 +0200
Message-ID: <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aXB2HmuEoEx42cIlD8t4eK4fI5jFjCFq8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56391 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751620AbdHQNRX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 09:17:23 -0400
In-Reply-To: <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aXB2HmuEoEx42cIlD8t4eK4fI5jFjCFq8
Content-Type: multipart/mixed; boundary="VSFCPFXgPSpujdgBrb6Cp4tM4D3tecIV6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <9d84e955-bce1-a6e9-0d07-a4a2bab98e52@pengutronix.de>
Subject: Re: [00/14] can: cleanup of af_can/raw + simplifying of ndev->ml_priv
 handling
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <351130f1-b68e-6c0a-a18c-294940816bba@hartkopp.net>
 <dd24463a-6c2a-11e0-3fe1-1cea40923485@pengutronix.de>
 <61b043fa-311c-dd8c-404c-65adcf8e987b@hartkopp.net>
 <7d2b8653-1706-61de-6bb7-7198087dca20@pengutronix.de>
 <c6c4857d-2c5a-9f4b-8800-b24c4bb05097@pengutronix.de>
 <7e01b315-3836-4e83-a03d-4ea407e75393@pengutronix.de>
 <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>
In-Reply-To: <37e54c7f-9085-fc6c-716f-a217e3939fa4@hartkopp.net>

--VSFCPFXgPSpujdgBrb6Cp4tM4D3tecIV6
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 03:13 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/17/2017 03:06 PM, Marc Kleine-Budde wrote:
>=20
>>>> No. Another approach is keep the memory allocation in the
>>>> NETDEV_REGISTER hook, but refuse to start the netdev with NOTIFY_DON=
E.
>>>
>>> copy/paste confusion:
>>> NOTIFY_STOP of course
>>
>> Or even use notifier_from_errno
>=20
> I still have no idea what you mean :-(

The code gets complicated, as during NETDEV_REGISTER the malloc may
fail. But we can cancel the register with return
notifier_from_errno(-ENOMEM);

> With NETDEV_REGISTER the memory would be allocated. Ok.
>=20
> An how would the memory be free'd then?

NETDEV_UNREGISTER... But we have a problem, as j1939 needs per device
memory, too. Which is kfree()ed in a NETDEV_UNREGISTER hook, too. The
order of the hooks in not guaranteed.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VSFCPFXgPSpujdgBrb6Cp4tM4D3tecIV6--

--aXB2HmuEoEx42cIlD8t4eK4fI5jFjCFq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmVl14ACgkQHv7KIOw4
HPYF9wf3Rwui5UZzwteirjAdmb1mKlSEJgIYn/nhuGSwuucgg6gd3m7l2Cpvdt9k
v3xBnzinUHVe7ydYRDALOBAhwTCKOv4o5eMDoL7eE7oRBV3KBvzJaSgIjl8ofNPn
YJyw8GF0XT2cBus8xqYGLbIz7kJ157/9XU8qY6Mq7nEmdTKlqsSYdwFuIJIqSp5b
UFGVxg/9nvC5F4uYDAep1gyhvb4MPh6R1P4rYCPYj4DtQeKzuqvT2xM+UKTfwD6q
6jQEXB6QnKLCZaq1+Zpp5A0+bFf3OrEvyOhUxiYzqr+XGBsHxfvuDdRUMoa3kCt1
HfsOppCz9fr4rRvnopa1fTWpzgB4
=ZHDE
-----END PGP SIGNATURE-----

--aXB2HmuEoEx42cIlD8t4eK4fI5jFjCFq8--
