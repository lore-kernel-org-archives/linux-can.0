From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Wed, 3 Jan 2018 20:36:59 +0530
Message-ID: <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
 <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

Hi,

On Wednesday 03 January 2018 07:55 PM, Marc Kleine-Budde wrote:
> On 01/03/2018 01:39 PM, Faiz Abbas wrote:
>> On Tuesday 02 January 2018 09:37 PM, Marc Kleine-Budde wrote:
>>> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>>>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>>>
>>>> Add support for PM Runtime which is the new way to handle managing clocks.
>>>> However, to avoid breaking SoCs not using PM_RUNTIME leave the old clk
>>>> management approach in place.
>>>
>>> There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
>>> CONFIG_PM_RUNTIME")
>>
>> Ok. Will change the commit message.
>>
>>>
>>> Have a look at the discussion: https://patchwork.kernel.org/patch/9436507/ :
>>>
>>>>> Well, I admit it would be nicer if drivers didn't have to worry about 
>>>>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach 
>>>>> from the one outlined above would have the probe routine do this:
>>>>>
>>>>> 	my_power_up(dev);
>>>>> 	pm_runtime_set_active(dev);
>>>>> 	pm_runtime_get_noresume(dev);
>>>>> 	pm_runtime_enable(dev);
>>
>> This discussion seems to be about cases in which CONFIG_PM is not
>> enabled. CONFIG_PM is always selected in the case of omap devices.
> 
> Yes, but in the commit message you state that you need to support
> systems that don't have PM_RUNTIME enabled. The only mainline SoCs I see
> is "arch/arm/boot/dts/sama5d2.dtsi" so far. Please check if they select
> CONFIG_PM, then we can make the driver much simpler.

Actually the old clock management (for hclk which is the interface
clock) is still required as mentioned in the cover letter. Will change
the rather misleading description.

Thanks,
Faiz

> 
>>>> PM_RUNTIME is required by OMAP based devices to handle clock management.
>>>> Therefore, this allows future Texas Instruments SoCs that have the MCAN IP
>>>> to work with this driver.
>>>
>>> Who will set the SET_RUNTIME_PM_OPS in this case?
>>
>> It is set with a common SET_RUNTIME_PM_OPS in the case of omap at
>> arch/arm/mach-omap2/omap_device.c:632
>>
>> struct dev_pm_domain omap_device_pm_domain = {
>>         .ops = {
>>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
>>                                    NULL)
>>                 USE_PLATFORM_PM_SLEEP_OPS
>>                 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq,
>>                                               _od_resume_noirq)
>>         }
>> };
>>
>>
>>>
>>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>>> [nsekhar@ti.com: handle pm_runtime_get_sync() failure, fix some bugs]
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>  drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++----
>>>>  1 file changed, 34 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>>> index f72116e..53e764f 100644
>>>> --- a/drivers/net/can/m_can/m_can.c
>>>> +++ b/drivers/net/can/m_can/m_can.c
>>>> @@ -23,6 +23,7 @@
>>>>  #include <linux/of.h>
>>>>  #include <linux/of_device.h>
>>>>  #include <linux/platform_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>  #include <linux/iopoll.h>
>>>>  #include <linux/can/dev.h>
>>>>  
>>>> @@ -625,19 +626,33 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>>>  {
>>>>  	int err;
>>>>  
>>>> +	err = pm_runtime_get_sync(priv->device);
>>>> +	if (err) {
>>>> +		pm_runtime_put_noidle(priv->device);
>>>
>>> Why do you call this in case of an error?
>>
>> pm_runtime_get_sync() increments the usage count of the device before
>> any error is returned. This needs to be decremented using
>> pm_runtime_put_noidle().
> 
> Oh, I'm curious how many drivers don't get this right.
> 
> Marc
> 
