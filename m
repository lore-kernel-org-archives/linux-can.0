From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] Add DT support to C_CAN/D_CAN controller
Date: Thu, 02 Aug 2012 13:45:26 +0200
Message-ID: <501A6856.9010706@pengutronix.de>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
 <501A60C0.1040504@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA081AD@DBDE01.ent.ti.com>
 <501A633A.5000100@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA081FB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6062482309821139859=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA081FB-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gole,
 Anant" <anantgole-l0cyMroinI0@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6062482309821139859==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0AF1C2653584EA3B371FFF46"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AF1C2653584EA3B371FFF46
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/02/2012 01:39 PM, AnilKumar, Chimata wrote:
[...]
>>>>> AnilKumar Ch (3):
>>>>>   can: c_can: Add device tree support to Bosch C_CAN/D_CAN controll=
er
>>>>>   can: c_can: Modify c_can device names in c_can_pci driver
>>>>
>>>> You break bisectability here. After patch 1 the pci driver will not
>>>> compile anymore. I suggest to do the renaming of enum c_can_dev_id a=
nd
>>>> all it's users in patch 1.
>>>>
>>>
>>> I will merge patch 1 and 2 and submit v4.
>>
>> But changing the pci driver has nothing to do with the subject ("Add
>> device tree support to Bosch C_CAN/D_CAN controller").
>>
>> It's considered bad practise to do so.
>>
>=20
> In that case I will change the patch 1 according to "C_CAN_PLTFORM_DEVT=
YPE"
> and flag name changes to BOSCH_* will be in patch 2. So that we can get=
 rid
> of these two problems.

I'm not sure if I understand you correctly. Please first rename the
constants, then add device tree support.

It doesn't make any sense to first introduce DT support and then patch
parts of the DT that have been added in the previous patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig0AF1C2653584EA3B371FFF46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAaaFkACgkQjTAFq1RaXHMQLACfeSrGwmtw+ru3dYj6Sy5qv15z
E/8AmwUb1MU7Oqs9rESiQV7WGHLOqQ99
=PKMy
-----END PGP SIGNATURE-----

--------------enig0AF1C2653584EA3B371FFF46--

--===============6062482309821139859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6062482309821139859==--
