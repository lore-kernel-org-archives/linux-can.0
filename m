From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] pcan_usb_fd: zero out the common command buffer
Date: Thu, 8 Aug 2019 21:52:05 +0200
Message-ID: <a54e9a74-56d9-d643-746c-d68bd524c68e@pengutronix.de>
References: <20190808092825.23470-1-oneukum@suse.com>
 <20190808.110330.1163430543960132818.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UMc50YZIT55HBY87aHP7DDcDtIjFtUxI1"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190808.110330.1163430543960132818.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, oneukum@suse.com
Cc: netdev@vger.kernel.org, wg@grandegger.com, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UMc50YZIT55HBY87aHP7DDcDtIjFtUxI1
Content-Type: multipart/mixed; boundary="UjcLNn2C8cbDWlgar12cIesHnkIWP0Zdn";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>, oneukum@suse.com
Cc: netdev@vger.kernel.org, wg@grandegger.com, linux-can@vger.kernel.org
Message-ID: <a54e9a74-56d9-d643-746c-d68bd524c68e@pengutronix.de>
Subject: Re: [PATCH] pcan_usb_fd: zero out the common command buffer
References: <20190808092825.23470-1-oneukum@suse.com>
 <20190808.110330.1163430543960132818.davem@davemloft.net>
In-Reply-To: <20190808.110330.1163430543960132818.davem@davemloft.net>

--UjcLNn2C8cbDWlgar12cIesHnkIWP0Zdn
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/8/19 8:03 PM, David Miller wrote:
> From: Oliver Neukum <oneukum@suse.com>
> Date: Thu,  8 Aug 2019 11:28:25 +0200
>=20
>> Lest we leak kernel memory to a device we better zero out buffers.
>>
>> Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>=20
> Please CC: the CAN subsystem maintainers, as this is clearly listed in =
the
> MAINTAINERS file.

The issue is already fixed and already mainline (stable@v.k.o is on Cc):

30a8beeb3042 can: peak_usb: pcan_usb_fd: Fix info-leaks to USB devices

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UjcLNn2C8cbDWlgar12cIesHnkIWP0Zdn--

--UMc50YZIT55HBY87aHP7DDcDtIjFtUxI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1MfWUACgkQWsYho5Hk
nSBwrwf/RKjvw+UBYG5dyLsSKeWQPRowAaiVipNU/nmK9qSaRy62QrSx9K93F7Sa
CKiB/LNRuubgzdwPF+4Wb9zKZ4X9m9llNdlX+4EkJVSuRofubuff/N1cagL4ZnRj
dtunLcUCZc9cENeLaow5JQmTCM+eiXhtGXRtQQz4Naj1nMj5g0ZE6O/Rf/NH3cMW
vTX35XzrKuOaOa+lxBftB0ORZpLEhgbINKwcEDFmv2LZDt1zFGsST6t1oNivojB8
6YvQl6hepi9+q5dVag1eBAKC9DviWo8N9pk3LFElQkGZ8/FfKZGhpAZLrZRTZESO
R+gahlYAQj0TybuLor0Y7rchJeRooA==
=XaAn
-----END PGP SIGNATURE-----

--UMc50YZIT55HBY87aHP7DDcDtIjFtUxI1--
