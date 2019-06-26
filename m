From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in register_candev()
Date: Wed, 26 Jun 2019 10:17:03 -0400
Message-ID: <CAF=yD-KyWJwdESFmY=CvbkTBT8yey2atKDY-tgd19yAeMf525g@mail.gmail.com>
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
 <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com> <ff8160d4-3357-9b4f-1840-bbe46195da5a@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff8160d4-3357-9b4f-1840-bbe46195da5a@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Wed, Jun 26, 2019 at 5:31 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 24/06/2019 19.26, Willem de Bruijn wrote:
> > On Mon, Jun 24, 2019 at 4:34 AM Rasmus Villemoes
> > <rasmus.villemoes@prevas.dk> wrote:
> >>
> >> CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
> >> trigger as suggested, there's a small inconsistency with the link
> >> property: The LED is on initially, stays on when the device is brought
> >> up, and then turns off (as expected) when the device is brought down.
> >>
> >> Make sure the LED always reflects the state of the CAN device.
> >>
> >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> >
> > Should this target net?
>
> No, I think this should go through the CAN tree. Perhaps I've
> misunderstood when to use the net-next prefix - is that only for things
> that should be applied directly to the net-next tree? If so, sorry.

I don't see consistent behavior on the list, so this is probably fine.
It would probably help to target can (for fixes) or can-next (for new
features).

Let me reframe the question: should this target can, instead of can-next?

> > Regardless of CONFIG_CAN_LEDS deprecation,
> > this is already not initialized properly if that CONFIG is disabled
> > and a can_led_event call at device probe is a noop.
>
> I'm not sure I understand this part. The CONFIG_CAN_LEDS support for
> showing the state of the interface is implemented via hooking into the
> ndo_open/ndo_stop callbacks, and does not look at or touch the
> __LINK_STATE_NOCARRIER bit at all.
>
> Other than via the netdev LED trigger I don't think one can even observe
> the slightly odd initial state of the __LINK_STATE_NOCARRIER bit for CAN
> devices,

it's still incorrect, though I guess that's moot in practice.

> which is why I framed this as a fix purely to allow the netdev
> trigger to be a closer drop-in replacement for CONFIG_CAN_LEDS.

So the entire CONFIG_CAN_LEDS code is to be removed? What exactly is
this netdev trigger replacement, if not can_led_event? Sorry, I
probably miss some context.
