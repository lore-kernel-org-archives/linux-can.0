From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] can: m_can: add Bosch M_CAN controller support
Date: Fri, 11 Jul 2014 14:03:22 +0200
Message-ID: <53BFD28A.5090202@pengutronix.de>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com> <1405074557-5519-2-git-send-email-b29396@freescale.com> <53BFC6CE.9090408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1Rn9C8UrGNicxT8V9g6F2l8otV4A4RtvB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53BFC6CE.9090408-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Rn9C8UrGNicxT8V9g6F2l8otV4A4RtvB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2014 01:13 PM, Varka Bhadram wrote:
> On 07/11/2014 03:59 PM, Dong Aisheng wrote:
>=20
> (...)
>=20
>> +/* m_can private data structure */
>> +struct m_can_priv {
>> +    struct can_priv can;    /* must be the first member */
>> +    struct napi_struct napi;
>> +    struct net_device *dev;
>> +    struct device *device;
>> +    struct clk *hclk;
>> +    struct clk *cclk;
>> +    void __iomem *base;
>> +    u32 irqstatus;
>> +
>> +    /* message ram configuration */
>> +    void __iomem *mram_base;
>> +    struct mram_cfg mcfg[MRAM_CFG_NUM];
>> +};
>> +
>=20
> It will be good if we write the comments for the driver private structu=
re
>=20
>> +static inline u32 m_can_read(const struct m_can_priv *priv, enum
>> m_can_reg reg)
>> +{
>> +    return readl(priv->base + reg);
>> +}
>> +
>=20
> (...)
>=20
>> +static void free_m_can_dev(struct net_device *dev)
>> +{
>> +    free_candev(dev);
>> +}
>> +
>=20
> Why do we need a separate function which calls a single function...  :-=
)

To be symetric with alloc_m_can_dev()

>=20
>> +static struct net_device *alloc_m_can_dev(void)
>> +{
>> +    struct net_device *dev;
>> +    struct m_can_priv *priv;
>> +
>> +    dev =3D alloc_candev(sizeof(struct m_can_priv), 1);
>=20
> sizeof(*priv)...?
>=20
>> +    if (!dev)
>> +        return NULL;
>=20
> Return value -ENOMEM ?

I'm okay with NULL, however if we want to return an arror value, it must
be ERR_PTR() wrapped.

>=20
>> +
>> +    priv =3D netdev_priv(dev);
>> +    netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
>> +
>> +    priv->dev =3D dev;
>> +    priv->can.bittiming_const =3D &m_can_bittiming_const;
>> +    priv->can.do_set_mode =3D m_can_set_mode;
>> +    priv->can.do_get_berr_counter =3D m_can_get_berr_counter;
>> +    priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>> +                    CAN_CTRLMODE_LISTENONLY |
>> +                    CAN_CTRLMODE_BERR_REPORTING;
>> +
>> +    return dev;
>> +}
>> +
>> +static int m_can_open(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +    int err;
>> +
>> +    err =3D clk_prepare_enable(priv->hclk);
>> +    if (err)
>> +        return err;
>> +
>> +    err =3D clk_prepare_enable(priv->cclk);
>> +    if (err)
>> +        goto exit_disable_hclk;
>> +
>> +    /* open the can device */
>> +    err =3D open_candev(dev);
>> +    if (err) {
>> +        netdev_err(dev, "failed to open can device\n");
>> +        goto exit_disable_cclk;
>> +    }
>> +
>> +    /* register interrupt handler */
>> +    err =3D request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
>> +              dev);
>=20
> why don't we use devm_request_irq()...? If you use this no need to worr=
y
> about freeing the irq

=2E..because the IRQ is allocated during ifup and released during ifdown.=


>=20
>> +    if (err < 0) {
>> +        netdev_err(dev, "failed to request interrupt\n");
>> +        goto exit_irq_fail;
>> +    }
>> +
>> +    /* start the m_can controller */
>> +    m_can_start(dev);
>> +
>> +    can_led_event(dev, CAN_LED_EVENT_OPEN);
>> +    napi_enable(&priv->napi);
>> +    netif_start_queue(dev);
>> +
>> +    return 0;
>> +
>> +exit_irq_fail:
>> +    close_candev(dev);
>> +exit_disable_cclk:
>> +    clk_disable_unprepare(priv->cclk);
>> +exit_disable_hclk:
>> +    clk_disable_unprepare(priv->hclk);
>> +    return err;
>> +}
>> +
>> +static void m_can_stop(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +
>> +    /* disable all interrupts */
>> +    m_can_disable_all_interrupts(priv);
>> +
>> +    clk_disable_unprepare(priv->hclk);
>> +    clk_disable_unprepare(priv->cclk);
>> +
>> +    /* set the state as STOPPED */
>> +    priv->can.state =3D CAN_STATE_STOPPED;
>> +}
>> +
>> +static int m_can_close(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv =3D netdev_priv(dev);
>> +
>> +    netif_stop_queue(dev);
>> +    napi_disable(&priv->napi);
>> +    m_can_stop(dev);
>> +    free_irq(dev->irq, dev);
>=20
> not required when you use devm_request_irq()

No....see above.

>=20
>> +    close_candev(dev);
>> +    can_led_event(dev, CAN_LED_EVENT_STOP);
>> +
>> +    return 0;
>> +}
>> +
>=20
> (...)
>=20
>> +
>> +static const struct of_device_id m_can_of_table[] =3D {
>> +    { .compatible =3D "bosch,m_can", .data =3D NULL },
>=20
> we can simply give '0' . No need of .data =3D NULL. Things should be
> simple right....  :-)

=2Edata should be a pointer, while "0" isn't. (Although 0 is valid C, we
don't want a integer 0 to initialize a pointer.) However, you can omit
=2Edata =3D NULL completely. When initialzing via C99, any omited members=
 of
the struct will automatically be initialized with 0x0. I like to see the
=2Edata =3D NULL because it documents that there isn't any data (yet), on=
ce
another compatible is added, we need the .data anyways.

>=20
>> +    { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, m_can_of_table);
>> +
>> +static int m_can_of_parse_mram(struct platform_device *pdev,
>> +                   struct m_can_priv *priv)
>> +{
>> +    struct device_node *np =3D pdev->dev.of_node;
>> +    struct resource *res;
>> +    void __iomem *addr;
>> +    u32 out_val[MRAM_CFG_LEN];
>> +    int ret;
>> +
>> +    /* message ram could be shared */
>> +    res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "message_ram");
>> +    if (!res)
>> +        return -ENODEV;
>> +
>> +    addr =3D devm_ioremap(&pdev->dev, res->start, resource_size(res))=
;
>> +    if (!addr)
>> +        return -ENODEV;
>=20
> Is this err return is appropriate ... ?

-ENOMEM seems to be more commonly used.

>=20
>> +
>> +    /* get message ram configuration */
>> +    ret =3D of_property_read_u32_array(np, "mram-cfg",
>> +                     out_val, sizeof(out_val) / 4);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "can not get message ram configuration\n"=
);
>> +        return -ENODEV;
>> +    }
>> +
>=20
> Is this err return is appropriate ... ?

Whay do you suggest?

>=20
>> +    priv->mram_base =3D addr;
>> +    priv->mcfg[MRAM_SIDF].off =3D out_val[0];
>> +    priv->mcfg[MRAM_SIDF].num =3D out_val[1];
>> +    priv->mcfg[MRAM_XIDF].off =3D priv->mcfg[MRAM_SIDF].off +
>> +            priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_XIDF].num =3D out_val[2];
>> +    priv->mcfg[MRAM_RXF0].off =3D priv->mcfg[MRAM_XIDF].off +
>> +            priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF0].num =3D out_val[3] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXF1].off =3D priv->mcfg[MRAM_RXF0].off +
>> +            priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF1].num =3D out_val[4] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXB].off =3D priv->mcfg[MRAM_RXF1].off +
>> +            priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXB].num =3D out_val[5];
>> +    priv->mcfg[MRAM_TXE].off =3D priv->mcfg[MRAM_RXB].off +
>> +            priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXE].num =3D out_val[6];
>> +    priv->mcfg[MRAM_TXB].off =3D priv->mcfg[MRAM_TXE].off +
>> +            priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXB].num =3D out_val[7] & TXBC_NDTB_MASK;
>> +
>> +    dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0
>> 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>> +        priv->mram_base,
>> +        priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
>> +        priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
>> +        priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
>> +        priv->mcfg[MRAM_RXF1].off, priv->mcfg[MRAM_RXF1].num,
>> +        priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
>> +        priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
>> +        priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
>> +
>=20
> dev_dbg() will insert the new lines in b/w. It wont print the values as=

> you expected.
> Check this by enabling debug ...

What do you mean by b/w?

>=20
>> +    return 0;
>> +}
>> +
>=20
> (...)
>=20
>> +
>> +static void unregister_m_can_dev(struct net_device *dev)
>> +{
>> +    unregister_candev(dev);
>> +}
>> +
>=20
> again a function which calls a single func.
>=20
>> +static int m_can_plat_remove(struct platform_device *pdev)
>> +{
>> +    struct net_device *dev =3D platform_get_drvdata(pdev);
>> +
>> +    unregister_m_can_dev(dev);
>> +    platform_set_drvdata(pdev, NULL);
>> +
>> +    free_m_can_dev(dev);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops m_can_pmops =3D {
>> +    SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>> +};
>> +
>> +static struct platform_driver m_can_plat_driver =3D {
>> +    .driver =3D {
>> +        .name =3D KBUILD_MODNAME,
>> +        .owner =3D THIS_MODULE,
>=20
> No need to update .owner. module_platform_driver() will do for you.
> see:http://lxr.free-electrons.com/source/include/linux/platform_device.=
h#L190

Oh, right.

>> +        .of_match_table =3D of_match_ptr(m_can_of_table),
>> +        .pm     =3D &m_can_pmops,
>> +    },
>> +    .probe =3D m_can_plat_probe,
>> +    .remove =3D m_can_plat_remove,
>> +};
>> +
>> +module_platform_driver(m_can_plat_driver);
>> +
>> +MODULE_AUTHOR("Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
>=20
>=20
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1Rn9C8UrGNicxT8V9g6F2l8otV4A4RtvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO/0ooACgkQjTAFq1RaXHOcoACfdJV6e1csdmjgwSk+anLbHHwS
8G8AnRwG8joj/2QX93LWtS0GLGg6emhC
=jjPr
-----END PGP SIGNATURE-----

--1Rn9C8UrGNicxT8V9g6F2l8otV4A4RtvB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
