From: Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>
Subject: Re: [PATCH v5 2/2] can: Allwinner A10/A20 CAN
 Controller support - controller code
Date: Mon, 14 Sep 2015 14:41:04 +0200
Message-ID: <cc433d14a0a6e9e8c8ccebaa372e1893@mail.rdts.de>
References: <1442144632-4541-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442144632-4541-3-git-send-email-info@gerhard-bertelsmann.de>
 <20150913124501.GS9885@lukather>
 <f8eea0f544eb6367142bbc1c2ab35964@mail.rdts.de>
 <20150914081703.GB9885@lukather>
Reply-To: info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDQJPYGU4UARBYMA3OXQKGQEIRMFPJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150914081703.GB9885@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi Maxime,

thanks for your response.

Am 2015-09-14 10:17, schrieb Maxime Ripard:
> Hi,
> 
> On Sun, Sep 13, 2015 at 03:42:41PM +0200, Gerhard Bertelsmann wrote:
>> >> drivers/net/can/Kconfig                            |  10 +
>> >> drivers/net/can/Makefile                           |   1 +
>> >> drivers/net/can/sunxi_can.c                        | 879
>> >>+++++++++++++++++++++
>> >> 3 files changed, 890 insertions(+)
>> >>
>> >>diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
>> >>index e8c96b8..439f67c 100644
>> >>--- a/drivers/net/can/Kconfig
>> >>+++ b/drivers/net/can/Kconfig
>> >>@@ -129,6 +129,16 @@ config CAN_RCAR
>> >> 	  To compile this driver as a module, choose M here: the module will
>> >> 	  be called rcar_can.
>> >>
>> >>+config CAN_SUNXI
>> >>+	tristate "Allwinner SUNXI CAN controller"
>> >
>> >It would be better if we could mention that it's a driver for the
>> >sun4i family and derived.
>> 
>> I'm using it on Bpi with A20. AFAIK a SUN7I. Anyway I'm not aware
>> of all Allwinner SoCs. I will change it to any text you want.
> 
> CAN_SUN4I and Allwinner A10 CAN controller will do just fine.
> 
> Now that I'm thinking of it, can you also enable this driver in the
> sunxi and multi_v7 defconfigs please (in separate patches)?
> 
>> >We have no guarantee that there won't be any IP on other sunxi SoCs
>> >incompatible with this one that would need a new driver.
>> 
>> Right. IMHO A10 and A20 are working - maybe Fxx(?).
> 
> I was more thinking of the A31, A23, A80 and alike, but yeah, it might
> be true for the F20 too.
> 
>> >>+static int sunxican_open(struct net_device *dev)
>> >>+{
>> >>+	int err;
>> >>+
>> >>+	/* common open */
>> >>+	err = open_candev(dev);
>> >>+	if (err)
>> >>+		return err;
>> >>+
>> >>+	/* register interrupt handler */
>> >>+	err = request_irq(dev->irq, sunxi_can_interrupt, IRQF_SHARED,
>> >>+			  dev->name, dev);
>> >>+	if (err) {
>> >>+		netdev_err(dev, "request_irq err: %d\n", err);
>> >>+		close_candev(dev);
>> >>+		return -EAGAIN;
>> >>+	}
>> >>+
>> >>+	sunxi_can_start(dev);
>> >>+
>> >>+	can_led_event(dev, CAN_LED_EVENT_OPEN);
>> >>+
>> >>+	netif_start_queue(dev);
>> >>+
>> >>+	return 0;
>> >>+}
>> >>+
>> >>+static int sunxican_close(struct net_device *dev)
>> >>+{
>> >>+	struct sunxican_priv *priv = netdev_priv(dev);
>> >>+
>> >>+	netif_stop_queue(dev);
>> >>+	set_reset_mode(dev);
>> >>+	clk_disable_unprepare(priv->clk);
>> >
>> >Are you sure you have the right use count on that clock? You're
>> >calling sunxi_can_start from several places, but you call
>> >clk_disable_unprepare only from here.
>> 
>> I will check this (again).
>> 
>> >Even if it does start, it is really confusing. Please move the
>> >clk_prepare_enable in the open function.
>> 
>> That was my first approach. IMHO it's useful to enable/disable
>> according to the state of the CAN interface to save power.
> 
> Yes, it makes sense to have the clock enabled/disabled in open/close.
> 
> I was just saying that these calls should be balanced, and having the
> clk_prepare_enable in the sunxi_can_start doesn't help that.
> 
>> >>+static int __maybe_unused sunxi_can_suspend(struct device *device)
>> >>+{
>> >>+	struct net_device *dev = dev_get_drvdata(device);
>> >>+	struct sunxican_priv *priv = netdev_priv(dev);
>> >>+	u32 mode;
>> >>+	int err;
>> >>+
>> >>+	if (netif_running(dev)) {
>> >>+		netif_stop_queue(dev);
>> >>+		netif_device_detach(dev);
>> >>+	}
>> >>+
>> >>+	err = set_reset_mode(dev);
>> >>+	if (err)
>> >>+		return err;
>> >>+
>> >>+	mode = readl(priv->base + SUNXI_REG_MSEL_ADDR);
>> >>+	writel(mode | SUNXI_MSEL_SLEEP_MODE, priv->base +
>> >>SUNXI_REG_MSEL_ADDR);
>> >>+
>> >>+	priv->can.state = CAN_STATE_SLEEPING;
>> >>+
>> >>+	clk_disable(priv->clk);
>> >>+	return 0;
>> >>+}
>> >>+
>> >>+static int __maybe_unused sunxi_can_resume(struct device *device)
>> >>+{
>> >>+	struct net_device *dev = dev_get_drvdata(device);
>> >>+	struct sunxican_priv *priv = netdev_priv(dev);
>> >>+	u32 mode;
>> >>+	int err;
>> >>+
>> >>+	err = clk_enable(priv->clk);
>> >>+	if (err) {
>> >>+		netdev_err(dev, "clk_enable() failed, error %d\n", err);
>> >>+		return err;
>> >>+	}
>> >>+
>> >>+	err = set_reset_mode(dev);
>> >>+	if (err)
>> >>+		return err;
>> >>+
>> >>+	mode = readl(priv->base + SUNXI_REG_MSEL_ADDR);
>> >>+	writel(mode & ~(SUNXI_MSEL_SLEEP_MODE),
>> >>+	       priv->base + SUNXI_REG_MSEL_ADDR);
>> >>+	err = set_normal_mode(dev);
>> >>+	if (err)
>> >>+		return err;
>> >>+
>> >>+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>> >>+	if (netif_running(dev)) {
>> >>+		netif_device_attach(dev);
>> >>+		netif_start_queue(dev);
>> >>+	}
>> >>+	return 0;
>> >>+}
>> >>+
>> >>+static SIMPLE_DEV_PM_OPS(sunxi_can_pm_ops, sunxi_can_suspend,
>> >>sunxi_can_resume);
>> >
>> >How did you test those hooks? There's no suspend support yet.
>> 
>> I didn't test them.
> 
> Then remove them.
> 
>> >>+static struct platform_driver sunxi_can_driver = {
>> >>+	.driver = {
>> >>+		.name = DRV_NAME,
>> >>+		.pm = &sunxi_can_pm_ops,
>> >>+		.of_match_table = sunxican_of_match,
>> >>+	},
>> >>+	.probe = sunxican_probe,
>> >>+	.remove = sunxican_remove,
>> >>+};
>> >>+
>> >>+module_platform_driver(sunxi_can_driver);
>> >>+
>> >>+MODULE_AUTHOR("Peter Chen <xingkongcp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
>> >>+MODULE_AUTHOR("Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>");
>> >>+MODULE_LICENSE("Dual BSD/GPL");
>> >>+MODULE_DESCRIPTION(DRV_NAME "CAN driver for Allwinner SoCs (A10/A20)");
>> >>+MODULE_VERSION(DRV_MODULE_VERSION);
>> >
>> >Is this going to be useful?
>> >
>> >The module version is already redundant with the kernel version, and
>> >there's a good chance it will never reach 1.0.
>> 
>> Will remove the version number.
>> 
>> General remark:
>> 
>> Somebody asked me to add linux-sunxi dev list. Seems to be not a
>> good idea before the driver was ready. Seems to be hard to fulfill
>> the differentness.
>> 
>> I will remove linux-sunxi for the next patch set. I will try to get
>> linux-can people satisfied and then I'm done with it. I'm doing this
>> in my spare time, but it seems to get an endless story. I'm not
>> offended in any kind, my spare time is just limited.
>> 
>> The driver is working so far and the patches also apply to 4.3.
> 
> Cc'ing linux-sunxi is great, but it's an orthogonal issue.
> 
> Whenever you post a patch, you're supposed to Cc all the maintainers
> listed for the MAINTAINERS file, and the get_maintainers.pl script
> helps you with that.
> 
> If you use that script on your driver, you'll get:
> 
> ./scripts/get_maintainer.pl -f drivers/net/can/sunxi_can.c
> Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> (maintainer:CAN NETWORK 
> DRIVERS)
> Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (maintainer:CAN NETWORK DRIVERS)
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> (maintainer:ARM/Allwinner A1X SoC support)
> linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:CAN NETWORK DRIVERS)
> netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:NETWORKING DRIVERS)
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org (moderated list:ARM/Allwinner A1X
> SoC support)
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
> 
> All these people are supposed to be reviewing your driver, and while
> Marc will have a look at how your driver interact with the CAN
> framework, I'll have a look at how your driver interact with the rest
> of the code we did for the Allwinner SoCs. We look at different
> aspects, we have different kind of comments.
> 
> Maxime

I think I got it.

IMHO Marc did a very good job reviewing the code so far. If the 
SocketCAN
is happy with the code I will send the patch to the maintainer if Marc 
agree.

Regards

Gerd
