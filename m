From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Thu, 09 Oct 2014 18:13:55 +0200
Message-ID: <5436B443.10606@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de> <53E9E614.7060303@pengutronix.de> <542BACC0.4050707@ep1.ruhr-uni-bochum.de> <542BB21B.4030200@pengutronix.de> <542BF456.3030201@ep1.ruhr-uni-bochum.de> <542BF687.1000800@pengutronix.de> <5436A482.4040001@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="j4UoW6HgEqAsNoRV8FdV2cnFKAxhxpDsn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38155 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbaJIQOC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Oct 2014 12:14:02 -0400
In-Reply-To: <5436A482.4040001@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j4UoW6HgEqAsNoRV8FdV2cnFKAxhxpDsn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Florian,

please don't top-post.

On 10/09/2014 05:06 PM, Florian Feldbauer wrote:
> I now checked everything with a mixed signal scope and
> one thing came to my eye:
>=20
> After loading the module, I get the error:
> [   16.806860] sja1000_raspi sja1000_raspi.0: registering sja1000_raspi=

> device (reg_base=3D0xf2200000, irq=3D174)
> [   16.836560] sja1000_raspi sja1000_raspi.0 (unregistered net_device):=

> setting SJA1000 into reset mode failed!
> [   16.871684] sja1000_raspi sja1000_raspi.0: sja1000_raspi device
> registered (reg_base=3D0xf2200000, irq=3D174)
>=20
> Although I can see at the scope, that reading register 0 of the SJA1000=

> returns the value 1 as it should be.
> Also, it seems that there is some kind of endless loop reading this
> register.

No, just a loop of up to 100 :)

> static void set_reset_mode(struct net_device *dev)                     =
         =20
> {                                                                      =
         =20
>         struct sja1000_priv *priv =3D netdev_priv(dev);                =
           =20
>         unsigned char status =3D priv->read_reg(priv, SJA1000_MOD);    =
           =20
>         int i;                                                         =
         =20
>                                                                        =
         =20
>         /* disable interrupts */                                       =
         =20
>         priv->write_reg(priv, SJA1000_IER, IRQ_OFF);                   =
         =20
>                                                                        =
         =20
>         for (i =3D 0; i < 100; i++) {                                  =
           =20
>                 /* check reset bit */                                  =
         =20
>                 if (status & MOD_RM) {                                 =
         =20
>                         priv->can.state =3D CAN_STATE_STOPPED;         =
           =20
>                         return;                                        =
         =20
>                 }                                                      =
         =20
>                                                                        =
         =20
>                 /* reset chip */                                       =
         =20
>                 priv->write_reg(priv, SJA1000_MOD, MOD_RM);            =
         =20
>                 udelay(10);                                            =
         =20
>                 status =3D priv->read_reg(priv, SJA1000_MOD);          =
           =20
>         }                                                              =
         =20
>                                                                        =
         =20
>         netdev_err(dev, "setting SJA1000 into reset mode failed!\n");  =
         =20
> }                                                     =20

Instrument this code to see what's going on.

> Now, what I don't understand at all:
> Removing the module and loading it again works.
> I don't get the error that setting the SJA1000 into reset mode failed,
> the register is only read once after loading the module,
> and sending/reading CAN frames from the bus after setting a proper
> bitrate works too....

Maybe the delay is to small for your big banging io interface.

> Any Ideas why the first initialization of the kernel module doesn't wor=
k?
> When is the probe function of the module actually called?

As soon as there is a matching driver//device combination on a bus.
Looking at your driver, it's racy. You should not do any hardware setup
in the init function.

> A completely other question: I wanted to use libsocketcan to check the
> state of the interface,
> bringing it up in case it's down, within my C/C++ Program.
> Is there a way to use this lib as a normal user? Maybe some group the
> user has to be in?

IIRC your process needs NET_ADMIN capabilities (CAP_NET_ADMIN). I
personally never used capabilities, but there are libcap and libcap-ng
(https://people.redhat.com/sgrubb/libcap-ng/), which might help.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--j4UoW6HgEqAsNoRV8FdV2cnFKAxhxpDsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ2tEMACgkQjTAFq1RaXHNq4gCdEBqzqVmKOntYJGjdTlLa2wjd
GWAAn3nlu3K+PmoAacAr2zJ9DhqePaY2
=2UhY
-----END PGP SIGNATURE-----

--j4UoW6HgEqAsNoRV8FdV2cnFKAxhxpDsn--
