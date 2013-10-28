From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 13:06:00 +0100
Message-ID: <20131028120534.GA19060@hposo>
References: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
 <526DA1DB.9000600@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:63271 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab3J1MGI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 08:06:08 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so2116813eaj.41
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2013 05:06:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <526DA1DB.9000600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, Oct 28, 2013 at 12:29:31AM +0100, Marc Kleine-Budde wrote:
> On 10/27/2013 10:07 PM, Olivier Sobrie wrote:
> > Some devices, like the Kvaser Memorator Professional, have several
> > bulk in endpoints. Only the first one found should be used by the
> > driver. The same holds for the bulk out endpoint.
> 
> Can you give reference where this information comes from? e.g.
> documentation or another driver?

Someone using a Kvaser Memorator contacted me and said that its device was
not working. I found out that the usb endpoint used was not correct and I
saw in the Kvaser official driver (leaf) that the detection was made
similarly to what is done in the patch below.
So the reference is the "leaf" driver of Kvaser.

> 
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> > ---
> >  drivers/net/can/usb/kvaser_usb.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
> > index 3b95465..bdbf5bf 100644
> > --- a/drivers/net/can/usb/kvaser_usb.c
> > +++ b/drivers/net/can/usb/kvaser_usb.c
> > @@ -1554,13 +1554,14 @@ static void kvaser_usb_get_endpoints(const struct usb_interface *intf,
> >  
> >  	iface_desc = &intf->altsetting[0];
> >  
> > -	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> > +	for (i = 0; (i < iface_desc->desc.bNumEndpoints) && (!*in || !*out);
> > +	     ++i) {
> >  		endpoint = &iface_desc->endpoint[i].desc;
> >  
> > -		if (usb_endpoint_is_bulk_in(endpoint))
> > +		if (!*in && usb_endpoint_is_bulk_in(endpoint))
> >  			*in = endpoint;
> >  
> > -		if (usb_endpoint_is_bulk_out(endpoint))
> > +		if (!*out && usb_endpoint_is_bulk_out(endpoint))
> >  			*out = endpoint;
> 
> I personally would add a break or return here, together with a short
> comment:
> 
> 	/* only use first endpoint for in and out */
> 	if (*in && *out)
> 		return;
> 
> >  	}
> >  }
> > 

Fine for me. We can even maybe add a return code to the function and check
this return code intead of checking again (!dev->bulk_in || !dev->bulk_out).
By the way, the current return code (-ENOMEM) is maybe not appropriate in
case the endpoints are not found.

Thank you,

-- 
Olivier
