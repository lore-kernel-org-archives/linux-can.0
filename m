From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree
 bindings
Date: Tue, 5 Dec 2017 11:26:59 +0100
Message-ID: <f83be38e-1a44-79cc-4cdb-f26d8c8a5c61@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <20171124183509.12810-2-kernel@martin.sperl.org>
 <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
 <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org>
 <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
 <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org>
 <6aea8071-dc21-4ba7-2b2f-5af41b5755a5@posteo.de>
 <F6036A58-9E98-4A62-950E-3396C9EE636E@martin.sperl.org>
 <1ac487f7-17e3-c8a0-0f99-8138fe867373@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1ac487f7-17e3-c8a0-0f99-8138fe867373-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Patrick!


I had a quick look starting to implement gpiolib,

but I believe I would need to implement pin-ctrl on top to

make the Alternate functions work propperly.

I wonder if this effort is really worth it.

Martin

On 11/30/2017 06:49 PM, Patrick Menschel wrote:
> Am 30.11.2017 um 17:58 schriebkernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
>>> drivers/tty/serial/max310x.c
>>> Documentation/devicetree/bindings/serial/maxim,max310x.txt
>>> Look for "#ifdef CONFIG_GPIOLIB”.
>> This is a gpio-controller, for which this is what I would implement.
>>
> Hi,
>
> you are mistaken about that, max310x chips are spi to uart bridges with
> strong ties to rs485 which is very similar to CAN except for the missing
> arbitration in hardware. Max14830 has GPIOs with clocking support, so
> this chip's driver also fused the main function with secondary gpio
> functions.
> https://datasheets.maximintegrated.com/en/ds/MAX14830.pdf
>
> Anyway I'm curious what is best practice for this sort of configuration.
>
> Regards,
> Patrick
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
