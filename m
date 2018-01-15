From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can-next 2017-12-01,Re: pull-request: can-next
 2017-12-01
Date: Mon, 15 Jan 2018 21:54:29 +0100
Message-ID: <2372427e-2db4-b386-f51d-86f976033765@pengutronix.de>
References: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
 <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
 <be945e20-d5d5-f786-c9d4-3a3ef97a0292@pengutronix.de>
 <20180115.125529.1662730568101394452.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IfPPe3OJaALNWUjhb0nSPL8vRO6kDooZo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43577 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeAOU4L (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 15:56:11 -0500
In-Reply-To: <20180115.125529.1662730568101394452.davem@davemloft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfPPe3OJaALNWUjhb0nSPL8vRO6kDooZo
Content-Type: multipart/mixed; boundary="EBfDUBvJz3rLf08nSByup95cBsoQoUXu1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <2372427e-2db4-b386-f51d-86f976033765@pengutronix.de>
Subject: Re: pull-request: can-next 2017-12-01,Re: pull-request: can-next
 2017-12-01
References: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
 <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
 <be945e20-d5d5-f786-c9d4-3a3ef97a0292@pengutronix.de>
 <20180115.125529.1662730568101394452.davem@davemloft.net>
In-Reply-To: <20180115.125529.1662730568101394452.davem@davemloft.net>

--EBfDUBvJz3rLf08nSByup95cBsoQoUXu1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 06:55 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Mon, 15 Jan 2018 14:02:23 +0100
>=20
>> Hello David,
>>
>>
>> On 01/05/2018 12:08 PM, Marc Kleine-Budde wrote:
>>> Hello David,
>>>
>>> this is a pull request of 7 patches for net-next/master.
>>>
>>> All patches are by me. Patch 6 is for the "can_raw" protocol and add
>>> error checking to the bind() function. All other patches clean up the=

>>> coding style and remove unused parameters in various CAN drivers and
>>> infrastructure.
>>
>> this pull request is still open. Any objections to pull this?
>=20
> You gave me an SSH URL:
>=20
> 	ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git tags/linux-can-next-for-4.16-20180105
>=20
> Or did you plan to give my your SSH password so that I can pull this? :=
-)
>=20
> Please resubmit with a proper git:// URL I can actually pull from.

I don't see a reason, why you need my ssh keys. That was intentional.

As long as you have your SSH keys, you have read only access to my (and
the git repos of the other kernel developers) on git.kernel.org. I'm
already fetching from net and net-next via ssh:

>> $ git fetch net
>> remote: Counting objects: 70, done.
>> remote: Compressing objects: 100% (70/70), done.
>> remote: Total 70 (delta 59), reused 0 (delta 0)
>> Unpacking objects: 100% (70/70), done.
>> From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/davem/net
>>    6926e041a892..5133550296d4  master     -> net/master

See Konstantin Ryabitsev's mail "[kernel.org users] Forcing git to
always use gitolite.kernel.org" for more details.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EBfDUBvJz3rLf08nSByup95cBsoQoUXu1--

--IfPPe3OJaALNWUjhb0nSPL8vRO6kDooZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpdFQcACgkQHv7KIOw4
HPbshQf/b9o+o0492NglZZ9CPMWLbT6aEzKPPmv8pHF2DI7KN2qWW++HVQKuZOLf
wcc3HGuj5wTgkHuN1gdC/d++IKIq33km4ia9cHEyx5Nar0hgEPtQDFZr5xGPiY6R
19DNWFKRr2DdyWGiJ3/XlKcnE2wmOq3SaeQrwV+ZaRgttLg8cBtbpuYYmIpB3EDq
KABWQdQ+QCXqktNb73ztyWVaBH6kZTnyNUOP1dMy7Vdw6oAc+XVCpr6dltnNUorj
ZkH3Q34nfaXDmGMDoqx/NcmxnL6OxMEYgVtG24EubCNSJ9Zk3EnIBAC/357iZ6l3
c+WXUqT5vDa8X5g1tcPshig79GLJ+w==
=6TA6
-----END PGP SIGNATURE-----

--IfPPe3OJaALNWUjhb0nSPL8vRO6kDooZo--
