From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mcp251x can't drop the can0 Interface
Date: Sat, 08 Feb 2014 18:10:29 +0100
Message-ID: <52F66505.6090303@pengutronix.de>
References: <20140207201236.GB28637@griso.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e0M9nKKdDjSIdlQbNkCwmwthpFfaPc0QA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbaBHRKf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Feb 2014 12:10:35 -0500
In-Reply-To: <20140207201236.GB28637@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e0M9nKKdDjSIdlQbNkCwmwthpFfaPc0QA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/07/2014 09:12 PM, John Whitmore wrote:
> I guess you might say that I'm playing with an MCP2515 connected to a
> RaspberryPi. I've got a problem which I've asked about on the Raspberry=
Pi
> forum but have never received an answer, so as a last resort I thought =
I'd try
> here.
>=20
> Basically I bring up the MCP2515 in listen mode at a certain baud rate.=
 I
> wanted to work on auto detetection of baud rate. So after listening for=
 a
> period of time at a certain baud rate I try to change the baud rate but=
 I
> can't do that with the linux mcp251x driver (I don't think it's the dri=
ver's
> fault but have no idea whose it is). I've put in some debug statements
> to see what happens when I execute "ifconfig can0 down" and basically t=
he
> interface goes down momentarily and then gets brough straight back up
> again. So when I try to use the "ip" command to set the new baud rate I=
 get an
> error that the device is busy.=20

Please add this patch to the driver:

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----
diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index cdb9808..b1ea15c 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -697,6 +697,8 @@ static int mcp251x_stop(struct net_device *net)
        struct mcp251x_priv *priv =3D netdev_priv(net);
        struct spi_device *spi =3D priv->spi;

+       dump_stack();
+
        close_candev(net);

        priv->force_quit =3D 1;
@@ -941,6 +943,8 @@ static int mcp251x_open(struct net_device *net)
        unsigned long flags =3D IRQF_ONESHOT | IRQF_TRIGGER_FALLING;
        int ret;

+       dump_stack();
+
        ret =3D open_candev(net);
        if (ret) {
                dev_err(&spi->dev, "unable to set initial baudrate!\n");

-------->8-------->8-------->8-------->8-------->8-------->8-------->8---=
-----

Then reproduce your problem, then send dmesg output.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--e0M9nKKdDjSIdlQbNkCwmwthpFfaPc0QA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL2ZQUACgkQjTAFq1RaXHOCTQCeJkJ4Lef2tTUFVLRJRijaZtf/
VnkAn2LQnGpCu0Wbk3WYhtppJorukpHG
=PpHr
-----END PGP SIGNATURE-----

--e0M9nKKdDjSIdlQbNkCwmwthpFfaPc0QA--
