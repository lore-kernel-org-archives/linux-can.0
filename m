From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/2] can: m_can: add Bosch M_CAN controller support
Date: Fri, 11 Jul 2014 14:22:00 +0200
Message-ID: <53BFD6E8.8080109@pengutronix.de>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com> <1405074557-5519-2-git-send-email-b29396@freescale.com> <53BFC6CE.9090408@gmail.com> <53BFD28A.5090202@pengutronix.de> <53BFD4DF.7030003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s5QoM6O2GGIEieIPeVpEQp170DWGBnK7K"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaGKMWo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 08:22:44 -0400
In-Reply-To: <53BFD4DF.7030003@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s5QoM6O2GGIEieIPeVpEQp170DWGBnK7K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2014 02:13 PM, Varka Bhadram wrote:
[...]

>>>> +static const struct of_device_id m_can_of_table[] =3D {
>>>> +    { .compatible =3D "bosch,m_can", .data =3D NULL },
>>> we can simply give '0' . No need of .data =3D NULL. Things should be
>>> simple right....  :-)
>> .data should be a pointer, while "0" isn't. (Although 0 is valid C, we=

>> don't want a integer 0 to initialize a pointer.) However, you can omit=

>> .data =3D NULL completely. When initialzing via C99, any omited member=
s of
>> the struct will automatically be initialized with 0x0. I like to see t=
he
>> .data =3D NULL because it documents that there isn't any data (yet), o=
nce
>> another compatible is added, we need the .data anyways.
>=20
> static const struct of_device_id m_can_of_table[] =3D {
>     { .compatible =3D "bosch,m_can", },
> };
>=20
> This is enough... right ?

Yes....

Not having .data =3D NULL is correct, but I'd like to see it, just to
document: "there is no data needed, nobody forgot it"

=2E..but...

Just must have a NULL-element terminating that list:

>>>> +    { /* sentinel */ },
          ^^^^^^^^^^^^^^^^^^
>>>> +};

>>>> +MODULE_DEVICE_TABLE(of, m_can_of_table);
>>>> +
>>>> +static int m_can_of_parse_mram(struct platform_device *pdev,
>>>> +                   struct m_can_priv *priv)
>>>> +{
>>>> +    struct device_node *np =3D pdev->dev.of_node;
>>>> +    struct resource *res;
>>>> +    void __iomem *addr;
>>>> +    u32 out_val[MRAM_CFG_LEN];
>>>> +    int ret;
>>>> +
>>>> +    /* message ram could be shared */
>>>> +    res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>>>> "message_ram");
>>>> +    if (!res)
>>>> +        return -ENODEV;
>>>> +
>>>> +    addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res=
));
>>>> +    if (!addr)
>>>> +        return -ENODEV;
>>> Is this err return is appropriate ... ?
>> -ENOMEM seems to be more commonly used.
>>
>>>> +
>>>> +    /* get message ram configuration */
>>>> +    ret =3D of_property_read_u32_array(np, "mram-cfg",
>>>> +                     out_val, sizeof(out_val) / 4);
>>>> +    if (ret) {
>>>> +        dev_err(&pdev->dev, "can not get message ram
>>>> configuration\n");
>>>> +        return -ENODEV;
>>>> +    }
>>>> +
>>> Is this err return is appropriate ... ?
>> Whay do you suggest?
>>
>>>> +    priv->mram_base =3D addr;
>>>> +    priv->mcfg[MRAM_SIDF].off =3D out_val[0];
>>>> +    priv->mcfg[MRAM_SIDF].num =3D out_val[1];
>>>> +    priv->mcfg[MRAM_XIDF].off =3D priv->mcfg[MRAM_SIDF].off +
>>>> +            priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_XIDF].num =3D out_val[2];
>>>> +    priv->mcfg[MRAM_RXF0].off =3D priv->mcfg[MRAM_XIDF].off +
>>>> +            priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_RXF0].num =3D out_val[3] & RXFC_FS_MASK;
>>>> +    priv->mcfg[MRAM_RXF1].off =3D priv->mcfg[MRAM_RXF0].off +
>>>> +            priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_RXF1].num =3D out_val[4] & RXFC_FS_MASK;
>>>> +    priv->mcfg[MRAM_RXB].off =3D priv->mcfg[MRAM_RXF1].off +
>>>> +            priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_RXB].num =3D out_val[5];
>>>> +    priv->mcfg[MRAM_TXE].off =3D priv->mcfg[MRAM_RXB].off +
>>>> +            priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_TXE].num =3D out_val[6];
>>>> +    priv->mcfg[MRAM_TXB].off =3D priv->mcfg[MRAM_TXE].off +
>>>> +            priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
>>>> +    priv->mcfg[MRAM_TXB].num =3D out_val[7] & TXBC_NDTB_MASK;
>>>> +
>>>> +    dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf=
0
>>>> 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>>>> +        priv->mram_base,
>>>> +        priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
>>>> +        priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
>>>> +        priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
>>>> +        priv->mcfg[MRAM_RXF1].off, priv->mcfg[MRAM_RXF1].num,
>>>> +        priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
>>>> +        priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
>>>> +        priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
>>>> +
>>> dev_dbg() will insert the new lines in b/w. It wont print the values =
as
>>> you expected.
>>> Check this by enabling debug ...
>> What do you mean by b/w?

b/w =3D=3D between ?

here: b/w !=3D black/white :)

> You are expecting the data to be print in format like:
> pdev->dev/name: mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 0x%x %d rxf=
1
> 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d
>=20
> But when we use the dev_dbg()/pr_debug()... It will put data like:
> pdev->dev/name: mram_base %p sidf 0x%x
> 0x%x %d rxf0 0x%x
> rxf1 0x%x %d rxb
> ....
>=20
> check this by enable DEBUG...

Okay, thanks for pointing out.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--s5QoM6O2GGIEieIPeVpEQp170DWGBnK7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO/1ugACgkQjTAFq1RaXHMTzQCfTNVs5uEhT3y0zyeIQP2gFoS7
iW8AnRvNQfJogh4ZA4K/aFcBcrjWWHMQ
=O98g
-----END PGP SIGNATURE-----

--s5QoM6O2GGIEieIPeVpEQp170DWGBnK7K--
