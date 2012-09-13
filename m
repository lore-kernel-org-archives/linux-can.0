From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] mfd/janz-cmodio: fix MODULBus number sysfs entry
Date: Thu, 13 Sep 2012 14:57:51 +0200
Message-ID: <5051D84F.4080605@pengutronix.de>
References: <1347404295-7985-1-git-send-email-iws@ovro.caltech.edu> <1347404295-7985-2-git-send-email-iws@ovro.caltech.edu> <5051C9F0.3050600@pengutronix.de> <20120913125201.GB3647@sortiz-mobl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8C039140DB92FDA42B88E47"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43030 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757940Ab2IMM57 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 08:57:59 -0400
In-Reply-To: <20120913125201.GB3647@sortiz-mobl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8C039140DB92FDA42B88E47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 02:52 PM, Samuel Ortiz wrote:
> On Thu, Sep 13, 2012 at 01:56:32PM +0200, Marc Kleine-Budde wrote:
>> On 09/12/2012 12:58 AM, Ira W. Snyder wrote:
>>> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>>>
>>> Revision 1.0 of the Janz CMOD-IO Carrier Board does not contain zeroe=
s
>>> in the top 4 bits of the modulbus_num (int_enable) register. Mask off=

>>> the unused bits so that the correct value is displayed in sysfs.
>>>
>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
>>
>> Who will take care of this patch?
> I will.

Tnx.
 I'm taking the other one.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD8C039140DB92FDA42B88E47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBR2FIACgkQjTAFq1RaXHMKFwCfUqZmZB6f7aHpVfTLcVzNBLtF
IwsAn3dY/aorQPNPJB+Al0FZZzCu5nQO
=n+XS
-----END PGP SIGNATURE-----

--------------enigD8C039140DB92FDA42B88E47--
