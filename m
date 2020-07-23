From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
Date: Thu, 23 Jul 2020 15:37:41 +0200
Message-ID: <3c462bd1-c904-3432-de85-a0b61f38fa0d@pengutronix.de>
References: <VI1PR03MB5053976465B2A1EAB995BA02D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
 <VI1PR03MB5053197AAA73DC22A681610DD6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ccvoHA217A9trtbdmrfLp5df086uSpl1k"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGWNhu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2020 09:37:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD105C0619DC
        for <linux-can@vger.kernel.org>; Thu, 23 Jul 2020 06:37:49 -0700 (PDT)
In-Reply-To: <VI1PR03MB5053197AAA73DC22A681610DD6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ccvoHA217A9trtbdmrfLp5df086uSpl1k
Content-Type: multipart/mixed; boundary="JHIembg5SpCmVlxRu1Dhs4DmtDrfMrN8B";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <3c462bd1-c904-3432-de85-a0b61f38fa0d@pengutronix.de>
Subject: Re: About sysfs usage by socket-can drivers
References: <VI1PR03MB5053976465B2A1EAB995BA02D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
 <VI1PR03MB5053197AAA73DC22A681610DD6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB5053197AAA73DC22A681610DD6760@VI1PR03MB5053.eurprd03.prod.outlook.com>

--JHIembg5SpCmVlxRu1Dhs4DmtDrfMrN8B
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/23/20 11:18 AM, St=C3=A9phane Grosjean wrote:
> Are there rules for using network interface sysfs, in particular, can a=

> socket-can driver add its own attributes, please?
First let's discuss, why you need a sysfs attribute?
Is there a better way to do this?

Then you have to describe the sysfs entry, e.g.:
Documentation/ABI/testing/sysfs-platform-at91

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--JHIembg5SpCmVlxRu1Dhs4DmtDrfMrN8B--

--ccvoHA217A9trtbdmrfLp5df086uSpl1k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl8ZkqUACgkQqclaivrt
76kAvQf+LZjMJ7/xgCjPcaBglp47U20gYCPkiIsRFmEtKxPUiwS7Bt/Bxv+wUGqV
wbrw2GgFl2Lk/d+tbT0DEhjG4E5e2fkCxawWDyl9xqSf4AGDC3BalZ+ijbQvzG4o
16pDB0U+IYdvFqkWL3QwpIqakD8YiUIRd5pQmDFMmcxW7EO+JhxoJ+0KEwovS2da
6+5qgFT30JBGG8QMOnmyulZ7MjeO2CS8E7AG5yMqDij7lbiNX5zw1sNOhJgvZKHq
+EAXBS1/hfhXFw0vjwA7kjqxeMybs6ct0cZNh2DwP9rKT3Yz2i26joUwl2084JI8
dTxe7Ktj4PZP6vgl6I2vvBmGPdhgbQ==
=24ob
-----END PGP SIGNATURE-----

--ccvoHA217A9trtbdmrfLp5df086uSpl1k--
