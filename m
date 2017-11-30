From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree bindings
Date: Thu, 30 Nov 2017 17:58:57 +0100
Message-ID: <F6036A58-9E98-4A62-950E-3396C9EE636E@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <20171124183509.12810-2-kernel@martin.sperl.org> <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop> <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org> <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de> <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org> <6aea8071-dc21-4ba7-2b2f-5af41b5755a5@posteo.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6aea8071-dc21-4ba7-2b2f-5af41b5755a5-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Patrick!

> On 30.11.2017, at 17:44, Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org> wrote:
>> How would you try to present that HW-configuration in the 
>> device tree instead?
>> How would it impact the driver design?
>> 
> Hi,
> I'm afraid I don't know what is best practice but you may want to look
> at the max310x driver which declares it's GPIOs and GPIO based
> interrupts in the regular driver.
> 
> drivers/tty/serial/max310x.c
> Documentation/devicetree/bindings/serial/maxim,max310x.txt
> Look for "#ifdef CONFIG_GPIOLIB”.

This is a gpio-controller, for which this is what I would implement.

The problem comes more from the fact that the mcp2517fd is
primarily a CAN controller, which has a few GPIO pins.

So implementing a gpio-controller for those (rarely used) GPIOs
in the same driver seems a bit of an overkill.

The mcp2515 chip also supports 5 GPIO pins, but the driver
does not really make use of them, so they are left out.

The problem here is more the fact that the mcp2517fd supports
also push-pull/open-drain on some of those gpios.

And at least openDrain may be required on TXCan if used on a network
without a transceiver…

> My first try would be a single dt node like the max310x uses in the dt
> example.
> Imho it is better to make things useful before making them complicated.

The settings as they are now are the “simple” version.
implementing a separate GPIO-controller driver just to implement the same
logic we have now would make it a much bigger driver without lots of extra
benefits.

So I hope the current proposal is ok...

Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
