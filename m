From: =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>
Subject: Re: MCAN Registers Discrepancy
Date: Thu, 29 Jun 2017 16:52:51 +0200
Message-ID: <b640c93b-23fe-82dc-b0ec-5c77fea64ed7@gmx.net>
References: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RMS4nNfqI7xeBNRxqismDUQtsjxDKSIAo"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:59664 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752852AbdF2OxM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 29 Jun 2017 10:53:12 -0400
In-Reply-To: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, b29396@freescale.com, socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RMS4nNfqI7xeBNRxqismDUQtsjxDKSIAo
Content-Type: multipart/mixed; boundary="oUH6liCFTfnelu08jHPg9nT7R1GOitPwB";
 protected-headers="v1"
From: =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>
To: Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org,
 wg@grandegger.com, mkl@pengutronix.de, b29396@freescale.com,
 socketcan@hartkopp.net
Message-ID: <b640c93b-23fe-82dc-b0ec-5c77fea64ed7@gmx.net>
Subject: Re: MCAN Registers Discrepancy
References: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
In-Reply-To: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>

--oUH6liCFTfnelu08jHPg9nT7R1GOitPwB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello,

you are right. There are/were some incosistencies in the values.

However, the driver used them correctly. The driver version you

talk about is not entirely compatible with the user manual you provided.


I wrote some patches back in April which add support for the newer M_CAN

versions up to 3.2.X:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/net/can/m_can

These should work as intended.

Before, the driver could only handle IP versions 3.0.X.


Mario



On 06/28/2017 11:49 PM, Franklin S Cooper Jr wrote:
> Hi,
>
> When looking at the latest versions of the MCAN user manual it seems
> that there is a discrepancy between the various BTR_XX_MASK and
> BTR_XX_SHIFT values. For example BTR_TSEG2_MASK is set to 0xF and
> BTR_TSEG2_SHIFT is 4. However, based on page 21 of the latest version o=
f
> the MCAN User Manual NTSEG2 starts at bit 0. Therefore, it should have =
a
> shift value of 0. Also it is a 7 bit field so its mask should be 0x7F. =
I
> see similar issues with FBTR_XXX_MASK values.
>
> So the original driver mentioned it was based on rev version 3.1.0 of
> the User Manual while the latest version publicly available is 3.2.12.
> Since I don't see any current users of this driver in upstream I am
> unsure if this is just a bug in the code or if the current values are
> correct for older versions of the IP.
>
> Does anyone have a copy of this older document available that they can
> share? Or at the very least verify that the current values were correct=

> in older revisions of the MCAN IP? I need to make updates to the driver=
s
> but I want to avoid breaking things for other people.
>
> Latest version of the MCAN User Manual can be found at:
> http://www.bosch-semiconductors.de/media/automotive_electronics/pdf_2/i=
pmodules_3/m_can_m_ttcan_1/mcan_users_manual_v3212.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--oUH6liCFTfnelu08jHPg9nT7R1GOitPwB--

--RMS4nNfqI7xeBNRxqismDUQtsjxDKSIAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwjdBGUhyDYwF3W3ckaOeH7OEy/0FAllVFEcACgkQkaOeH7OE
y/1i0BAAkX0T7MLkKv9d4jOgxvvhev+6IG9ABhkV7PzD1PYp+NzZcc/Az1N/gKem
rsNIbnonBmabELux/jZQzq34t1fg9A4wDSDmNs6WTj5JnqzR3h6NLAtTcM17vvRf
ddO2x5b36Cml9sE3JYtaBHHj7eV9kdzEBi1oDAp0HIgN0sj5AiXYT7QjA9blV41Y
PbYZZv2UfHCVOsR8/end8DR6h3DM+DYifOPzyOSwMC9E/Nk2Zq19S0bRLtSPjf4G
xd6qEt4JnMo2Xfm6Krd+PMVxmpN4n0vlTI8G3rdROPVHotTKf8ujcZ7FWge8F/+C
RX4LvpexG6AIN4dkKnPZAiOTTUBKYfRVhAFgl8eOepPAsZB0XYa0l81FFNR16eUq
WHRtfR/MSml5Ew9ZdVgLL1dT8ICaSA8X9Bw1XkbVXD6gtsGcMz1SUoDItlMMnk1I
bDes+whFmLVOM+CGE5Cf7WRXepM3TvaSJRFGZmTk2n6udKKN/uWrOnVyh8x7f/PK
AcnP+sKASFm8EclbG1M9tElAId3LwOwXR+v0mCAUU8LfScMPxLdMMJUGf1Tfav5N
7EFXWJyO15ZiR0A0zQgnvcf4zn34T5pmg16qG6FwtlYKBdtYjRHoQPqeQfS+VPtr
oBCrhFgfZls1Ijw73qZ2lPAyk5MdfULIb+hop2O/1xVEgnGLf6Q=
=EpEX
-----END PGP SIGNATURE-----

--RMS4nNfqI7xeBNRxqismDUQtsjxDKSIAo--
