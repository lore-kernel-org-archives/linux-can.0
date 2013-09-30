From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 01/21] drivers: remove unnecessary prom.h includes
Date: Mon, 30 Sep 2013 15:23:22 +0200
Message-ID: <52497B4A.2020409@pengutronix.de>
References: <1380221456-11192-1-git-send-email-robherring2@gmail.com> <1380221456-11192-2-git-send-email-robherring2@gmail.com> <52492E4F.2020701@pengutronix.de> <52497A6E.5010908@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7V7bqdqEoSOLFc2OvX8r5N8QO3a5281aj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50886 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab3I3NXf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 09:23:35 -0400
In-Reply-To: <52497A6E.5010908@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7V7bqdqEoSOLFc2OvX8r5N8QO3a5281aj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2013 03:19 PM, Rob Herring wrote:
> On 09/30/2013 02:54 AM, Marc Kleine-Budde wrote:
>> On 09/26/2013 08:50 PM, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Remove unnecessary prom.h includes in preparation to remove implicit
>>> includes of prom.h.
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: linux-can@vger.kernel.org
>>> Cc: netdev@vger.kernel.org
>>
>> Applied to linux-can-next/testing, it will be included in my next pull=

>> request to David Miller.
>=20
> Please don't apply this. The whole series needs to be applied together.=

> This patch is a dependency for the rest of the series.

Okay, then add my Acked-by to this patch.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7V7bqdqEoSOLFc2OvX8r5N8QO3a5281aj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJJe0oACgkQjTAFq1RaXHN9pwCfVsN6WRkRPfEbHYiqSYOYWZ8O
CD4An03DCJm2LZtQwWmB4BQkTodid83l
=S39I
-----END PGP SIGNATURE-----

--7V7bqdqEoSOLFc2OvX8r5N8QO3a5281aj--
