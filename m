From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH v2] j1939: transport: make sure EOMA is send with the
 total message size set
Date: Fri, 25 Oct 2019 15:23:34 +0200
Message-ID: <20191025132334.GB2031@x1.vandijck-laurijssen.be>
References: <20191025130413.1298-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191025130413.1298-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On vr, 25 okt 2019 15:04:13 +0200, Oleksij Rempel wrote:
> 
> We was sending malformed EOMA with total message size set to 0. So, fix this
> bug and add sanity check to the RX path.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
