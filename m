From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH 1/2] can: D_CAN: perform a sofware reset on open
Date: Tue, 1 Oct 2019 15:39:56 +0200
Message-ID: <20191001133956.GB32369@x1.vandijck-laurijssen.be>
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
 <20190926085005.24805-2-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190926085005.24805-2-jhofstee@victronenergy.com>
Sender: netdev-owner@vger.kernel.org
To: Jeroen Hofstee <jhofstee@victronenergy.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On do, 26 sep 2019 08:50:44 +0000, Jeroen Hofstee wrote:
> When the C_CAN interface is closed it is put in power down mode, but
> does not reset the error counters / state. So reset the D_CAN on open,
> so the reported state and the actual state match.
> 
> According to [1], the C_CAN module doesn't have the software reset.
> 
> [1] http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf
> 
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>

I observed no problems after applying the patch.

Tested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
