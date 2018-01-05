From: "Yang, Wenyou" <Wenyou.Yang@Microchip.com>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Fri, 5 Jan 2018 09:23:32 +0800
Message-ID: <ce18f01b-e55a-9cb0-0b02-ab718be6a6fc@Microchip.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
 <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
 <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>
 <cb306ae5-87c5-f6ef-0c40-3b47e208d256@pengutronix.de>
 <6bdaab16-cb16-e039-473c-52dd295bd4ba@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:43010 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeAEBXl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 20:23:41 -0500
In-Reply-To: <6bdaab16-cb16-e039-473c-52dd295bd4ba@ti.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, sergei.shtylyov@cogentembedded.com



On 2018/1/4 23:17, Faiz Abbas wrote:
> Hi,
>
> On Wednesday 03 January 2018 08:47 PM, Marc Kleine-Budde wrote:
>> On 01/03/2018 04:06 PM, Faiz Abbas wrote:
>>> Hi,
>>>
>>> On Wednesday 03 January 2018 07:55 PM, Marc Kleine-Budde wrote:
>>>> On 01/03/2018 01:39 PM, Faiz Abbas wrote:
>>>>> On Tuesday 02 January 2018 09:37 PM, Marc Kleine-Budde wrote:
>>>>>> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>>>>>>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>>>
>>>>>>> Add support for PM Runtime which is the new way to handle managing clocks.
>>>>>>> However, to avoid breaking SoCs not using PM_RUNTIME leave the old clk
>>>>>>> management approach in place.
>>>>>> There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
>>>>>> CONFIG_PM_RUNTIME")
>>>>> Ok. Will change the commit message.
>>>>>
>>>>>> Have a look at the discussion: https://patchwork.kernel.org/patch/9436507/ :
>>>>>>
>>>>>>>> Well, I admit it would be nicer if drivers didn't have to worry about
>>>>>>>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach
>>>>>>>> from the one outlined above would have the probe routine do this:
>>>>>>>>
>>>>>>>> 	my_power_up(dev);
>>>>>>>> 	pm_runtime_set_active(dev);
>>>>>>>> 	pm_runtime_get_noresume(dev);
>>>>>>>> 	pm_runtime_enable(dev);
>>>>> This discussion seems to be about cases in which CONFIG_PM is not
>>>>> enabled. CONFIG_PM is always selected in the case of omap devices.
>>>> Yes, but in the commit message you state that you need to support
>>>> systems that don't have PM_RUNTIME enabled. The only mainline SoCs I see
>>>> is "arch/arm/boot/dts/sama5d2.dtsi" so far. Please check if they select
>>>> CONFIG_PM, then we can make the driver much simpler.
>>> Actually the old clock management (for hclk which is the interface
>>> clock) is still required as mentioned in the cover letter. Will change
>>> the rather misleading description.
>> Ok. So you can use the code as discussed on
>> https://patchwork.kernel.org/patch/9436507/ ?
> Looking at the kernel configuration, it seems like SAMA5D2 platform
> selects CONFIG_PM (Wenyou, please confirm).
Confirmed.  The CONFIG_PM is selected.

> So, it seems like the only
> users of this driver always have CONFIG_PM enabled.
>
> So I guess the best way is to maintain the current code for pm_runtime_*
> and move the clock enable/disable to pm_runtime callbacks.
>
> Something like this:
>
> m_can_runtime_resume()
> {
> 	clk_prepare_enable(cclk);
> 	clk_prepare_enable(hclk);
> }
>
> m_can_runtime_suspend()
> {
> 	clk_disable_unprepare(cclk);
> 	clk_disable_unprepare(hclk);
> }
>
> SET_RUNTIME_PM_OPS(m_can_runtime_suspend, m_can_runtime_resume, NULL)
>
> static void m_can_start(struct net_device *dev)
> {
> 	pm_runtime_get_sync(dev)
> 	...
> }
>
> static void m_can_stop(struct net_device *dev)
> {
> 	...
> 	pm_runtime_put_sync(dev)
> }
>
> Does that sound okay? If yes, I will go work on the implementation.
>
> Thanks,
> Faiz
Best Regards,
Wenyou Yang
