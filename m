From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 15:37:14 +0100
Message-ID: <50C0AD9A.1070609@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCA8048770D7CD358E38B9F4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280Ab2LFOhS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:37:18 -0500
In-Reply-To: <50C0AC38.8080405@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCA8048770D7CD358E38B9F4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 03:31 PM, Wolfgang Grandegger wrote:
>> =20
>>  static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
>>                                       enum reg index, u16 val)
>>  {
>> -       iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
>> +       u16 reg;
>> +       unsigned long flags;
>> +       int retries;
>> +
>> +       retries =3D 0;
>> +
>> +       spin_lock_irqsave(&priv->testlock, flags);
>> +
>> +       do
>> +       {
>> +               iowrite32((u32)val, priv->base + 2 * priv->regs[index]=
);
>=20
> I think it's enough to write the message once.

It's a different test, but also very interesting.

>=20
>> +               reg =3D (u16)ioread32(priv->base + 2 * priv->regs[inde=
x]);
>> +               if (reg !=3D val)
>> +               {
>> +                       netdev_err(priv->dev, "write 0x%x to offset 0x=
%x failed. got: 0x%x\n", val, 2 * priv->regs[index], reg);
>> +               }
>> +       } while ((reg !=3D val) && (retries++ < 20));
>> +       spin_unlock_irqrestore(&priv->testlock, flags);
>>  }
>> =20
>>  static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool e=
nable)>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCCA8048770D7CD358E38B9F4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDArZoACgkQjTAFq1RaXHNGpgCfQmpMIrgRZmiLwMZ04j65WP2K
SDwAn0l7ypVTNC+wjEaQHHhlLS57qB1T
=L52j
-----END PGP SIGNATURE-----

--------------enigCCA8048770D7CD358E38B9F4--
