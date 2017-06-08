From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: af_can: namespace support: fix lockdep splat:
 properly initialize spin_lock
Date: Thu, 8 Jun 2017 17:23:26 +0200
Message-ID: <5cfe1936-bb3a-5f48-983d-ffbc80958d86@pengutronix.de>
References: <20170608100242.5784-1-mkl@pengutronix.de>
 <30cf02ed-e8f0-ff52-22dd-e0d20790d8a4@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NN9CaFw1amRpWEgWwqeLdwOILcbDLhxqD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46885 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751597AbdFHPXn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Jun 2017 11:23:43 -0400
In-Reply-To: <30cf02ed-e8f0-ff52-22dd-e0d20790d8a4@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NN9CaFw1amRpWEgWwqeLdwOILcbDLhxqD
Content-Type: multipart/mixed; boundary="2i4O9dpxoxtgAHDDxt6fPtg8B6x2PJaIa";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <5cfe1936-bb3a-5f48-983d-ffbc80958d86@pengutronix.de>
Subject: Re: [PATCH] can: af_can: namespace support: fix lockdep splat:
 properly initialize spin_lock
References: <20170608100242.5784-1-mkl@pengutronix.de>
 <30cf02ed-e8f0-ff52-22dd-e0d20790d8a4@hartkopp.net>
In-Reply-To: <30cf02ed-e8f0-ff52-22dd-e0d20790d8a4@hartkopp.net>

--2i4O9dpxoxtgAHDDxt6fPtg8B6x2PJaIa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/08/2017 05:20 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> On 06/08/2017 12:02 PM, Marc Kleine-Budde wrote:
>> This patch uses spin_lock_init() instead of __SPIN_LOCK_UNLOCKED() to
>> initialize the per namespace net->can.can_rcvlists_lock lock to fix th=
is
>> lockdep warning:
>>
>> | INFO: trying to register non-static key.
>> | the code is fine but needs lockdep annotation.
>> | turning off the locking correctness validator.
>> | CPU: 0 PID: 186 Comm: candump Not tainted 4.12.0-rc3+ #47
>> | Hardware name: Marvell Kirkwood (Flattened Device Tree)
>> | [<c0016644>] (unwind_backtrace) from [<c00139a8>] (show_stack+0x18/0=
x1c)
>> | [<c00139a8>] (show_stack) from [<c0058c8c>] (register_lock_class+0x1=
e4/0x55c)
>> | [<c0058c8c>] (register_lock_class) from [<c005bdfc>] (__lock_acquire=
+0x148/0x1990)
>> | [<c005bdfc>] (__lock_acquire) from [<c005deec>] (lock_acquire+0x174/=
0x210)
>> | [<c005deec>] (lock_acquire) from [<c04a6780>] (_raw_spin_lock+0x50/0=
x88)
>> | [<c04a6780>] (_raw_spin_lock) from [<bf02116c>] (can_rx_register+0x9=
4/0x15c [can])
>> | [<bf02116c>] (can_rx_register [can]) from [<bf02a868>] (raw_enable_f=
ilters+0x60/0xc0 [can_raw])
>> | [<bf02a868>] (raw_enable_filters [can_raw]) from [<bf02ac14>] (raw_e=
nable_allfilters+0x2c/0xa0 [can_raw])
>> | [<bf02ac14>] (raw_enable_allfilters [can_raw]) from [<bf02ad38>] (ra=
w_bind+0xb0/0x250 [can_raw])
>> | [<bf02ad38>] (raw_bind [can_raw]) from [<c03b5fb8>] (SyS_bind+0x70/0=
xac)
>> | [<c03b5fb8>] (SyS_bind) from [<c000f8c0>] (ret_fast_syscall+0x0/0x1c=
)
>>
>> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello Oliver,
>>
>> feel free to review this patch.
>=20
> That's definitely a better initialization.
>=20
> The change was introduced in 8e8cda6d737d which moved the static=20
> variable into the per-net data structure.
>=20
> Please CC Mario too.
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2i4O9dpxoxtgAHDDxt6fPtg8B6x2PJaIa--

--NN9CaFw1amRpWEgWwqeLdwOILcbDLhxqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlk5a+4ACgkQHv7KIOw4
HPZaKQf/VRcBebnmJDdZuB/OI1pQ0pkv6CV9I2GBvmpKvKDswlo9emThpwX5N789
WVlYhJynOJREJtXu8zxLn7gl2hWLqmVgom0Lowglua0TMtjXDOuh+7EWXgvDrSO2
AgX6xkJYHQBwTEPSIA2kxnn/M7w6fdyD4WeDVJsYebx0iOZsdYlRNP5DAmRmHhnH
QUH+an0VLC8OWWdYSWfNBwZuo6FUowbbbFseUKLXGBkeqwcj3IL2aIZske7xgB4r
fuoDnD95R6oM8dbaPQP5D3eyXdWXR/J8UoQyoDSMMBw2gSk7fDVcNxwudrw62zvm
i+C7q2+KPcDP1yrCyk4mSIlxiua22A==
=e3EU
-----END PGP SIGNATURE-----

--NN9CaFw1amRpWEgWwqeLdwOILcbDLhxqD--
