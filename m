From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
Date: Thu, 14 Mar 2019 11:28:24 +0100
Message-ID: <98eb1a7c-6a1d-c082-eada-ab84f95fcf19@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314093659.srtlgqljcasbawva@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190314093659.srtlgqljcasbawva@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On 14/03/2019 10.36, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 13, 2019 at 09:26:15PM +0100, Rasmus Villemoes wrote:
>> It can be quite convenient to initialize a netdev-triggered LED with a
>> device name and setting the rx,tx,link properties from device tree,
>> instead of having to do that in an init script in userspace.
> 
> Well, you'd do this in an udev rule instead of an init script.

Perhaps, if my userspace had udev. But even then, if I have to modify my
userspace in order to upgrade the kernel (which is what I'm trying to
avoid, for a number of reasons), I'd probably still do it in a
seven-line init script instead of trying to wrap my head around
udev/mdev rule writing.

Initializing the netdev trigger from DT data is certainly in line with
what is possible for certain other triggers via the led-pattern property.

Just out of curiosity, do you have a udev rule (template) for this?

>>  
>> +                The optional child node netdev can be used to
>> +                configure initial values for the link, rx, tx and
>> +                device_name properties. For example, setting
>> +                linux,default-trigger = "netdev" and adding the child
>> +                node
>> +
>> +                netdev {
>> +                    rx;
>> +                    tx;
>> +                    link;
>> +                    device-name = "can0";
> 
> Maybe make this:
> 
> 	device = <&can0>;

Huh? I don't think there's any guarantee that the netdevice has a DT
node/phandle, and even if it did, how would the init code map from that
phandle to the string it should fill into ->device_name? Since DT
natively has bools and strings, it's much more natural to just use those
types which map nicely to the sysfs properties.

> ?
> 
>> +                };
>> +
>> +                can be used to replace 'linux,default-trigger =
>> +                "can0-rxtx"' that relies on the deprecated
>> +                CONFIG_CAN_LEDS.
> 
> Mentioning "CONFIG_CAN_LEDS" is wrong for a binding document that is
> supposed to be independent from the kernel.

Well, this is in relation to the already linux-specific
linux,default-trigger binding. But I can certainly reword this to a
simple example that doesn't mention what it replaces and why, and just
move the mentioning of CONFIG_CAN_LEDS to the commit message.

>>  - led-pattern : Array of integers with default pattern for certain triggers.
>>                  Each trigger may parse this property differently:
>>                  - one-shot : two numbers specifying delay on and delay off (in ms),
>> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
>> index 55153a7e8433..1f7c86df1e91 100644
>> --- a/drivers/leds/trigger/ledtrig-netdev.c
>> +++ b/drivers/leds/trigger/ledtrig-netdev.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/netdevice.h>
>> +#include <linux/of.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/timer.h>
>>  #include "../leds.h"
>> @@ -395,6 +396,35 @@ static void netdev_trig_work(struct work_struct *work)
>>  			(atomic_read(&trigger_data->interval)*2));
>>  }
>>  
>> +static void netdev_trig_of_init(struct led_classdev *led_cdev,
>> +				struct led_netdev_data *trigger_data)
>> +{
>> +	struct device_node *np = led_cdev->dev->of_node;
>> +	const char *device_name;
>> +
>> +	if (!np)
>> +		return;
>> +	np = of_get_child_by_name(np, "netdev");
>> +	if (!np)
>> +		return;
>> +
>> +	if (of_property_read_bool(np, "link"))
>> +		__set_bit(NETDEV_LED_LINK, &trigger_data->mode);
>> +	if (of_property_read_bool(np, "tx"))
>> +		__set_bit(NETDEV_LED_TX, &trigger_data->mode);
>> +	if (of_property_read_bool(np, "rx"))
>> +		__set_bit(NETDEV_LED_RX, &trigger_data->mode);
>> +	if (!of_property_read_string(np, "device-name", &device_name)) {
>> +		unsigned len = strlen(device_name);
>> +
>> +		if (len < IFNAMSIZ)
>> +			set_device(trigger_data, device_name, len);
> 
> if set_device contained the length check you'd have it in only one
> place.

I considered that, but rejected it because it complicates the existing
user of set_device() (where the call happens under a lock; from the
_of_init function, nobody else knows about the trigger_data instance
yet). But on second thought, I think you're right that it's better done
in that one place. So I'll refactor.

>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
>> index e0f0ad7a550a..91703a96b636 100644
>> --- a/drivers/net/can/Kconfig
>> +++ b/drivers/net/can/Kconfig
>> @@ -77,7 +77,8 @@ config CAN_LEDS
>>  	# everything that this driver is doing. This is marked as broken
>>  	# because it uses stuff that is intended to be changed or removed.
>>  	# Please consider switching to the netdev trigger and confirm it
>> -	# fulfills your needs instead of fixing this driver.
>> +	# fulfills your needs instead of fixing this driver. See e.g.
>> +	# Documentation/devicetree/bindings/leds/common.txt
>>  	depends on BROKEN
>>  	select LEDS_TRIGGERS
>>  	---help---
> 
> This hunk can better live in the patch adding to
> Documentation/devicetree/bindings/leds/common.txt or a separate patch.

OK, will move to separate patch.

Rasmus
