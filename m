From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [jtkirshe-net-next:core-queue 1002/1025] drivers/net/can/usb/kvaser_usb.c:639:
 warning: comparison is always false due to limited range of data type
Date: Fri, 30 Jan 2015 09:04:47 +0100
Message-ID: <54CB3B1F.6010406@pengutronix.de>
References: <201501301018.HN7rQ3rB%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0VvAlViAvQdIgBNCiiUoTX89FSINFHbkD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51138 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999AbbA3IFE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Jan 2015 03:05:04 -0500
In-Reply-To: <201501301018.HN7rQ3rB%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0VvAlViAvQdIgBNCiiUoTX89FSINFHbkD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ahmed S. Darwish Cc'ed

On 01/30/2015 03:53 AM, kbuild test robot wrote:
> tree:   jtkirshe-net-next/core-queue
> head:   c265eda3429432b5e9e53c8082861ffbd2ffd2c2
> commit: 96d7f10634e66b27e23854c774fbcc0a2a654e82 [1002/1025] can: kvase=
r_usb: Consolidate and unify state change handling
> config: avr32-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/p=
lain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 96d7f10634e66b27e23854c774fbcc0a2a654e82
>   # save the attached .config to linux build tree
>   make.cross ARCH=3Davr32=20
>=20
> All warnings:
>=20
>    drivers/net/can/usb/kvaser_usb.c: In function 'kvaser_usb_rx_error_u=
pdate_can_state':
>>> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always f=
alse due to limited range of data type
>>> drivers/net/can/usb/kvaser_usb.c:639: warning: comparison is always f=
alse due to limited range of data type
>=20
> vim +639 drivers/net/can/usb/kvaser_usb.c
>=20
>    623							 const struct kvaser_usb_error_summary *es,
>    624							 struct can_frame *cf)
>    625	{
>    626		struct net_device_stats *stats;
>    627		enum can_state cur_state, new_state, tx_state, rx_state;
>    628=09
>    629		netdev_dbg(priv->netdev, "Error status: 0x%02x\n", es->status);=

>    630=09
>    631		stats =3D &priv->netdev->stats;
>    632		new_state =3D cur_state =3D priv->can.state;
>    633=09
>    634		if (es->status & (M16C_STATE_BUS_OFF | M16C_STATE_BUS_RESET))
>    635			new_state =3D CAN_STATE_BUS_OFF;
>    636		else if (es->status & M16C_STATE_BUS_PASSIVE)
>    637			new_state =3D CAN_STATE_ERROR_PASSIVE;
>    638		else if (es->status & M16C_STATE_BUS_ERROR) {
>  > 639			if ((es->txerr >=3D 256) || (es->rxerr >=3D 256))
>    640				new_state =3D CAN_STATE_BUS_OFF;
>    641			else if ((es->txerr >=3D 128) || (es->rxerr >=3D 128))
>    642				new_state =3D CAN_STATE_ERROR_PASSIVE;
>    643			else if ((es->txerr >=3D 96) || (es->rxerr >=3D 96))
>    644				new_state =3D CAN_STATE_ERROR_WARNING;
>    645			else if (cur_state > CAN_STATE_ERROR_ACTIVE)
>    646				new_state =3D CAN_STATE_ERROR_ACTIVE;
>    647		}
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corpo=
ration
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0VvAlViAvQdIgBNCiiUoTX89FSINFHbkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUyzskAAoJECte4hHFiupU8YoQAJEObWGa1eYZyHSDTopnY5TJ
seoZhfSawPru2XXwXMVwsx0l0X4CWNkRv3njIKbIECvDPMBdN87PRNKpPWnnhJwf
Vg3jfpiYiTkUeE+/Lf2PTHOWwcDGEHRD3brd8kFE5CCwbbA8QlMQx/JPsExdRDT7
VPQguo57WNEn2NQbxWY9tpUuMys8ZN/I1Of3hHCqroHGwKALpZECNTZh3yumtSWs
mZoLepW55krptri3n4CEXOh4XYIWkEVYBsYulpcl8GOxKDYwsZBNlr9iQvrHiHwh
H1E5o9CKFDjkSPY9xGQ+wOMdS4aif4y5YrwkvVbm8fPrPe0YIlRhH8h0AEQOcFOu
xnzHF+pDQFjFjSiOc7JpFfP79IAVrCo8wlpzK9DRsqiVNh7WHJMgbd8QBFXhli4t
5GOwSpnsucykxbb98u1rZMRhiywFlQuQ7xGBBTjzpKYmJ6vmcVX2nPB/I7fIBphP
/KoPpQp31O0c7UCX7Y//FdUjCBzVo5rhiCjW+twY9+jdkcGnh5GdaRcQUMOi3Qgz
sgFbckin6B6bo0IhYScnsovXjoJ38tv10SsgxfIzaATgfI5pZLJKvUZK2TJIiyOt
/cWuFxwaU78llFcMvW7eD4oFCLAj/1/IWv8K4Ss40grYpT+r9CS1XLXNRWc8SgWa
PLrLOOMCWyiLSERW9Ats
=3pRP
-----END PGP SIGNATURE-----

--0VvAlViAvQdIgBNCiiUoTX89FSINFHbkD--
