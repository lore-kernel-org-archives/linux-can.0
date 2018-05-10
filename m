From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: Re: [PATCH] can: hi311x: Work around TX complete interrupt erratum
Date: Thu, 10 May 2018 12:23:58 -0400
Message-ID: <CACrMeVBSZZetJ6nzwxwqgNO2QEbdX0R-2whnCK6-bJr-5ibiuA@mail.gmail.com>
References: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Sender: netdev-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, Mathias Duckeck <m.duckeck@kunbus.de>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
List-Id: linux-can.vger.kernel.org

On Wed, May 9, 2018 at 8:43 AM, Lukas Wunner <lukas@wunner.de> wrote:
> When sending packets as fast as possible using "cangen -g 0 -i -x", the
> HI-3110 occasionally latches the interrupt pin high on completion of a
> packet, but doesn't set the TXCPLT bit in the INTF register.  The INTF
> register contains 0x00 as if no interrupt has occurred.  Even waiting
> for a few milliseconds after the interrupt doesn't help.
>
> Work around this apparent erratum by instead checking the TXMTY bit in
> the STATF register ("TX FIFO empty").  We know that we've queued up a
> packet for transmission if priv->tx_len is nonzero.  If the TX FIFO is
> empty, transmission of that packet must have completed.
>
> Note that this is congruent with our handling of received packets, which
> likewise gleans from the STATF register whether a packet is waiting in
> the RX FIFO, instead of looking at the INTF register.
>
> Cc: Mathias Duckeck <m.duckeck@kunbus.de>
> Cc: Akshay Bhat <akshay.bhat@timesys.com>
> Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Acked-by: Akshay Bhat <akshay.bhat@timesys.com>
