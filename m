From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 0/3] Add DT support to C_CAN/D_CAN controller
Date: Thu, 02 Aug 2012 13:23:38 +0200
Message-ID: <501A633A.5000100@pengutronix.de>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com> <501A60C0.1040504@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA081AD@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig85FD69EC1385C1FE02BA3DE5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45304 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab2HBLXw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Aug 2012 07:23:52 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA081AD@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig85FD69EC1385C1FE02BA3DE5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/02/2012 01:21 PM, AnilKumar, Chimata wrote:
> Marc,
>=20
> On Thu, Aug 02, 2012 at 16:43:04, Marc Kleine-Budde wrote:
>> On 08/02/2012 01:02 PM, AnilKumar Ch wrote:
>>> This patch series adds the device tree support and Runtime PM support=

>>> to C_CAN/D_CAN controller.
>>>
>>> These patches have been tested on AM335x EVM using some additional
>>> patches to add device tree data to EVM dts files and to initialize
>>> D_CAN RAM. D_CAN raminit is controlled from control module register.
>>> This patch will be submitted once control module MFD driver support
>>> is added.
>>>
>>> These patches are based on linx-can-next tree.
>>>
>>> Due to lack of hardware I am not able to test c_can functionality.
>>> I appreciate if anyone can test c_can functionality with this patch
>>> series.
>>>
>>> Changes from v2:
>>> 	- Incorporated Marcs on v2
>>> 	  * Fix compilation errors in pci due to device name changes
>>> 	  in v2 by adding new patch.
>>>
>>> Changes from v1:
>>> 	- Separated 4 patches into CAN driver specific and device
>>> 	  tree data addition specific.
>>> 	- Incorporated Marc's comments on v1
>>> 	  * Modified c_can_dev_id enum to handle both devtype and
>>> 	    platform device id index.
>>> 	  * Removed "legacy bosch,c_can_platform" from DT bindings
>>>
>>> AnilKumar Ch (3):
>>>   can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller=

>>>   can: c_can: Modify c_can device names in c_can_pci driver
>>
>> You break bisectability here. After patch 1 the pci driver will not
>> compile anymore. I suggest to do the renaming of enum c_can_dev_id and=

>> all it's users in patch 1.
>>
>=20
> I will merge patch 1 and 2 and submit v4.

But changing the pci driver has nothing to do with the subject ("Add
device tree support to Bosch C_CAN/D_CAN controller").

It's considered bad practise to do so.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig85FD69EC1385C1FE02BA3DE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAaYz0ACgkQjTAFq1RaXHNIJgCeIraD3S/GI+JlScMCEFPt2yW+
XSQAn2y+5QmR+K5JwDh5neftpEvp6qlL
=qVhI
-----END PGP SIGNATURE-----

--------------enig85FD69EC1385C1FE02BA3DE5--
