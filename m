From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree bindings
Date: Sun, 17 Dec 2017 15:34:28 +0100
Message-ID: <4E2DB518-A148-46CE-8267-73D292991BD2@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <20171124183509.12810-2-kernel@martin.sperl.org> <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop> <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org> <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de> <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org> <6aea8071-dc21-4ba7-2b2f-5af41b5755a5@posteo.de> <F6036A58-9E98-4A62-950E-3396C9EE636E@martin.sperl.org> <1ac487f7-17e3-c8a0-0f99-8138fe867373@posteo.de> <f83be38e-1a44-79cc-4cdb-f26d8c8a5c61@martin.sperl.org> <d79ee9eb-8b36-0086-8d76-ec6bca224fe5@posteo.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d79ee9eb-8b36-0086-8d76-ec6bca224fe5-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Patrick!

So I started implementing the GPIO_LIB implementation but
I have hit an issue where I would like to get some feedback.

So in principle the gpiolib works, but only if the device is
not asleep and the clock is enabled, which at this very moment means
that the can interface has to be up and running.

So at this very moment the only option that I see would be to
disable the sleep mode which the device enters after probing until
the can-network interface is enabled (which enables the clock and
start the oscillator) - with SLEEP enabled when GPIOLIB support
is disabled.

This is obviously not optimal from the power perspective…

The other option would be starting the clock and oscillator
as soon as a set_direction* (or reques/free) function is called.
(where I would need to start using locks to avoid race conditions
as well as clock usage counters...).

Which of the above is the preferred solution? Are there other ideas
how I could solve this dilemma?


Martin

> On 05.12.2017, at 19:28, Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org> wrote:
> 
> Hi Martin,
> 
> it depends on the daily usage of those alternate functions.
> I just took a quick glimpse on the datasheet and if you check appendix B table 9-1 , you'll see that some functions are optional because ISO suggested them, not because there is a practical reason for it.
> 
> CLKO/SOF does make little to no sense with a higher grade embedded system. CLKO is meant to share the osc with the microcontroller.
>> The CLKO pin provides the clock to the
>> microcontroller.
> SOF makes sense for testing in lab configuration, not for regular operation.
> 
> TXCAN also does make little sense as you can only use it in the lab.
>> TXCANOD: TXCAN can be configured as Push-
>> Pull or as Open Drain out
>> put. Open Drain outputs
>> allows the user to connect multiple controllers
>> together to build a CAN network without using a
>> transceiver.
> 
> INTOD is initialized as Push/Pull. Configuring it open drain would be processor specific when the microcontroller has limited options for pin-ctrl, e.g. some PICs.
>> INTOD:
>> Interrupt pins Open Drain Mode
>> 1
>> = Open Drain Output
>> 0
>> = Push/Pull Output
> 
> To sum it up, I would drop:
> - CLKO/SOF
> - TXCAN
> - INTOD
> 
> I would implement higher level functions in a second step for INT0/GPIO0/XSTBY and INT1/GPIO1.
> Such functions can be:
> - power saving via XSTBY
> - RX / TX LEDs via INT0 / INT1
> 
> Actually this second step would wait until a request for feature arises.
> 
> Regards,
> Patrick
> 
> Am 05.12.2017 um 11:26 schrieb Martin Sperl:
>> Hi Patrick! 
>> 
>> 
>> I had a quick look starting to implement gpiolib, 
>> 
>> but I believe I would need to implement pin-ctrl on top to 
>> 
>> make the Alternate functions work propperly. 
>> 
>> I wonder if this effort is really worth it. 
>> 
>> Martin 
>> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
