From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 20:29:33 +0200
Message-ID: <4F85CD8D.9070107@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F852161.90706@hartkopp.net> <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:48652 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab2DKS3b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 14:29:31 -0400
In-Reply-To: <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

On 11.04.2012 19:58, Fabio Baltieri wrote:


> On Wed, Apr 11, 2012 at 8:14 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> I wonder if it makes more sense to add the LED trigger stuff into
>> drivers/net/can/dev.c ?!?
> 
> Of course that seems to be the obvious (=correct) place to trap this
> stuff. The reason why I worked on upper layer is that I did not found
> any generic place to trap tx/rx events in the dev file without
> modifying every device driver, as while tx can be trapped in
> can_get_echo_skb(), rx frames are handled directly to the network
> layer.


I think that depends heavily on the driver and therefore adding the
can_led_tx() and can_led_rx() calls to the appropriate places is the most
transparent implementation.

IMO i would not(!) hide can_led_tx() in can_get_echo_skb() but place it next to
it in the interrupt function.

> 
>> Of course the correct calling points to trigger the rx/tx-LEDs need to be
>> implemented inside *each* driver at the correct position.
> 
> That's the point. So, do you think it would be better to add trigger
> functions into dev.c and modify each driver to call them?


Yes - as described above - something like this:

$ diff -U6 drivers/net/can/sja1000/sja1000.c drivers/net/can/sja1000/sja1000.c-new
--- drivers/net/can/sja1000/sja1000.c	2012-02-27 19:37:56.440594122 +0100
+++ drivers/net/can/sja1000/sja1000.c-new	2012-04-11 20:26:11.089344979 +0200
@@ -505,24 +505,26 @@
 			netdev_warn(dev, "wakeup interrupt\n");
 
 		if (isrc & IRQ_TI) {
 			/* transmission complete interrupt */
 			stats->tx_bytes += priv->read_reg(priv, REG_FI) & 0xf;
 			stats->tx_packets++;
+			can_led_tx(dev);
 			can_get_echo_skb(dev, 0);
 			netif_wake_queue(dev);
 		}
 		if (isrc & IRQ_RI) {
 			/* receive interrupt */
 			while (status & SR_RBS) {
 				sja1000_rx(dev);
 				status = priv->read_reg(priv, REG_SR);
 				/* check for absent controller */
 				if (status == 0xFF && sja1000_is_absent(priv))
 					return IRQ_NONE;
 			}
+			can_led_rx(dev);
 		}
 		if (isrc & (IRQ_DOI | IRQ_EI | IRQ_BEI | IRQ_EPI | IRQ_ALI)) {
 			/* error interrupt */
 			if (sja1000_err(dev, isrc, status))
 				break;
 		}



>> The question would be, if this code
>>
>>> +     if (!timer_pending(&priv->tx_off_timer)) {
>>> +             led_trigger_event(priv->tx_led, LED_FULL);
>>> +
>>> +             mod_timer(&priv->tx_off_timer,
>>> +                     jiffies + msecs_to_jiffies(led_off_delay));
>>> +     }
>>
>>
>> is ready to be used in hard IRQ context?
>>
>> If not we may use a construct with a tasklet that can be triggered from hard
>> IRQ context, like here:
>>
>>        http://lxr.linux.no/#linux+v3.3.1/net/can/bcm.c#L356
> 
> I think that led_trigger_event is ok as long as the actual
> led-<device>'s brigthness_set function is safe - for example
> leds-gpio's one seems to make some check about it. See:
> 
> http://lxr.linux.no/#linux+v3.3.1/drivers/leds/leds-gpio.c#L70
> 
> Will think about it.


Fine. So i'm looking forward to v2 :-)

Regards,
Oliver
