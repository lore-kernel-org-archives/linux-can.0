From: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Wed, 3 Jan 2018 18:09:33 +0530
Message-ID: <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aea8638a-c847-b55e-ff2d-37999980ba7b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi,

On Tuesday 02 January 2018 09:37 PM, Marc Kleine-Budde wrote:
> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>> From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>
>> Add support for PM Runtime which is the new way to handle managing clocks.
>> However, to avoid breaking SoCs not using PM_RUNTIME leave the old clk
>> management approach in place.
> 
> There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
> CONFIG_PM_RUNTIME")

Ok. Will change the commit message.

> 
> Have a look at the discussion: https://patchwork.kernel.org/patch/9436507/ :
> 
>>> Well, I admit it would be nicer if drivers didn't have to worry about 
>>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach 
>>> from the one outlined above would have the probe routine do this:
>>>
>>> 	my_power_up(dev);
>>> 	pm_runtime_set_active(dev);
>>> 	pm_runtime_get_noresume(dev);
>>> 	pm_runtime_enable(dev);

This discussion seems to be about cases in which CONFIG_PM is not
enabled. CONFIG_PM is always selected in the case of omap devices.

> 
>> PM_RUNTIME is required by OMAP based devices to handle clock management.
>> Therefore, this allows future Texas Instruments SoCs that have the MCAN IP
>> to work with this driver.
> 
> Who will set the SET_RUNTIME_PM_OPS in this case?

It is set with a common SET_RUNTIME_PM_OPS in the case of omap at
arch/arm/mach-omap2/omap_device.c:632

struct dev_pm_domain omap_device_pm_domain = {
        .ops = {
                SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
                                   NULL)
                USE_PLATFORM_PM_SLEEP_OPS
                SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq,
                                              _od_resume_noirq)
        }
};


> 
>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>> [nsekhar-l0cyMroinI0@public.gmane.org: handle pm_runtime_get_sync() failure, fix some bugs]
>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++----
>>  1 file changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index f72116e..53e764f 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/can/dev.h>
>>  
>> @@ -625,19 +626,33 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>  {
>>  	int err;
>>  
>> +	err = pm_runtime_get_sync(priv->device);
>> +	if (err) {
>> +		pm_runtime_put_noidle(priv->device);
> 
> Why do you call this in case of an error?

pm_runtime_get_sync() increments the usage count of the device before
any error is returned. This needs to be decremented using
pm_runtime_put_noidle().

> 
>> +		return err;
>> +	}
>> +
>>  	err = clk_prepare_enable(priv->hclk);
>>  	if (err)
>> -		return err;
>> +		goto pm_runtime_put;
>>  
>>  	err = clk_prepare_enable(priv->cclk);
>>  	if (err)
>> -		clk_disable_unprepare(priv->hclk);
>> +		goto disable_hclk;
>>  
>>  	return err;
>> +
>> +disable_hclk:
>> +	clk_disable_unprepare(priv->hclk);
>> +pm_runtime_put:
>> +	pm_runtime_put_sync(priv->device);
>> +	return err;
>>  }
>>  
>>  static void m_can_clk_stop(struct m_can_priv *priv)
>>  {
>> +	pm_runtime_put_sync(priv->device);
>> +
>>  	clk_disable_unprepare(priv->cclk);
>>  	clk_disable_unprepare(priv->hclk);
>>  }
>> @@ -1577,13 +1592,20 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>  	/* Enable clocks. Necessary to read Core Release in order to determine
>>  	 * M_CAN version
>>  	 */
>> +	pm_runtime_enable(&pdev->dev);
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (ret)  {
>> +		pm_runtime_put_noidle(&pdev->dev);
> 
> Why do you call this in case of error?

Same here.

Thanks,
Faiz

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
