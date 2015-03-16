From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH v5 1/2] can: kvaser_usb: Comply with firmware max tx URBs
 value
Date: Mon, 16 Mar 2015 08:16:36 -0400
Message-ID: <20150316121636.GA14280@linux>
References: <20150226152011.GA6075@linux>
 <20150315150338.GA4492@linux>
 <5505CA97.6020503@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5505CA97.6020503@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Sun, Mar 15, 2015 at 07:08:23PM +0100, Marc Kleine-Budde wrote:
> On 03/15/2015 04:03 PM, Ahmed S. Darwish wrote:
> > From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> > 
> > Current driver code arbitrarily assumes a max outstanding tx
> > value of 16 parallel transmissions. Meanwhile, the device
> > firmware provides its actual maximum inside its reply to the
> > CMD_GET_SOFTWARE_INFO message.
> > 
> > Under heavy tx traffic, if the interleaved transmissions count
> > increases above the limit reported by firmware, the firmware
> > breaks up badly, reports a massive list of internal errors, and
> > the candump traces hardly matches the actual frames sent and
> > received.
> > 
> > On the other hand, in certain models, the firmware can support
> > up to 48 tx URBs instead of just 16, increasing the driver
> > throughput by two-fold and reducing the possibility of -ENOBUFs.
> > 
> > Thus dynamically set the driver's max tx URBs value according
> > to firmware replies.
> > 
> > Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> 
> > @@ -1928,7 +1940,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
> >  		return err;
> >  	}
> >  
> > -	netdev_dbg(netdev, "device registered\n");
> > +	netdev_info(netdev, "device registered\n");
> 
> This makes the driver more noisy, I'd like to drop that hunk, okay? No
> need to resend.
> 

Sure, go ahead.

I have my reasons for that hunk above, but we can always discuss
this in another separate patch ;-)

Thanks,
Darwish
