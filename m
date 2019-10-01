From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 2/2] can: C_CAN: add bus recovery events
Date: Tue, 1 Oct 2019 15:37:35 +0200
Message-ID: <20191001133735.GA32369@x1.vandijck-laurijssen.be>
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
 <20190926085005.24805-3-jhofstee@victronenergy.com>
 <20191001074057.GA28813@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191001074057.GA28813@x1.vandijck-laurijssen.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On di, 01 okt 2019 09:40:57 +0200, Kurt Van Dijck wrote:
> On do, 26 sep 2019 08:50:51 +0000, Jeroen Hofstee wrote:
> > While the state is update when the error counters increase and decrease,
> > there is no event when the bus recovers and the error counters decrease
> > again. So add that event as well.
> > 
> > Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
> > ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.
> 
> This looks like a proper thing to do
> Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Thanks for this, now I see when the bus is normal again.

Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
