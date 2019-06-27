From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in register_candev()
Date: Wed, 26 Jun 2019 21:56:32 -0400
Message-ID: <CAF=yD-L5AmCeHiDA8RUr_E41FFzGdnudCVzTAHFi-Q1rHGPazQ@mail.gmail.com>
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
 <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
 <ff8160d4-3357-9b4f-1840-bbe46195da5a@prevas.dk> <CAF=yD-KyWJwdESFmY=CvbkTBT8yey2atKDY-tgd19yAeMf525g@mail.gmail.com>
 <838ce911-7205-f828-4fc5-79cebc32322a@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <838ce911-7205-f828-4fc5-79cebc32322a@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Wed, Jun 26, 2019 at 5:19 PM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 26/06/2019 16.17, Willem de Bruijn wrote:
> > On Wed, Jun 26, 2019 at 5:31 AM Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> >>
> >> On 24/06/2019 19.26, Willem de Bruijn wrote:
> >>> On Mon, Jun 24, 2019 at 4:34 AM Rasmus Villemoes
> >>> <rasmus.villemoes@prevas.dk> wrote:
> >>>>
> >>>> Make sure the LED always reflects the state of the CAN device.
> >>>
> >>> Should this target net?
> >>
> >> No, I think this should go through the CAN tree. Perhaps I've
> >> misunderstood when to use the net-next prefix - is that only for things
> >> that should be applied directly to the net-next tree? If so, sorry.
> >
> > I don't see consistent behavior on the list, so this is probably fine.
> > It would probably help to target can (for fixes) or can-next (for new
> > features).
> >
> > Let me reframe the question: should this target can, instead of can-next?
>
> Ah, now I see what you meant, but at least I learned when to use
> net/net-next.
>
> I think can-next is fine, especially this late in the rc cycle. But I'll
> leave it to the CAN maintainer(s).
>
> >>> Regardless of CONFIG_CAN_LEDS deprecation,
> >>> this is already not initialized properly if that CONFIG is disabled
> >>> and a can_led_event call at device probe is a noop.
> >>
> >> I'm not sure I understand this part. The CONFIG_CAN_LEDS support for
> >> showing the state of the interface is implemented via hooking into the
> >> ndo_open/ndo_stop callbacks, and does not look at or touch the
> >> __LINK_STATE_NOCARRIER bit at all.
> >>
> >> Other than via the netdev LED trigger I don't think one can even observe
> >> the slightly odd initial state of the __LINK_STATE_NOCARRIER bit for CAN
> >> devices,
> >
> > it's still incorrect, though I guess that's moot in practice.
> Exactly.
>
> >> which is why I framed this as a fix purely to allow the netdev
> >> trigger to be a closer drop-in replacement for CONFIG_CAN_LEDS.
> >
> > So the entire CONFIG_CAN_LEDS code is to be removed? What exactly is
> > this netdev trigger replacement, if not can_led_event? Sorry, I
> > probably miss some context.
>
> drivers/net/can/Kconfig contains these comments
>
>         # The netdev trigger (LEDS_TRIGGER_NETDEV) should be able to do
>         # everything that this driver is doing. This is marked as broken
>         # because it uses stuff that is intended to be changed or removed.
>         # Please consider switching to the netdev trigger and confirm it
>         # fulfills your needs instead of fixing this driver.
>
> introduced by the commit 30f3b42147ba6 which also marked CONFIG_CAN_LEDS
> as (depends on) BROKEN. So while a .dts for using the CAN led trigger
> might be
>
>                 cana {
>                         label = "cana:green:activity";
>                         gpios = <&gpio0 10 0>;
>                         default-state = "off";
>                         linux,default-trigger = "can0-rxtx";
>                 };
>
> one can achieve mostly the same thing with CAN_LEDS=n,
> LEDS_TRIGGER_NETDEV=y setting linux,default-trigger = "netdev" plus a
> small init script (or udev rule or whatever works) that does
>
> d=/sys/class/leds/cana:green:activity
> echo can0 > $d/device_name
> echo 1 > $d/link
> echo 1 > $d/rx
> echo 1 > $d/tx
>
> to tie the cana LED to the can0 device, plus configure it to show "link"
> state as well as blink on rx and tx.
>
> This works just fine, except for the initial state of the LED. AFAIU,
> the netdev trigger doesn't need cooperation from each device driver
> since it simply works of a timer that periodically checks for changes in
> dev_get_stats().

Thanks, I had to read up on that code. Makes sense.

Acked-by: Willem de Bruijn <willemb@google.com>
