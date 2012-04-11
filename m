From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 19:58:05 +0200
Message-ID: <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
	<4F852161.90706@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44340 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508Ab2DKR6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 13:58:08 -0400
Received: by wgbdr13 with SMTP id dr13so1162356wgb.1
        for <linux-can@vger.kernel.org>; Wed, 11 Apr 2012 10:58:06 -0700 (PDT)
In-Reply-To: <4F852161.90706@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

thanks for the feedback!

You addressed all the concerns I had while writing the patch. See inlin=
e:

On Wed, Apr 11, 2012 at 8:14 AM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> at first i REALLY LIKE blinkenlights :-)

I know the feeling! :-)

>> @@ -52,6 +54,13 @@ struct can_priv {
>>
>> =A0 =A0 =A0 unsigned int echo_skb_max;
>> =A0 =A0 =A0 struct sk_buff **echo_skb;
>> +
>> +#ifdef CONFIG_CAN_LEDS
>> + =A0 =A0 struct timer_list tx_off_timer, rx_off_timer;
>> + =A0 =A0 struct led_trigger *tx_led, *rx_led;
>> + =A0 =A0 char tx_led_name[32], rx_led_name[32];
>> + =A0 =A0 atomic_t led_discard_count;
>> +#endif
>> =A0};
>
>
> Why don't you add struct led_trigger directly here, as it makes the t=
wo
> kzalloc calls in =A0can_led_init() obsolete?
>
> Struct can_priv is allocated anyway and therefore you do not take car=
e of the
> removal of your privately allocated memory.

Sounds good to me, I'll keep that in mind for a v2.

> Now looking into the tx path LEDs as an example:
>
>> +/* This is used to ignore devices not based on the can-dev framewor=
k */
>> +static int rtnl_link_kind_is(struct net_device *netdev, const char =
*kind)
>> +{
>> + =A0 =A0 if (netdev->rtnl_link_ops &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 strncmp(kind, netdev->rtnl_link_ops->kind,=
 strlen(kind)) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +}
>
>
> You do this costly compare with *each* tx/rx CAN frame in the hot pat=
h.
>
> Not very nice :-(

Agreed, that was one point where I was interested to discuss for some
better solution.

>> +
>> + =A0 =A0 if (unlikely(!priv->tx_led))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!timer_pending(&priv->tx_off_timer)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 led_trigger_event(priv->tx_led, LED_FULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&priv->tx_off_timer,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies + msecs_to_jiffies=
(led_off_delay));
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (loop)
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&priv->led_discard_count);
>> +}
>> +
>
>
> As you pointed out that only CAN devices are supported that use the c=
an-dev
> infrastructure you do some costly checks one layer above (in net/can)=
 instead
> of implementing it on the driver layer (in drivers/net/can).
>
> The only correct trigger for a tx-LED can be retrieved from the TX do=
ne
> interrupt in the interrupt function like here:
>
> http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/sja1000/sja1000.c#L=
507
>
> where the echo skb is sent back to the system.
>
> This makes sure, that the tx-LED is only triggered, when there was a =
really
> successful transmission on the CAN bus.
>
> I wonder if it makes more sense to add the LED trigger stuff into
> drivers/net/can/dev.c ?!?

Of course that seems to be the obvious (=3Dcorrect) place to trap this
stuff. The reason why I worked on upper layer is that I did not found
any generic place to trap tx/rx events in the dev file without
modifying every device driver, as while tx can be trapped in
can_get_echo_skb(), rx frames are handled directly to the network
layer.

> Of course the correct calling points to trigger the rx/tx-LEDs need t=
o be
> implemented inside *each* driver at the correct position.

That's the point. So, do you think it would be better to add trigger
functions into dev.c and modify each driver to call them?

> And we should probably add a new CAN netlink command here
>
> =A0 =A0 =A0 =A0http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/dev.=
c#L577
>
> to configure the LED timer per interface: 0 -> LEDs off (=3D=3Ddefaul=
t)

Nice... I'm taking notes here. :-)

> The question would be, if this code
>
>> + =A0 =A0 if (!timer_pending(&priv->tx_off_timer)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 led_trigger_event(priv->tx_led, LED_FULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&priv->tx_off_timer,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies + msecs_to_jiffies=
(led_off_delay));
>> + =A0 =A0 }
>
>
> is ready to be used in hard IRQ context?
>
> If not we may use a construct with a tasklet that can be triggered fr=
om hard
> IRQ context, like here:
>
> =A0 =A0 =A0 =A0http://lxr.linux.no/#linux+v3.3.1/net/can/bcm.c#L356

I think that led_trigger_event is ok as long as the actual
led-<device>'s brigthness_set function is safe - for example
leds-gpio's one seems to make some check about it. See:

http://lxr.linux.no/#linux+v3.3.1/drivers/leds/leds-gpio.c#L70

Will think about it.

> I think this part
>
>> +
>> + =A0 =A0 if (loop)
>> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_dec(&priv->led_discard_count);
>> +}
>
> is becoming obsolete anyway then, right?

Definitely.

Regards.

--=20
=46abio Baltieri
