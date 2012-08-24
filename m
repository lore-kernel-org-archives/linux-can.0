From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v6] can: add tx/rx LED trigger support
Date: Fri, 24 Aug 2012 13:28:16 +0200
Message-ID: <50376550.4020501@pengutronix.de>
References: <50191EA5.1040303@pengutronix.de> <1343845298-2065-1-git-send-email-fabio.baltieri@gmail.com> <20120824051016.GB1718@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig00580F959376127700432EB7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49468 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2HXL2Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Aug 2012 07:28:25 -0400
In-Reply-To: <20120824051016.GB1718@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00580F959376127700432EB7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2012 07:10 AM, Kurt Van Dijck wrote:
> Hello,
>=20
> I find the CAN led triggers an interesting thing.
>=20
> And then, this scenario fell crossed my mind:
> Imagine I do:
> [insert CAN device: can0]
> $ ip link set can0 name helga
> [insert another CAN device: again 'can0']
>=20
> Registering 'can0-tx' led trigger will fail for the second CAN device,
> since that led trigger name is already reserved for CAN device 'helga'.=


Good point.

> I'm not sure how to fix such.
> If 'rx' & 'tx' may be combined, reusing the netdev name may be possible=
?
> Just wild thinking ...

I think the device's name (not netdev) is unique in the system and
cannot be changed.

On my device tree enabled mx28 I'm talking about the "80032000.can" in:

> dmesg |grep flexcan
> flexcan 80032000.can: device registered (reg_base=3Df5032000, irq=3D8)
> flexcan 80034000.can: device registered (reg_base=3Df5034000, irq=3D9)

> $ ls /sys/bus/platform/devices/*can* -d
> /sys/bus/platform/devices/80032000.can
> /sys/bus/platform/devices/80034000.can

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig00580F959376127700432EB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlA3ZVQACgkQjTAFq1RaXHPn2QCfVli8vdZlQYkFUj1pYHIFApu/
E3cAn0uD+4U/IBwv81M5QwanGlmJ6T4Q
=gUEp
-----END PGP SIGNATURE-----

--------------enig00580F959376127700432EB7--
