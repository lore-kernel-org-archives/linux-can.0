From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Thu, 16 Mar 2017 10:32:12 +0100
Message-ID: <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JAWBQAfpVB9DngAgFCSXubba3paW6aEOf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38121 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751214AbdCPJcV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 05:32:21 -0400
In-Reply-To: <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Efim Monjak <emonjak@lipowsky.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JAWBQAfpVB9DngAgFCSXubba3paW6aEOf
Content-Type: multipart/mixed; boundary="SsEF86xf7LBjuuExalPShP0iKT0jP5GqU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Efim Monjak <emonjak@lipowsky.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org
Message-ID: <28711d42-4fc8-4fd6-3e74-60116984885c@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <3972105.9n1vzaBFN5@ws-stein>
 <351cfe9b-231e-3c6b-5b7e-483e2b684912@pengutronix.de>
 <28df3655-1d69-2c0e-dd3a-2d70088388ff@hartkopp.net>
 <1666b5da-6ed9-a6f4-214a-d33bc0ab4aaa@pengutronix.de>
 <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>
In-Reply-To: <f0c3d9ad-5090-43ed-c584-390e9c31f7b1@lipowsky.de>

--SsEF86xf7LBjuuExalPShP0iKT0jP5GqU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 10:24 AM, Efim Monjak wrote:
>>> Would then implementing CAN rx-offload on all(!) CAN drivers fix the
>>> NAPI-too-late and the out-of-order issue?
>> Implementing rx-offload on the drivers using NAPI, will fix the
>> NAPI-too-late issue (and turn it into a IRQ too late issue).
>=20
> It seems the napi in AT91 driver is called from CAN ISR. In this case
> here are both issues.

NAPI is supposed to be activated once you get an interrupt. But the
actual read of the messages and putting it into the networking stack is
done in NAPI, which comes after the IRQ.

>> Implementing rx-offload on the drivers passing skbs in the IRQ handler=

>> will probably fix the out-of-order issue.
>=20
> Were possible by rx-offload implementing make skbs no such memory=20
> wasting for CAN data?

I'm not sure if I understand your question correctly. In CAN you need
still one skb for each CAN frame.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SsEF86xf7LBjuuExalPShP0iKT0jP5GqU--

--JAWBQAfpVB9DngAgFCSXubba3paW6aEOf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljKW5wACgkQHv7KIOw4
HPbfcwf+IWHzqU6Fc9yzQ/6pmHwu9Ox1QQLxGUeJfChc/3DqV4Vl+9GIOukDc7y2
itALv0gK5l0KTPrOdnX+hJJksH+TzJNY7kc7KN1to0cGOeY8Otr1fGAXjHnh0nLZ
T1+GZqIXYEx5ZS1qMkiDAHcPf/e0YHSgXXYvDQ34MdUV7SJEDoqfWbQ//zRQ8H43
i1N/+eHAOsoUDFQFKHU7mYo8SrVY84O7whmTEzTNk6jhWmXCfciuWMdviPtUbNVp
2sjvxydvzb5yQQpriYXozFnmuNoBJl9tIz68iMZX/vEquLIJyDtiBCKnPXWPwG6e
pVojrnMiyCZQr7JzEDrKKsNtt7FWyw==
=Ar+4
-----END PGP SIGNATURE-----

--JAWBQAfpVB9DngAgFCSXubba3paW6aEOf--
