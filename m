From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
Date: Fri, 14 Feb 2020 09:42:40 +0100
Message-ID: <2322fb83486c678917957d9879e27e63@walle.cc>
References: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
 <20200213192027.4813-1-michael@walle.cc>
 <DB7PR04MB461896B6CC3EDC7009BCD741E6150@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB461896B6CC3EDC7009BCD741E6150@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, Pankaj Bansal <pankaj.bansal@nxp.com>
List-Id: linux-can.vger.kernel.org

Hi Joakim,

Am 2020-02-14 02:55, schrieb Joakim Zhang:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: 2020年2月14日 3:20
>> To: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Joakim Zhang <qiangqing.zhang@nxp.com>; wg@grandegger.com;
>> netdev@vger.kernel.org; linux-can@vger.kernel.org; Pankaj Bansal
>> <pankaj.bansal@nxp.com>; Michael Walle <michael@walle.cc>
>> Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP 
>> Flexcan
>> 
>> Hi,
>> 
>> >>> Are you prepared to add back these patches as they are necessary for
>> >>> Flexcan CAN FD? And this Flexcan CAN FD patch set is based on these
>> >>> patches.
>> >>
>> >> Yes, these patches will be added back.
>> >
>> >I've cleaned up the first patch a bit, and pushed everything to the
>> >testing branch. Can you give it a test.
>> 
>> What happend to that branch? FWIW I've just tried the patches on a 
>> custom
>> board with a LS1028A SoC. Both CAN and CAN-FD are working. I've tested
>> against a Peaktech USB CAN adapter. I'd love to see these patches 
>> upstream,
>> because our board also offers CAN and basic support for it just made 
>> it
>> upstream [1].
> The FlexCAN CAN FD related patches have stayed in
> linux-can-next/flexcan branch for a long time, I still don't know why
> Marc doesn't merge them into Linux mainline.
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/?h=flexcan
> Also must hope that this patch set can be upstreamed soon. :-)

I've took them from this branch and applied them to the latest linux 
master.

Thus,

Tested-by: Michael Walle <michael@walle.cc>


>> If these patches are upstream, only the device tree nodes seems to be 
>> missing.
>> I don't know what has happened to [2]. But the patch doesn't seem to 
>> be
>> necessary.
> Yes, this patch is unnecessary. I have NACKed this patch for that,
> according to FlexCAN Integrated Guide, CTRL1[CLKSRC]=0 select
> oscillator clock and CTRL1[CLKSRC]=1 select peripheral clock.
> But it is actually decided by SoC integration, for i.MX, the design is
> different.

ok thanks for clarifying.

> I have not upstream i.MX FlexCAN device tree nodes, since it's
> dependency have not upstreamed yet.
> 
>> Pankaj already send a patch to add the device node to the LS1028A [3].
>> Thats basically the same I've used, only that mine didn't had the
>> "fsl,ls1028ar1-flexcan" compatiblity string, but only the 
>> "lx2160ar1-flexcan"
>> which is the correct way to use it, right?
> You can see below table from FlexCAN driver, "fsl,lx2160ar1-flexcan"
> supports CAN FD, you can use this compatible string.

correct. I've already a patch that does exactly this ;) Who would take 
the
patch for adding the LS1028A can device tree nodes to ls1028a.dtsi? You 
or
Shawn Guo?

> static const struct of_device_id flexcan_of_match[] = {
> 	{ .compatible = "fsl,imx8qm-flexcan", .data = 
> &fsl_imx8qm_devtype_data, },
> 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, 
> },
> 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, 
> },
> 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, 
> },
> 	{ .compatible = "fsl,imx35-flexcan", .data = &fsl_imx25_devtype_data, 
> },
> 	{ .compatible = "fsl,imx25-flexcan", .data = &fsl_imx25_devtype_data, 
> },
> 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, 
> },
> 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, 
> },
> 	{ .compatible = "fsl,ls1021ar2-flexcan", .data =
> &fsl_ls1021a_r2_devtype_data, },
> 	{ .compatible = "fsl,lx2160ar1-flexcan", .data =
> &fsl_lx2160a_r1_devtype_data, },
> 	{ /* sentinel */ },
> };
> 

-michael
