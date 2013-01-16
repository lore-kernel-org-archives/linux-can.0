From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 3/3] can: c_can: Enable clock before first use
Date: Wed, 16 Jan 2013 09:54:38 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAED247@DBDE01.ent.ti.com>
References: <cover.1355996839.git.amit.virdi@st.com>
 <3ce526df6a4f9e71f8b05132689db7426bae6bbb.1355996839.git.amit.virdi@st.com>
 <50D31B96.8010501@pengutronix.de> <50F65ECF.6070802@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53594 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756830Ab3APJzH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jan 2013 04:55:07 -0500
In-Reply-To: <50F65ECF.6070802@st.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, spear-devel <spear-devel@list.st.com>, "rjw@sisk.pl" <rjw@sisk.pl>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

+Rafael +arm list

On Wed, Jan 16, 2013 at 13:33:27, Amit Virdi wrote:
> On 12/20/2012 7:37 PM, Marc Kleine-Budde wrote:
> > On 12/20/2012 11:05 AM, Amit Virdi wrote:
> >> Current implementation assumes clock to be always enabled. Instead,
> >> explicitly enable device clock before usage.
> >>
> >> Signed-off-by: Amit Virdi<amit.virdi@st.com>
> >> Reviewed-by: Shiraz Hashim<shiraz.hashim@st.com>
> >> ---
> >>   drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> >> index 6e8dc56..d0bd6e6 100644
> >> --- a/drivers/net/can/c_can/c_can_platform.c
> >> +++ b/drivers/net/can/c_can/c_can_platform.c
> >> @@ -194,6 +194,12 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> >>   		goto exit;
> >>   	}
> >>
> >> +	ret = clk_prepare_enable(clk);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "could not prepare CAN clock\n");
> >> +		goto exit_no_clk_en;
> >> +	}
> >> +
> >>   	/* get the platform data */
> >>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>   	irq = platform_get_irq(pdev, 0);
> >> @@ -295,6 +301,8 @@ exit_iounmap:
> >>   exit_release_mem:
> >>   	release_mem_region(mem->start, resource_size(mem));
> >>   exit_free_clk:
> >> +	clk_disable_unprepare(clk);
> >> +exit_no_clk_en:
> >>   	clk_put(clk);
> >>   exit:
> >>   	dev_err(&pdev->dev, "probe failed\n");
> >
> > Why do you have to enable the clock if the driver is loaded? What about
> > disabling the clock on driver unload. The clock should be enabled on
> > open and disabled on close if the network interface. If you need to
> > access the registers of your hardware, you should enable the clock
> > before accessing the regs and disable the clock when finished.
> >
> 
> Okay, I would take care of it in V2.

Hi Amit,

As Marc said clock enable/disable should be in sync with open/
close functions. I think pm_runtime calls should take care of
clock control. In your case you have to create a wrapper which
exports runtime pm hooks, which should internally handle the
clock enable/disable.

If we add clock specific calls to the driver, then driver might
break on the platforms which has runtime pm implemented because
runtime pm support to the c_can driver is already added.

Rafael,

Do you have any suggestions here? Am I missing anything here?

Thanks & Regards
AnilKumar
