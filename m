From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 20:11:30 +0200
Message-ID: <5342EA52.6080904@pengutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <8704553.bJQG1oassy@ws-stein> <alpine.DEB.2.02.1404071524550.14882@ionos.tec.linutronix.de> <1589068.2zsYHU9sGb@ws-stein> <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Jx7bT3pnuV0B8Vbpm2M43ww6dRmpgP23p"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38142 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbaDGSLo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 14:11:44 -0400
In-Reply-To: <alpine.DEB.2.02.1404071659360.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jx7bT3pnuV0B8Vbpm2M43ww6dRmpgP23p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/07/2014 05:24 PM, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
>> On Monday 07 April 2014 15:31:20, Thomas Gleixner wrote:
>>> What other patches do you have applied?
>>
>> I have shrinked them a bit to the absolute necessity. In general
>> these are patches for the current hardware to make them working.
>=20
>> 53b385c37e4eb155cf9d515913ddf76750e2ac24 c_can: Add support for eg20t =
(pch_can)
>=20
> I can't see anything whats wrong with that one.
>=20
> Can you check, whether the following check in c_can_read_objects()
>=20
>                if (!(ctrl & IF_MCONT_NEWDAT))
>                         continue;

On TI's D_CAN with all your patches applied and the split buffer
approach active, I haven't this trigger in a ~4h test run. Athough there
are regularly missing frames, apart from this, they are in the correct
order.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jx7bT3pnuV0B8Vbpm2M43ww6dRmpgP23p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNC6lIACgkQjTAFq1RaXHOp+gCdH/jr7K069BaDX3YhgwPPE8Ni
6UEAnRI2w5kxt87ZAoIDSWLNM6inA9Vl
=ll06
-----END PGP SIGNATURE-----

--Jx7bT3pnuV0B8Vbpm2M43ww6dRmpgP23p--
