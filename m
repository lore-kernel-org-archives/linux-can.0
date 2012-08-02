From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] can: c_can: Add device tree support to Bosch
 C_CAN/D_CAN controller
Date: Thu, 02 Aug 2012 09:59:44 +0200
Message-ID: <501A3370.5090906@pengutronix.de>
References: <1343218729-16954-1-git-send-email-anilkumar@ti.com>
 <1343218729-16954-2-git-send-email-anilkumar@ti.com>
 <500FF908.1000307@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA037AA@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0489769713302232033=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA037AA-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
--===============0489769713302232033==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A9138F53A577644A316FEB5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A9138F53A577644A316FEB5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 04:12 PM, AnilKumar, Chimata wrote:
> Marc,
>=20
> On Wed, Jul 25, 2012 at 19:17:52, Marc Kleine-Budde wrote:
>> On 07/25/2012 02:18 PM, AnilKumar Ch wrote:
>>> Add device tree support to C_CAN/D_CAN controller and usage details
>>> are added to device tree documentation. Driver was tested on AM335x
>>> EVM.
>>
>> Does not apply to linux-can-next, as Viresh Kumar's patch "net/c_can:
>> remove conditional compilation of clk code" is not yet included. I
>> suggest to delay this patch until we have Viresh's patch in net-next.
>>
>> See comment inline.
>=20
> Ok, I will wait till net-next is updated with Viresh Kumar's patch.

Now Viresh's patch is in net-next, feel free to post your new patches.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2A9138F53A577644A316FEB5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAaM3AACgkQjTAFq1RaXHPnWACgghpOA6YZsNQv1uWMqNryJdmt
fXIAn1pJq3Weh0BBdEpLSbswoWAlAYG1
=xPxJ
-----END PGP SIGNATURE-----

--------------enig2A9138F53A577644A316FEB5--

--===============0489769713302232033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0489769713302232033==--
