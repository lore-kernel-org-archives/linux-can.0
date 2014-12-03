From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 14:19:12 +0100
Message-ID: <547F0DD0.4050304@pengutronix.de>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com> <547EE315.40703@hartkopp.net> <547EE827.2080004@peak-system.com> <547EE9CA.8070608@pengutronix.de> <547EEAFA.6050203@hartkopp.net> <547EF1EE.4050409@peak-system.com> <547EF933.5060802@hartkopp.net> <547F033A.4050109@peak-system.com> <547F08BF.5060307@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="59MbG5Uru0QEQmlGquuV8sJTDF856sm7g"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51568 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaLCNTS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 08:19:18 -0500
In-Reply-To: <547F08BF.5060307@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--59MbG5Uru0QEQmlGquuV8sJTDF856sm7g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2014 01:57 PM, Oliver Hartkopp wrote:
> Then I would suggest to stay in the layout of the current patch set
> (with pcan_ucan.h in drivers/usb/peak_usb) and discuss about a generic
> approach when some other ucan-based devices (e.g. pci) appear ...

+1
Sounds good. Keep it simple first.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--59MbG5Uru0QEQmlGquuV8sJTDF856sm7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfw3QAAoJECte4hHFiupU774P/2CjaBaO6+SkwtbsdGE0Kee1
ZV1TaxKprodd21EwAglayh7C6fx5MCxXEWwcmaMPicZQOXOxvhVdUBLmrFmER2GO
pkBqQQXtCN9eXuJDqNlIrwq9tIcwFTb0N0eNEUfAYH/eq6TqT/zsdzKyb/CeY6Ti
/Z9DcHDgY0XE1gwfziRLgBRKk72qixZdS0jhi1b7oYbg7ATeOMYFNoyFbIB84mY7
c62gGGFUSTFPBZztA7FVvOSoYTIKBXi2UyGafCUU+Eo9cclN8U5dYXOgh+LwQwVa
f+8GhivlEa776aNg522BcDTN5OfVR2LBxUzxAUYhwJhl27vPIGeqYZkONlp2kX6m
FKcG3kZq05SUNOnf4di2TLCRcltpcLVDChD2B7DcLjq1BBSfAKqauqqX5fnVKSXB
WVBTw5jOHO6Gx8XxCC4ae0Dkb8Z3/HVyWkVOTOOHvZWNaW76ij9uBbodozvEOg54
thjXGlTQS/I6k4Qf74Stjwgvr4ck6/EBVCESpaut9QwSsNPwkkaDnXfBtBqug2gS
5I0zbM2/laGBO2DSm8zhke9a/MYeVTmpG0YrvFYl97h0m+A2ML9aFzg1gjcDcaWx
g7HOtKR2XEPcq4k0uSOyD6dX90i+xgOXm/fu2/ZDubb/LQQydZYRlUnV0mICaOAo
8JpL1LTK1Lubtd2ypVBF
=yGM2
-----END PGP SIGNATURE-----

--59MbG5Uru0QEQmlGquuV8sJTDF856sm7g--
