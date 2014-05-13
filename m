From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCHv3] C_CAN: hwinit support for non-TI devices
Date: Tue, 13 May 2014 17:18:57 +0200
Message-ID: <537237E1.4000505@pengutronix.de>
References: <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com> <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com> <20140430215359.GA15148@amd.pavel.ucw.cz> <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com> <20140502084851.GA5730@amd.pavel.ucw.cz> <20140505120801.GA16461@amd.pavel.ucw.cz> <20140506135702.GA9879@amd.pavel.ucw.cz> <5370ED11.4000002@pengutronix.de> <20140513130914.GA9806@amd.pavel.ucw.cz> <53721FD5.50508@pengutronix.de> <20140513150857.GA11608@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k8HcmQjj4rdhLovrp6H6JF23caM4gMsQP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52062 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbaEMPTI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 11:19:08 -0400
In-Reply-To: <20140513150857.GA11608@amd.pavel.ucw.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: Thor Thayer <tthayer.linux@gmail.com>, Thor Thayer <tthayer@altera.com>, Dinh Nguyen <dinguyen@altera.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org, socketcan@hartkopp.net, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k8HcmQjj4rdhLovrp6H6JF23caM4gMsQP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/13/2014 05:08 PM, Pavel Machek wrote:
> Hi!
>=20
>=20
> On Tue 2014-05-13 15:36:21, Marc Kleine-Budde wrote:
>> On 05/13/2014 03:09 PM, Pavel Machek wrote:
>>> Non-TI chips (including socfpga) needs different raminit
>>> sequence. Implement it.
>>>
>>> const's in the hwinit prototype forced me to add const to more
>>> prototypes. This makes changes bigger but the result is cleaner.
>>
>> Why not split into several patches?
>>
>>> Unfortunately, testing-c_can does not boot on sockit, but previous
>>> version of patch was tested by me and Thor Thayer.
>>
>> Have a look at:
>>
>>     git@gitorious.org:linux-can/linux-can-next.git
>> testing-c_can-based-on-net
>=20
> git fetch git@gitorious.org:linux-can/linux-can-next.git
> testing-c_can-based-on-net:testing-c_can-based-on-net
> The authenticity of host 'gitorious.org (87.238.52.168)' can't be
> established.
> RSA key fingerprint is
> 7e:af:8d:ec:f0:39:5e:ba:52:16:ce:19:fa:d4:b8:7d.
>=20
> But I was able to
>=20
> git fetch git://gitorious.org/linux-can/linux-can-next.git
> testing-c_can-based-on-net:testing-c_can-based-on-net=20

Sorry, I copied the wrong URL.

>> This branch uses net/master as it's base, I've split your patch into 3=
,
>> and squashed the 32bit-const changes into the 32-bit access patch. The=

>> remaining patch looks quite clean.
>=20
> Thanks a lot!
>=20
>> Can you please test the branch, I hope it boots on sockit.
>=20
> That one still dies early in boot, but I was able to apply some
> changes from my main tree (not CAN related) and get it to boot.

\o/

> And yes, it seems to work:
>=20
> [It still does not contain some "interesting" changes from altera
> tree, but as I could not get explanation why they are needed -- and
> they don't seem to be needed -- maybe it is better that way.]

Are there changes to the CAN driver or the SoC infrastructure?

> root@sockit:~# uname -a
> Linux sockit 3.15.0-rc4-00470-g4477be8-dirty #99 SMP Tue May 13
> 17:02:02 CEST 2014 armv7l GNU/Linux
> root@sockit:~# ip link set can0 up type can bitrate 125000 loopback on
> c_can_platform ffc00000.d_can can0: setting BTR=3D1c31 BRPE=3D0000
> root@sockit:~# ifconfig can0 up
> root@sockit:~# candump can0 &
> root@sockit:~# cansend can0 "123#DEADBEEF"
>   can0  123   [4]  DE AD BE EF
>   can0  123   [4]  DE AD BE EF
> root@sockit:~# cansend can0 "123#DEADBEEF"
>   can0  123   [4]  DE AD BE EF
>   can0  123   [4]  DE AD BE EF

\o/

Thanks for testing.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--k8HcmQjj4rdhLovrp6H6JF23caM4gMsQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNyN+EACgkQjTAFq1RaXHMg9QCeOfowh5EA0ctgZBMI9Rs8jnIm
kdYAn2Czy3++S6qS1aHhyIuqPS+eOoto
=LJqB
-----END PGP SIGNATURE-----

--k8HcmQjj4rdhLovrp6H6JF23caM4gMsQP--
