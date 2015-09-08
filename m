From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/2] Allwinner A10/A20 CAN Controller support
Date: Tue, 8 Sep 2015 13:00:52 +0200
Message-ID: <55EEBFE4.8@pengutronix.de>
References: <1441376988-2384-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Bj9p44OtqkhSIglWBQvQ4tQjAarJhvQrr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45749 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbbIHLA7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:00:59 -0400
In-Reply-To: <1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bj9p44OtqkhSIglWBQvQ4tQjAarJhvQrr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2015 04:29 PM, Gerhard Bertelsmann wrote:
> This patch adds the Allwinner A10/A20 Kernel module
>=20
> Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
                                      ^                           ^
Please remove the space.

> Tested-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >

Submitting a patch includes testing it :) You can remove that tag.

> +static int sunxican_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct clk *clk;
> +	void __iomem *addr;
> +	int err, irq;
> +	u32 temp_irqen;
> +	struct net_device *dev;
> +	struct sunxican_priv *priv;
> +
> +	clk =3D clk_get(&pdev->dev, "apb1_can");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "no clock defined\n");
> +		err =3D -ENODEV;
> +		goto exit;
> +	}
> +	/* turn on clocking for CAN peripheral block */
> +	err =3D clk_prepare_enable(clk);
> +	if (err) {
> +		dev_err(&pdev->dev, "could not enable clocking (apb1_can)\n");
> +		goto exit;
> +	}
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq =3D platform_get_irq(pdev, 0);
> +
> +	if (!res || irq <=3D 0) {
> +		dev_err(&pdev->dev, "could not get a valid irq\n");
> +		err =3D -ENODEV;
> +		goto exit_put;
> +	}
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) =
{
> +		dev_err(&pdev->dev, "could not get io memory resource\n");
> +		err =3D -EBUSY;
> +		goto exit_put;
> +	}
> +	addr =3D ioremap_nocache(res->start, resource_size(res));
> +	if (!addr) {
> +		dev_err(&pdev->dev, "could not map io memory\n");
> +		err =3D -ENOMEM;
> +		goto exit_release;
> +	}
> +	dev =3D alloc_candev(sizeof(struct sunxican_priv), 1);
> +
> +	if (!dev) {
> +		dev_err(&pdev->dev,
> +			"could not allocate memory for CAN device\n");
> +		err =3D -ENOMEM;
> +		goto exit_iounmap;
> +	}
> +
> +	dev->netdev_ops =3D &sunxican_netdev_ops;
> +	dev->irq =3D irq;
> +	dev->flags |=3D IFF_ECHO;
> +
> +	priv =3D netdev_priv(dev);
> +	priv->can.clock.freq =3D clk_get_rate(clk);
> +	priv->can.bittiming_const =3D &sunxican_bittiming_const;
> +	priv->can.do_set_bittiming =3D sunxican_set_bittiming;

Please don't do this, call set_bittiming during open();

> +	priv->can.do_set_mode =3D sunxican_set_mode;
> +	priv->can.do_get_berr_counter =3D sunxican_get_berr_counter;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_BERR_REPORTING |
> +				       CAN_CTRLMODE_LISTENONLY |
> +				       CAN_CTRLMODE_LOOPBACK |
> +				       CAN_CTRLMODE_3_SAMPLES;
> +	priv->base =3D addr;
> +	priv->clk =3D clk;
> +	spin_lock_init(&priv->cmdreg_lock);
> +
> +	/* enable CAN specific interrupts */
> +	set_reset_mode(dev);
> +	temp_irqen =3D BERR_IRQ_EN | ERR_PASSIVE_IRQ_EN | OR_IRQ_EN | RX_IRQ_=
EN;
> +	writel(readl(priv->base + CAN_INTEN_ADDR) | temp_irqen,
> +	       priv->base + CAN_INTEN_ADDR);
> +
> +	platform_set_drvdata(pdev, dev);
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +
> +	err =3D register_candev(dev);
> +	if (err) {
> +		dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
> +			DRV_NAME, err);
> +		goto exit_free;
> +	}
> +	devm_can_led_init(dev);
> +
> +	dev_info(&pdev->dev, "device registered (base=3D%p, irq=3D%d)\n",
> +		 priv->base, dev->irq);
> +
> +	return 0;
> +
> +exit_free:
> +	free_candev(dev);
> +exit_iounmap:
> +	iounmap(addr);
> +exit_release:
> +	release_mem_region(res->start, resource_size(res));
> +exit_put:
> +	clk_put(clk);
> +exit:
> +	return err;
> +}
> +
> +static int __maybe_unused sunxi_can_suspend(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev)) {
> +		netif_stop_queue(dev);
> +		netif_device_detach(dev);
> +	}
> +	priv->can.state =3D CAN_STATE_SLEEPING;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sunxi_can_resume(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	if (netif_running(dev)) {
> +		netif_device_attach(dev);
> +		netif_start_queue(dev);
> +	}
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sunxi_can_pm_ops, sunxi_can_suspend, sunxi_ca=
n_resume);
> +
> +static struct platform_driver sunxi_can_driver =3D {
> +	.driver =3D {
> +		   .name =3D DRV_NAME,
> +		   .owner =3D THIS_MODULE,
> +		   .pm =3D &sunxi_can_pm_ops,
> +		   .of_match_table =3D sunxican_of_match,
> +		   },
> +	.probe =3D sunxican_probe,
> +	.remove =3D sunxican_remove,
> +	.id_table =3D sunxican_id_table,
> +};
> +
> +module_platform_driver(sunxi_can_driver);
> +
> +MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
> +MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION(DRV_NAME "CAN driver for Allwinner SoCs (A10/A20)")=
;
> +MODULE_VERSION(DRV_MODULE_VERSION);
> +

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Bj9p44OtqkhSIglWBQvQ4tQjAarJhvQrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7r/kAAoJEP5prqPJtc/HpaYH/jxIMrBr4YbntglEL3A4xiC4
a6yV6NdwG7PSskkeUAr/CJ+28sGXsSgauVEkAYzAZeCItrq+UWaTwOfn69GWBsfn
qzIfzDeLXGHrsGAqMovVKmuZ4+GBy5vUu1Razzd1ubSalZvbX9uFUljpTG1Zidlf
kUGOQJiLTaHGCR12EBQErtF+UNcnS8EhLg1iGYkB+/H+QOYpW5Lm+WY2GFT3Z9Sy
CWdJsuQapv9QsZr3Xlq7+D9jXnMt08oMu2txIg77cAegCKqBM9pR102PXgPKzW0n
x3xmuAX8TjAnngwgAdQGwtamIWY89kwdep1i2yWxS6eqnX+BXUeK6H40Ewu3ypE=
=coQd
-----END PGP SIGNATURE-----

--Bj9p44OtqkhSIglWBQvQ4tQjAarJhvQrr--
