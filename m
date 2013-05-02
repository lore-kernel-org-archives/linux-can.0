From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] can: kvaser_usb: handle rx msg correctly
Date: Thu, 2 May 2013 20:06:10 +0200
Message-ID: <20130502180610.GA14242@thinkoso.home>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <20130430214044.GA22921@thinkoso.home>
 <51824189.8090402@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:49935 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449Ab3EBSGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 14:06:14 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so888431wiv.9
        for <linux-can@vger.kernel.org>; Thu, 02 May 2013 11:06:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51824189.8090402@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

Hi Marc,

On Thu, May 02, 2013 at 12:35:53PM +0200, Marc Kleine-Budde wrote:
> On 04/30/2013 11:40 PM, Olivier Sobrie wrote:
> > --- a/drivers/net/can/usb/kvaser_usb.c
> > +++ b/drivers/net/can/usb/kvaser_usb.c
> > @@ -834,22 +834,51 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
> >  		return;
> >  	}
> >  
> > -	cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
> > -		     (msg->u.rx_can.msg[1] & 0x3f);
> > -	cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
> > +	switch (msg->id) {
> > +	case CMD_LOG_MESSAGE:
> > +		cf->can_id = msg->u.log_message.id;
> 
> No need to mangle the can_id like the CMD_RX_EXT_MESSAGE or
> CMD_RX_STD_MESSAGE case? What about the extended messages flag?

No not needed but I forgot a le32_to_cpu() for the can_id.
The hw set the CAN_EFF_FLAG when it is an extended frame.

> 
> > +		cf->can_dlc = get_can_dlc(msg->u.log_message.dlc);
> > +
> > +		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
> > +			cf->can_id |= CAN_RTR_FLAG;
> > +		else
> > +			memcpy(cf->data, &msg->u.log_message.data,
> > +			       cf->can_dlc);
> 
> Is this endianness save? But the memcpy was already here. Keep it until
> someone with a ppc or sparc complains.

msg->u.log_message.dlc is an u8 and I don't see why the memcpy would be
a problem.

> 
> > +		break;
> >  
> > -	if (msg->id == CMD_RX_EXT_MESSAGE) {
> > +	case CMD_RX_EXT_MESSAGE:
> >  		cf->can_id <<= 18;
> 
> who sets the can_id in the first place?

Damn I shouldn't have changed this by a switch case.
I fix this and send you an updated patch.

Thank you,

-- 
Olivier
