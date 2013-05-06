From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] can: kvaser_usb: handle rx msg correctly
Date: Mon, 6 May 2013 22:00:20 +0200
Message-ID: <20130506200020.GA11179@thinkoso.home>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <20130430214044.GA22921@thinkoso.home>
 <51824189.8090402@pengutronix.de>
 <20130502180610.GA14242@thinkoso.home>
 <51838821.6070902@pengutronix.de>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39111 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab3EFUAY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 May 2013 16:00:24 -0400
Received: by mail-wi0-f174.google.com with SMTP id m6so2944235wiv.13
        for <linux-can@vger.kernel.org>; Mon, 06 May 2013 13:00:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51838821.6070902@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

On Fri, May 03, 2013 at 11:49:21AM +0200, Marc Kleine-Budde wrote:
> On 05/02/2013 08:06 PM, Olivier Sobrie wrote:
> > Hi Marc,
> > 
> > On Thu, May 02, 2013 at 12:35:53PM +0200, Marc Kleine-Budde wrote:
> >> On 04/30/2013 11:40 PM, Olivier Sobrie wrote:
> >>> --- a/drivers/net/can/usb/kvaser_usb.c
> >>> +++ b/drivers/net/can/usb/kvaser_usb.c
> >>> @@ -834,22 +834,51 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
> >>>  		return;
> >>>  	}
> >>>  
> >>> -	cf->can_id = ((msg->u.rx_can.msg[0] & 0x1f) << 6) |
> >>> -		     (msg->u.rx_can.msg[1] & 0x3f);
> >>> -	cf->can_dlc = get_can_dlc(msg->u.rx_can.msg[5]);
> >>> +	switch (msg->id) {
> >>> +	case CMD_LOG_MESSAGE:
> >>> +		cf->can_id = msg->u.log_message.id;
> >>
> >> No need to mangle the can_id like the CMD_RX_EXT_MESSAGE or
> >> CMD_RX_STD_MESSAGE case? What about the extended messages flag?
> > 
> > No not needed but I forgot a le32_to_cpu() for the can_id.
> > The hw set the CAN_EFF_FLAG when it is an extended frame.
> 
> The hardware uses the same bit to mask an extended flag as the linux
> kernel does it with CAN_EFF_FLAG? I feel more confident about this if
> you add a flag that describes the hard EFF_FLAG and the do the "is EFF
> flag set, mask 29 bit and set CAN_EFF_FLAG otherwise mask 11 bit" dance.

Ok I send an updated patch soon.

> 
> Can you please check the driver for other missing leXX_to_cpu and
> cpu_to_leXX?

I quickly checked and didn't see other missing leXX_to_cpu or
cpu_to_leXX.

> 
> >>> +		cf->can_dlc = get_can_dlc(msg->u.log_message.dlc);
> >>> +
> >>> +		if (msg->u.log_message.flags & MSG_FLAG_REMOTE_FRAME)
> >>> +			cf->can_id |= CAN_RTR_FLAG;
> >>> +		else
> >>> +			memcpy(cf->data, &msg->u.log_message.data,
> >>> +			       cf->can_dlc);
> >>
> >> Is this endianness save? But the memcpy was already here. Keep it until
> >> someone with a ppc or sparc complains.
> > 
> > msg->u.log_message.dlc is an u8 and I don't see why the memcpy would be
> > a problem.
> 
> It's not the dlc I'm talking about. I mean the data. There might be a
> problem if you have a dlc of 5. Where is byte 5 located? But I think
> it's safe as it is.
> 
> >>> +		break;
> >>>  
> >>> -	if (msg->id == CMD_RX_EXT_MESSAGE) {
> >>> +	case CMD_RX_EXT_MESSAGE:
> >>>  		cf->can_id <<= 18;
> >>
> >> who sets the can_id in the first place?
> > 
> > Damn I shouldn't have changed this by a switch case.
> > I fix this and send you an updated patch.
> 
> Thanks,
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 
Olivier
