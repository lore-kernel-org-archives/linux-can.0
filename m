From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/5] prepare for release + add more clocks to can-calc-bit-timing
Date: Mon, 26 Nov 2012 21:58:41 +0100
Message-ID: <50B3D801.5020508@pengutronix.de>
References: <1353962689-18669-1-git-send-email-mkl@pengutronix.de> <50B3D700.7040606@hartkopp.net> <50B3D769.3090703@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig533366108704F42E22C0653D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37985 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab2KZU6o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 15:58:44 -0500
In-Reply-To: <50B3D769.3090703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, ulrich.escher@myvdr.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig533366108704F42E22C0653D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 09:56 PM, Marc Kleine-Budde wrote:
> On 11/26/2012 09:54 PM, Oliver Hartkopp wrote:
>> On 26.11.2012 21:44, Marc Kleine-Budde wrote:
>>
>>> this patch series prepares configure.ac for a release (adjusting bug =
report
>>> address  + enabling silent rules in autoools). Then some more refcloc=
ks for
>>> flexcan and mscan are added and support for ti_hecc to can-calc-bit-t=
iming.
>>
>>
>> Hello Marc,
>>
>> that's fine to me.
>>
>> I also pushed the slcanpty fix from Ulrich with an appropriate commit =
message.
> I'll add your Acked-by then
done

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig533366108704F42E22C0653D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCz2AEACgkQjTAFq1RaXHODWwCfUUB4AKfatpq/8PyizBtOBiqa
sy8AnA56gwMLC+oBDnXzL7DfAnijCKhM
=c4YQ
-----END PGP SIGNATURE-----

--------------enig533366108704F42E22C0653D--
