From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Tue, 15 Aug 2017 11:16:44 +0200
Message-ID: <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7TuVUE8diHEr6uRoKxOsuppBSfBrBOAx4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60391 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752373AbdHOJQw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Aug 2017 05:16:52 -0400
In-Reply-To: <20170815110116.4d12f4f3@erd980>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7TuVUE8diHEr6uRoKxOsuppBSfBrBOAx4
Content-Type: multipart/mixed; boundary="7hWCbVKXQP4VtMriJFJE6hlbhaidv6PM0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Jander <david@protonic.nl>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
In-Reply-To: <20170815110116.4d12f4f3@erd980>

--7hWCbVKXQP4VtMriJFJE6hlbhaidv6PM0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 11:01 AM, David Jander wrote:
> On Tue, 15 Aug 2017 10:14:18 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 08/14/2017 07:37 PM, Marc Kleine-Budde wrote:
>>> - Should a second bind() be allowed on a previously bind() socket?
>>>
>>> As far as I understand the code, there's some support, but when the
>>> interface is switched, j1939_ifindex_stop() is not called. =20
>>
>> Ah, there's a check, that you cannot re-bind() to another interface:
>>
>>> 		if (bound_dev_if !=3D addr->can_ifindex) =20
>=20
> This makes sense. re-bind() to another interface only would make sense =
if
> bind() to any interface is also permitted, but that would imply separat=
e
> address-claims on all different interfaces with potentially different
> source-address being claimed on each one.... don't think the stack shou=
ld take
> care of such complex scenarios, at least not at first IMHO.

Bind to any interface doesn't work, you cannot send anything:

> static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, siz=
e_t size)
> {
[...]
> 	ifindex =3D jsk->ifindex_started;
> 	if (!ifindex)
> 		return -EBADFD;

And you will probably not receive anything, as the rx-register, which
takes place in j1939_ifindex_start() is not done if you try to bind to
any device (bound_dev_if =3D=3D 0).

> 	if (bound_dev_if && bound_dev_if !=3D jsk->ifindex_started) {
[...]
>=20
> 		ret =3D j1939_ifindex_start(bound_dev_if);

Then I'll add proper test, that you have to bind to a specific
interface. That will make the code much simpler.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7hWCbVKXQP4VtMriJFJE6hlbhaidv6PM0--

--7TuVUE8diHEr6uRoKxOsuppBSfBrBOAx4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmSu/wACgkQHv7KIOw4
HPbyCQgA2E1jezjqXAlLcCik16OSKL9YtWGN8c6JwubBt7cw5Sd7oBfqlHVGqIGP
6M63BRYwkIbcn6TGNCAC6SJiKbjhAyHAJyB2YIUss154/IdXH9Sj6v4HOrssNdRr
kt7cT12L3Fcprw7LWJiIgc2xlPLslbXfHkWfEGA7yTDuQkSgFCZ0kKEhoYaNPQwD
v0nBkoAJvp/kiTt3FIOdP/ZQdyyG4fS+K6WcoSY3xgxNuyZZb5zTR+rv5aiU3r6k
pvtQibkpVdzdThNnjgsU3PUrESpcBj21z/F6wrB+RGwFqazXuPeSI988pJbklKjs
rjl8W77jtiQa2W4Al8WBd2sSWXwZCA==
=n623
-----END PGP SIGNATURE-----

--7TuVUE8diHEr6uRoKxOsuppBSfBrBOAx4--
