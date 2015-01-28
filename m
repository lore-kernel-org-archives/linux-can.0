From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Wed, 28 Jan 2015 14:59:01 +0100
Message-ID: <54C8EB25.8000208@pengutronix.de>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net> <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com> <54C78E4D.9060601@hartkopp.net> <54C791DA.3060708@peak-system.com> <54C7A037.6080100@hartkopp.net> <54C8E168.1040501@pengutronix.de> <54C8E811.3050806@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7X8pK2nqdkl9jm2LXmNbjIt2eHGOo2G3D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48454 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335AbbA1UQr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Jan 2015 15:16:47 -0500
In-Reply-To: <54C8E811.3050806@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7X8pK2nqdkl9jm2LXmNbjIt2eHGOo2G3D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/28/2015 02:45 PM, Stephane Grosjean wrote:
>=20
> Le 28/01/2015 14:17, Marc Kleine-Budde a =C3=A9crit :
>> On 01/27/2015 03:27 PM, Oliver Hartkopp wrote:
>>> As there is no firmware version to check against right now:
>>>
>>> In pcan_usb_fd_init() just set
>>>
>>> pdev->dev.can.ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO;
>> St=C3=A9phane, are going to add a firmware version check or should I t=
ake the
>> series as it is?
>>
>> Marc
>>
> No firmware check is supposed to be added, for the moment! Once again, =

> the ISO/non-ISO feature is always under test and AFAIK, no official=20
> delivery is planned!
>=20
> You can take the serie as it is.

done

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7X8pK2nqdkl9jm2LXmNbjIt2eHGOo2G3D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUyOslAAoJECte4hHFiupUInYQAIDdl5ZGUAATKBEWB8+PaETC
a8oTPJUhW/R9e+MsJuEH1Bqc0aKaUxp8vyOr4bQXrZtgLS88OB7Kq5jswXj4gVH5
m+DoqFQOm50eWKaBx3P+Zg/sTRfV1MweWlIF4MEy6BpY+U8V9s0qqR1bz25fNqud
O05KmxWr7LxO9Wo02OfjpfmtLidP03KkL/w/w2wIg1lxh7ABSO+zi4P0VkYblPqZ
Yy4/UKQsJl5Y+vST4SYz+p79kh9ZYSjry3IOSzoZmmwl8ChKGXHQzJ1N6eoyzdBT
uhsZx29cqPgbPIKgtjVxMH5elBg0wms0zY+OdkHIJ7VEAqPYxmsDS+qbAEoT2jD2
tgkHgG0XpclR9R3W0jR7BuphxINONUgkXZef8C26CnsdXUr2mo/MEhuBjsW2xSfb
qDGfvLiRDOAd2ITJFE85AwgvU+LkGXoSPPjrO9S849y/fQ+7kpAQAbiPB4rDypQu
ypYiiID9DFg2D5hEU4Ct7HOUomUw5Cc6C6rnANv6dtzJfR/mKktbSsmL2bYonU2r
m/u82mOltCN2vPKrqIFQPiflrkGIO6Y5lR2OHrYM+OUcXDDQeyly6XyK+Bd0B43B
v7541Dz2negz1UuNag7ad3hTquM4R1XR52hzYewq17rxlEoHWqspL3OLyqChrbHW
KhXRDY+lyzZ0kM0RqWvG
=uFnZ
-----END PGP SIGNATURE-----

--7X8pK2nqdkl9jm2LXmNbjIt2eHGOo2G3D--
