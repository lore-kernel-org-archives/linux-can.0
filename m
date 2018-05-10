From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: hi311x: Work around TX complete interrupt erratum
Date: Thu, 10 May 2018 18:27:23 +0200
Message-ID: <660b3216-6319-58d0-c715-ef308690d9fb@pengutronix.de>
References: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <dc7901c96bed90724bb372f4d3eead82bd22ac37.1525869303.git.lukas@wunner.de>
Content-Language: de-DE
Sender: netdev-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: Mathias Duckeck <m.duckeck@kunbus.de>, Akshay Bhat <akshay.bhat@timesys.com>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
List-Id: linux-can.vger.kernel.org

On 05/09/2018 02:43 PM, Lukas Wunner wrote:
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

Applied to can.

Tnx,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
