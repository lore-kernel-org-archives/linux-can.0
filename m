From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can 2018-01-04
Date: Sun, 7 Jan 2018 13:32:21 +0100
Message-ID: <a3b0d7d8-e5df-5b88-87d7-1c73c60dbc37@pengutronix.de>
References: <20180104153355.11243-1-mkl@pengutronix.de>
 <20180105.134839.941290778276014203.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bHjmXybWlLBqzEOPCCE4uu6DT8kcg9F0C"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180105.134839.941290778276014203.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bHjmXybWlLBqzEOPCCE4uu6DT8kcg9F0C
Content-Type: multipart/mixed; boundary="bUoQXH8Igpv3HIWM2h1uZVHlt35DOf5qL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
Message-ID: <a3b0d7d8-e5df-5b88-87d7-1c73c60dbc37@pengutronix.de>
Subject: Re: pull-request: can 2018-01-04
References: <20180104153355.11243-1-mkl@pengutronix.de>
 <20180105.134839.941290778276014203.davem@davemloft.net>
In-Reply-To: <20180105.134839.941290778276014203.davem@davemloft.net>

--bUoQXH8Igpv3HIWM2h1uZVHlt35DOf5qL
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 07:48 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Thu,  4 Jan 2018 16:33:51 +0100
>=20
>> this is a pull request for net/master consisting of 4 patches.
>>
>> The first patch is by Oliver Hartkopp, it improves the error checking
>> during the creation of a vxcan link. Wolfgang Grandegger's patch for t=
he
>> gs_usb driver fixes the return value of the "set_bittiming" callback.
>> Luu An Phu provides a patch for the flexcan driver to fix the frame
>> length check in the flexcan_start_xmit() function. The last patch is b=
y
>> Martin Lederhilger for the ems_usb driver and improves the error
>> reporting for error warning and passive frames.
>  ...
>>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can=
=2Egit tags/linux-can-fixes-for-4.15-20180104
>=20
> I think you meant:
>=20
> 	git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/l=
inux-can-fixes-for-4.15-20180104

No, that was intentional.

> Otherwise can I please have all of your private SSH keys? :-)

As long as you have your SSH keys, you have read only access to my (and
the git repos of the other kernel developers) on git.kernel.org. I'm
already fetching from net and net-next via ssh:

> $ git fetch net =20
> remote: Counting objects: 70, done.
> remote: Compressing objects: 100% (70/70), done.
> remote: Total 70 (delta 59), reused 0 (delta 0)
> Unpacking objects: 100% (70/70), done.
> From ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/davem/net
>    6926e041a892..5133550296d4  master     -> net/master

See Konstantin Ryabitsev's mail "[kernel.org users] Forcing git to
always use gitolite.kernel.org" for more details.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bUoQXH8Igpv3HIWM2h1uZVHlt35DOf5qL--

--bHjmXybWlLBqzEOPCCE4uu6DT8kcg9F0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpSE1UACgkQHv7KIOw4
HPYQ9Qf/Zl8x6DtzYD6fxw4RSKDfnjZ4VV/1uvZOcDHrl1DrEfToOgyAts/bkgvc
4+LNzOmSuwqV/erXxzCtm+8r3Ejoc5GiXmhyQLde2nXGAydiInQRJwZ9jM3S1R56
hFrtEjq5A7FHM+6taOM/WNOtxIcBRfw8K/TkgtlU22DRJNfPVgLwc1Irb6EjrwyZ
OjQM6oax8KpMcz874qyd2JzSzXRA/QcSImltuRBgGGNQXrUoZPEEg/ni82Knlj+M
CXSXSuEBzUVqOdnl1lmTkbigIijF0puVAMF/RWr55zJCC693kalUyA2xgYUuhPtG
LNnk7scT66HaEVmJ+21ri1zGMamYcA==
=n9qi
-----END PGP SIGNATURE-----

--bHjmXybWlLBqzEOPCCE4uu6DT8kcg9F0C--
