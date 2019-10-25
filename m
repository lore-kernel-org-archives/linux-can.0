From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH v1] j1939: transport: make sure EOMA is send with the
 total message size set
Date: Fri, 25 Oct 2019 12:32:42 +0200
Message-ID: <20191025103242.GA2031@x1.vandijck-laurijssen.be>
References: <20191025093015.24506-1-o.rempel@pengutronix.de>
 <20191025093626.snrkgseuuyjejvbv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191025093626.snrkgseuuyjejvbv@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On vr, 25 okt 2019 11:36:26 +0200, Oleksij Rempel wrote:
> Hi all,
> 
> i decided to be strict here and drop malformed EOMA packages. At least
> it makes testing easier.
> I have no idea how far is it from reality. Will it brake some thing?
> 
> 
> On Fri, Oct 25, 2019 at 11:30:15AM +0200, Oleksij Rempel wrote:
> > We was sending malformed EOMA with total message size set to 0. So, fix this
> > bug and add sanity check to the RX path.
> > 
...
> > +	if (session->total_message_size != len) {
> > +		netdev_warn(session->priv->ndev, "%s: 0x%p: Incorrect size. Expected: %i; got: %i.\n",
> > +			    __func__, session, session->total_message_size,
> > +			    len);

A warning is usefull here, maybe rate-limited.

> > +		return;

But returning an otherwise complete transfer is rough.
I'm sure verifying this at this stage is unusual.
I'm sure there are little controllers out there that fail here.

Be tolerant on the input and strict on the output, isn't it?

Kind regards,
Kurt 
> > +	}
> > +
