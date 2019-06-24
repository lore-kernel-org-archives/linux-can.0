From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] can: dev: call netif_carrier_off() in register_candev()
Date: Mon, 24 Jun 2019 13:26:18 -0400
Message-ID: <CA+FuTSeHhz1kntLyeUfAB4ZbtYjO1=Ornwse-yQbPwo5c-_2=g@mail.gmail.com>
References: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Mon, Jun 24, 2019 at 4:34 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> CONFIG_CAN_LEDS is deprecated. When trying to use the generic netdev
> trigger as suggested, there's a small inconsistency with the link
> property: The LED is on initially, stays on when the device is brought
> up, and then turns off (as expected) when the device is brought down.
>
> Make sure the LED always reflects the state of the CAN device.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Should this target net? Regardless of CONFIG_CAN_LEDS deprecation,
this is already not initialized properly if that CONFIG is disabled
and a can_led_event call at device probe is a noop.
