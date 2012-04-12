From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 08:16:41 +0200
Message-ID: <4F867349.9070008@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F852161.90706@hartkopp.net> <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com> <4F85CD8D.9070107@hartkopp.net> <4F85D46B.9050704@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:38314 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756917Ab2DLGQj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 02:16:39 -0400
In-Reply-To: <4F85D46B.9050704@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

On 11.04.2012 20:58, Wolfgang Grandegger wrote:

> On 04/11/2012 08:29 PM, Oliver Hartkopp wrote:
>> On 11.04.2012 19:58, Fabio Baltieri wrote:
>>
>>
>>> On Wed, Apr 11, 2012 at 8:14 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>>>> I wonder if it makes more sense to add the LED trigger stuff into
>>>> drivers/net/can/dev.c ?!?
>>>
>>> Of course that seems to be the obvious (=correct) place to trap this
>>> stuff. The reason why I worked on upper layer is that I did not found
>>> any generic place to trap tx/rx events in the dev file without
>>> modifying every device driver, as while tx can be trapped in
>>> can_get_echo_skb(), rx frames are handled directly to the network
>>> layer.
>>
>>
>> I think that depends heavily on the driver and therefore adding the
>> can_led_tx() and can_led_rx() calls to the appropriate places is the most
>> transparent implementation.
> 
> I would prefer to implement can_led_trigger (or can_led_event) passing a
> mask defining the event (RX, TX or event something else).
> 


Yes. Good idea.

What about passing the pointer to some kind of can_led_handler struct, e.g.

struct can_led_handler {
	struct timer_list off_timer;
	struct led_trigger *led;
	char led_name[32];
}

which is part of struct can_priv then:

+#ifdef CONFIG_CAN_LEDS
+	struct can_led_handler can_tx_led, can_rx_lead;
+#endif

Then we could use in the interrupt:

(..)
	can_led_trigger(&priv->can_tx_led)
(..)

This would omit the check for flags and directly work on the correct LEDs.


Regards,
Oliver
