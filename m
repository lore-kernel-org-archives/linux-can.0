From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH v3] can: rename LED trigger name on netdev renames
Date: Tue, 11 Sep 2012 10:05:35 +0200
Message-ID: <20120911080535.GA412@vandijck-laurijssen.be>
References: <20120907071934.GB37685@macbook.local>
 <1347207464-2002-1-git-send-email-fabio.baltieri@gmail.com>
 <20120910142827.GB11000@vandijck-laurijssen.be>
 <504E30AE.50201@hartkopp.net>
 <20120910184049.GD2006@gmail.com>
 <504E3901.10901@hartkopp.net>
 <20120910200844.GC546@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120910200844.GC546@vandijck-laurijssen.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Fabio Baltieri <fabio.baltieri@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Mon, Sep 10, 2012 at 10:08:44PM +0200, Kurt Van Dijck wrote:
> On Mon, Sep 10, 2012 at 09:01:21PM +0200, Oliver Hartkopp wrote:
> > On 10.09.2012 20:40, Fabio Baltieri wrote:
> > 
> > > On Mon, Sep 10, 2012 at 08:25:50PM +0200, Oliver Hartkopp wrote:
> > >> On 10.09.2012 16:28, Kurt Van Dijck wrote:
> > >>> Fabio,
> > >>>
> > > 
> > > Also, I noticed you removed the namespace check... wasn't it needed?
> > > (just asking, I have no idea).
> 

Moreover, the function tests if the net_device has an associated can_priv.
The namespace it's in is irrelevant then?
I think those tests may be removed in af_can too.

Kurt
