From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] can: rcar: use SPDX identifier for Renesas drivers
Date: Wed, 22 Aug 2018 21:31:33 +0200
Message-ID: <20180822193133.GA1613@kroah.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-6-wsa+renesas@sang-engineering.com>
 <CAOMZO5AkVNiYMGdED9erL=YMaKcmtS5BzZxw2gO1KLXEaPnD7A@mail.gmail.com>
 <20180822063005.535lytz7hl32rsha@katana>
 <CAOMZO5BiAyDMSR=2Y-4-1ftNuVtRS59sSJd_cdFmzX=0kgF0Bw@mail.gmail.com>
 <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOFm3uF9_rbELx0aYLDXpDnZfi2Z11V1Z4Ktw+DDJT62o2S1kQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-can.vger.kernel.org

On Wed, Aug 22, 2018 at 08:16:45PM +0200, Philippe Ombredanne wrote:
> Hi Fabio,
> On Wed, Aug 22, 2018 at 2:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Wed, Aug 22, 2018 at 3:30 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >>
> >>> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >>>
> >>> According to Documentation/process/license-rules.rst the format should
> >>> be like this instead:
> >>>
> >>> // SPDX-License-Identifier: GPL-2.0+
> >>
> >> According to https://spdx.org/licenses/ it should be what I did above.
> >
> > Previous advice I saw was to follow the format described in
> > Documentation/process/license-rules.rst
> >
> > Greg/Philippe,
> >
> > Any inputs on this matter?
> >
> > Thanks
> 
> IMHO we should always treat and use the
> Documentation/process/license-rules.rst as the reference and not SPDX
> proper who moves at its own pace and evolves its specs and license ids
> independently of where we stand in the kernel.
> If this is not right Doc patches are welcomed!
> In this is very specific case this has been discussed on list a few
> times. If I recall correctly Thomas also had an opinion on this...
> So you are correct and this should be for now:
> // SPDX-License-Identifier: GPL-2.0+

That is correct, stick with that format/version for now please.

thanks,

greg k-h
