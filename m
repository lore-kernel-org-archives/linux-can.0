From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 2/2] can: mcp2517fd: Add Microchip mcp2517fd CAN FD driver
Date: Sun, 3 Dec 2017 19:34:35 +0100
Message-ID: <78D816B0-7EBE-4C2A-ACFA-246C527AEB3A@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <20171124183509.12810-3-kernel@martin.sperl.org> <ff920dd7-4535-dcaa-27f9-57844ce66c7b@pengutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ff920dd7-4535-dcaa-27f9-57844ce66c7b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

H Marc!


> On 30.11.2017, at 14:04, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> 
> On 11/24/2017 07:35 PM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> This patch adds support for the Microchip mcp2517fd CAN-FD controller.
>> The mcp2517fd is capable of transmitting and receiving standard data
>> frames, extended data frames, remote frames and Can-FD frames.
>> The mcp2517fd interfaces with the host over SPI.
> 
> I've review about the last 1/3 of the driver. See comments inline.

Thanks for all the feedback!

I shall incorporate those into V2.

>> +	switch (priv->config.gpio0_mode) {
>> +	case gpio_mode_standby:
>> +	case gpio_mode_int: /* asserted low on TXIF */
>> +	case gpio_mode_out_low:
>> +	case gpio_mode_out_high:
>> +	case gpio_mode_in:
> 
> Please add comments for fallthrough for all your switch-case.


I thought /* fall through */ is only needed for the cases
where there is code involved in each case block and you want
to fall through to the next block - checkpatch only  complains 
in such conditions (there is one location in the driver -
in mcp2517fd_can_ist_handle_status - that requires /* fall through */).

Also Documentation/process/coding-style.rst shows such an example
in the “indentation” section, so I would assume this is valid code.

>> 
>> +int mcp2517fd_of_parse(struct mcp2517fd_priv *priv)
>> +{
>> +#ifdef CONFIG_OF_DYNAMIC
> 
> Why does this code depend on OF_DYNAMIC?
> 

Well - this is only in case of Device Tree - no need to include
all the DT-parsing in case that there is no DT support in the
first place…

I may arrange it as a #ifdef outside of the function 
(like the other case you have mentioned).

>> 
>> +	if (!IS_ERR(clk)) {
>> +		ret = clk_prepare_enable(clk);
>> +		if (ret)
>> +			goto out_free;
>> +	}
> 
> Why do you keep the clock running after the device has been probed?
> Usually we enable the clock during open().

I took the mcp251x as a blue-print and I believe it follows the
same pattern… 
But I may have simplified things during early driver development, 
so I will recheck it.

> 
>> +
>> +	/* check in device tree for overrrides */
>> +	ret = mcp2517fd_of_parse(priv);
>> +	if (ret)
>> +		return ret;
> 
> You're keeping the clock running.
See above - I shall look into it...

>> +			dev_err(&spi->dev,
>> +				"PLL clock frequency %i would exceed limit\n",
>> +				priv->can.clock.freq
>> +				);
>> +			return -EINVAL;
> 
> same here

Thanks, Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
