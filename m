From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix deadlock when using self wakeup
Date: Fri, 17 May 2019 19:18:43 +0200
Message-ID: <39410a95-0eb9-d266-7210-920fa5198a23@pengutronix.de>
References: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Go4NWz52i4MJ57IbARzPbBbqTrUyn2OAk"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Go4NWz52i4MJ57IbARzPbBbqTrUyn2OAk
Content-Type: multipart/mixed; boundary="Jv1LKUKsFIPlukbQg0P091Jh5uZXhkcE7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com"
 <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
Message-ID: <39410a95-0eb9-d266-7210-920fa5198a23@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix deadlock when using self wakeup
References: <20190517023652.19285-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190517023652.19285-1-qiangqing.zhang@nxp.com>

--Jv1LKUKsFIPlukbQg0P091Jh5uZXhkcE7
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 5/17/19 4:39 AM, Joakim Zhang wrote:
> As reproted by Sean Nyekjaer bellow:
> When suspending, when there is still can traffic on the
> interfaces the flexcan immediately wakes the platform again.
> As it should :-)
> But it throws this error msg:
> [ 3169.378661] PM: noirq suspend of devices failed
>=20
> On the way down to suspend the interface that throws the error
> message does call flexcan_suspend but fails to call
> flexcan_noirq_suspend.
> That means the flexcan_enter_stop_mode is called, but on the way
> out of suspend the driver only calls flexcan_resume and skips
> flexcan_noirq_resume, thus it doesn't call flexcan_exit_stop_mode.
> This leaves the flexcan in stop mode, and with the current driver
> it can't recover from this even with a soft reboot, it requires a
> hard reboot.
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
>=20
> This patch intends to fix the issue, and also add comment to explain th=
e
> wakeup flow.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

The existing self wakeup support:

| de3578c198c6 ("can: flexcan: add self wakeup support")

looks broken to me.

According to the data sheet:

> To enter stop mode, the CPU should manually assert a global Stop Mode
> request (see the CAN1_STOP_REQ and CAN2_STOP_REQ bit in the register
> IOMUXC_GPR4) and check the acknowledgement asserted by the FlexCAN
> (see the CAN1_STOP_ACK and CAN2_STOP_ACK in the register
> IOMUXC_GPR4). The CPU must only consider the FlexCAN in Stop Mode
> when both request and acknowledgement conditions are satisfied.
you have to poll for the acknowledgement, which is not done in the
driver. Please fix that first.

As far as I understand the documentation the suspend() and resume
functions should be symmetric. If they are, you shouldn't need the
in_stop_mode hack.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jv1LKUKsFIPlukbQg0P091Jh5uZXhkcE7--

--Go4NWz52i4MJ57IbARzPbBbqTrUyn2OAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlze7PMACgkQWsYho5Hk
nSDxPgf/f6dRbgpAnPasidRj//IFjHpbV5QV76Sfq0jpxJhRtmHbfdKs0z6Ww2cI
dR0YZilm0+5WSvRR58DzVO/JXep6cwbgr/vvYeSf7LFAXiF8+HIatsmf+//XygyS
YNb8CIZDvFGwcSdFqqjkyO51+QSNB/ZjoLya2TauqveMBZCuyGp7r0toZN1a0MXY
Lhcn8SXgye4sVXrePnXDuiTbirKRH4UYjXaV27Ej4iA+kCXo+bX4NxMgm7jD7nkN
lSs/xD578w/dLd7C0Fpdn38MNXNBB86TSQL1M/HEGazbzcA56gdb70+9SfpEjxsw
5lGoSwAOkFOQsHE19x2826vU2kN+mg==
=c7E1
-----END PGP SIGNATURE-----

--Go4NWz52i4MJ57IbARzPbBbqTrUyn2OAk--
