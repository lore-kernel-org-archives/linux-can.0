From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: =?UTF-8?Q?API_to_support_hardware_priorities_=28was:_Re:_API_zur_ha?=
 =?UTF-8?Q?rdwareunterst=c3=bctzten_Priorisierung_von_CAN-Paketen=29?=
Date: Mon, 9 Nov 2015 14:32:21 +0100
Message-ID: <5640A065.2000401@pengutronix.de>
References: <20151109123618.41ad1bae@mitra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NNdj6ABkFK9irtqn1sWSI3xWrxjjFxgX7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbbKINc2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 08:32:28 -0500
In-Reply-To: <20151109123618.41ad1bae@mitra>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Benedikt Spranger <b.spranger@linutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NNdj6ABkFK9irtqn1sWSI3xWrxjjFxgX7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Let's move this discussion to the mailing list. I'll translate your
questions.

On 11/09/2015 12:36 PM, Benedikt Spranger wrote:
> C-CAN und D-CAN basierte Hardware (wie auch andere) unterst=C3=BCtzt ja=
 das
> priorisierende Versenden von CAN-Paketen. Gibt es Bestrebungen, dieses
> Feature in der API abzubilden?

Several CAN IP cores support prioritisation of CAN frames. Is it planned
to support this?

> Im konkreten Fall werden neben Bulk-Daten azyklisch auch zeitkritische
> CAN-Pakete versendet. Hierbei ist eine FIFO-Abarbeitung st=C3=B6rend. D=
as
> Mailbox-basierte Design von C-CAN/D-CAN unterst=C3=BCtzt ja neben der
> Verwendung der Mailboxen als FIFO auch die dedizierte Konfiguration auf=

> eine CAN-Id/Maske.

Bene want to send bulk data and time critical cyclic data. Using a
hardware FIFO introduces unwanted latencies. He further mentions that
it's possible to configure the mailboxes to serve a CAN-ID/mask.

Hope I've got the gist of your mail, correct me if needed. :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NNdj6ABkFK9irtqn1sWSI3xWrxjjFxgX7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWQKBlAAoJEP5prqPJtc/HxSIIAKGjCRB8EwgmnjHWxdPg9PdC
QKEOfzpxJ7tlOThamQ4B/TPZ9C0D//kO4/kPaaEgjnyqrkmgznmZTuJE3hGR36Nn
FGiIGf8jbnNqigwQHNhsBkdk75nFCZVq7/QV6VYVF3uqoYUKDJBJj0ykrleByBBO
6WKoil3NL4pI23662PC0RbS6rGku/oK6hmWCszJKX3TYYPEnD+sDp0Nb0GD+gStj
JIVO3NXzWYbMhs+VKzTGyEtgfxgHICUSpgeNhz9HgIrXa5t2p1cdYvt68TG3tlu7
rEdq5KJEP9DS6HUEUe7S3ZB2EHBtZcIFW45bvZF6ZMHaMibwl2hfjpM+ZpDrXxg=
=xgdO
-----END PGP SIGNATURE-----

--NNdj6ABkFK9irtqn1sWSI3xWrxjjFxgX7--
