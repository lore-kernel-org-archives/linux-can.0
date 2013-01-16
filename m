From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] can: c_can: Enable clock before first use
Date: Wed, 16 Jan 2013 14:53:52 +0100
Message-ID: <13456506.QKLrCBvTjZ@vostro.rjw.lan>
References: <cover.1355996839.git.amit.virdi@st.com> <50F65ECF.6070802@st.com> <331ABD5ECB02734CA317220B2BBEABC13EAED247@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41879 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab3APNsB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Jan 2013 08:48:01 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAED247@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Amit Virdi <amit.virdi@st.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, spear-devel <spear-devel@list.st.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Wednesday, January 16, 2013 09:54:38 AM AnilKumar, Chimata wrote:
> +Rafael +arm list
> 
> On Wed, Jan 16, 2013 at 13:33:27, Amit Virdi wrote:
> > On 12/20/2012 7:37 PM, Marc Kleine-Budde wrote:
> > > On 12/20/2012 11:05 AM, Amit Virdi wrote:
> > >> Current implementation assumes clock to be always enabled. Instead,
> > >> explicitly enable device clock before usage.
> > >>
> > >> Signed-off-by: Amit Virdi<amit.virdi@st.com>
> > >> Reviewed-by: Shiraz Hashim<shiraz.hashim@st.com>
> > >> ---
> > >>   drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
> > >>   1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > >> index 6e8dc56..d0bd6e6 100644
> > >> --- a/drivers/net/can/c_can/c_can_platform.c
> > >> +++ b/drivers/net/can/c_can/c_can_platform.c
> > >> @@ -194,6 +194,12 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> > >>   		goto exit;
> > >>   	}
> > >>
> > >> +	ret = clk_prepare_enable(clk);
> > >> +	if (ret) {
> > >> +		dev_err(&pdev->dev, "could not prepare CAN clock\n");
> > >> +		goto exit_no_clk_en;
> > >> +	}
> > >> +
> > >>   	/* get the platform data */
> > >>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >>   	irq = platform_get_irq(pdev, 0);
> > >> @@ -295,6 +301,8 @@ exit_iounmap:
> > >>   exit_release_mem:
> > >>   	release_mem_region(mem->start, resource_size(mem));
> > >>   exit_free_clk:
> > >> +	clk_disable_unprepare(clk);
> > >> +exit_no_clk_en:
> > >>   	clk_put(clk);
> > >>   exit:
> > >>   	dev_err(&pdev->dev, "probe failed\n");
> > >
> > > Why do you have to enable the clock if the driver is loaded? What about
> > > disabling the clock on driver unload. The clock should be enabled on
> > > open and disabled on close if the network interface. If you need to
> > > access the registers of your hardware, you should enable the clock
> > > before accessing the regs and disable the clock when finished.
> > >
> > 
> > Okay, I would take care of it in V2.
> 
> Hi Amit,
> 
> As Marc said clock enable/disable should be in sync with open/
> close functions. I think pm_runtime calls should take care of
> clock control. In your case you have to create a wrapper which
> exports runtime pm hooks, which should internally handle the
> clock enable/disable.
> 
> If we add clock specific calls to the driver, then driver might
> break on the platforms which has runtime pm implemented because
> runtime pm support to the c_can driver is already added.
> 
> Rafael,
> 
> Do you have any suggestions here? Am I missing anything here?

No, you aren't.

Clock-specific hooks in the driver (outside of its PM callbacks) may not work
or worse yet may cause problems to happen on platforms where PM is handled
via ACPI, for example.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
