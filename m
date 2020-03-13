From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH] bonding: do not enslave CAN devices
Date: Fri, 13 Mar 2020 10:56:10 +0100
Message-ID: <20200313095610.x3iorvdotry54vb4@pengutronix.de>
References: <d6d9368d-b468-3946-ac63-abedf6758154@hartkopp.net>
 <20200302.111249.471862054833131096.davem@davemloft.net>
 <03ff979e-a621-c9a3-9be3-13677c147f91@pengutronix.de>
 <20200306.211320.1410615421373955488.davem@davemloft.net>
 <d69b4a32-5d3e-d100-78d3-d713b97eb2ff@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iofuxgb4mu2cylw"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d69b4a32-5d3e-d100-78d3-d713b97eb2ff@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Miller <davem@davemloft.net>, socketcan@hartkopp.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com, dvyukov@google.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org


--7iofuxgb4mu2cylw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 11:25:50AM +0100, Marc Kleine-Budde wrote:
> On 3/7/20 6:13 AM, David Miller wrote:
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Date: Fri, 6 Mar 2020 15:12:48 +0100
> >=20
> >> On 3/2/20 8:12 PM, David Miller wrote:
> >>> From: Oliver Hartkopp <socketcan@hartkopp.net>
> >>> Date: Mon, 2 Mar 2020 09:45:41 +0100
> >>>
> >>>> I don't know yet whether it makes sense to have CAN bonding/team
> >>>> devices. But if so we would need some more investigation. For now
> >>>> disabling CAN interfaces for bonding/team devices seems to be
> >>>> reasonable.
> >>>
> >>> Every single interesting device that falls into a special use case
> >>> like CAN is going to be tempted to add a similar check.
> >>>
> >>> I don't want to set this precedence.
> >>>
> >>> Check that the devices you get passed are actually CAN devices, it's
> >>> easy, just compare the netdev_ops and make sure they equal the CAN
> >>> ones.
> >>
> >> Sorry, I'm not really sure how to implement this check.
> >=20
> > Like this:
> >=20
> > if (netdev->ops !=3D &can_netdev_ops)
> > 	return;
>=20
> There is no single can_netdev_ops. The netdev_ops are per CAN-network
> driver. But the ml_priv is used in the generic CAN code.

ping,

are there any other ways or ideas how to solve this issue?

Regards,
Oleksij

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7iofuxgb4mu2cylw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl5rWLYACgkQ4omh9DUa
UbM3rRAAlQmb7VoWlMTGLXbsF+xdJwyuJpRNeq/8b499jlIF0wq0u4gidS5EwlLT
ZUx/yhRQnYEvT8olNfbKOydG074ZybVRAoKWxqo2WLeTTlK93dSCsSchgGNP4tMb
eN2Q/bP0Sfeo0DhRN1G3ddYDvNCBQT+Ix3gsjAPM7UApaWwmpse2m8N3doIJJpLf
pXExGT8TDBhyCytnWvogGjjFo2/bRGGZ4niNp7dpG4Ty+HRLl0JNwPJPW+ypPwfu
zY0JK9dUqi9Jg3c79g9cCLPD/u7/9a4uFtlEZ8suGzTauhkvEBjM951rU59YZt6d
YQeAHvWf5B48n7BCa5yk/kJL+D3iAZhp4Il27w1sdzajmyZaQU3JHygssDjnk+kg
t9+Ft2SCfIuRFHwga4EOMlAngOx2hZlLw76t8MRXBckE124+/Jky3AJSPxIG1u8X
9t20xtC2s8S6LYY/oNhhWSUJQYoew9NNVYlvSpRJOK9lt4Ptcc02NhVlEVwIKmMB
lLkHLTvGgOAsfkmS39Bi5B+qzYWt5Eu9j+SOsUHnfv5dNhc71Cue2v3pk7wYsAv7
mwyEs0bAUA7cPm2fYPPwLIvZQ0SOnFBsNFxXzSOC5kByf3kIROf5AM+91Rvl5aPE
tAe/mFcFUFzCjtxbjj4uInbvPWH+uiwrRaFtI9iltnHiefxHWII=
=3Iqy
-----END PGP SIGNATURE-----

--7iofuxgb4mu2cylw--
