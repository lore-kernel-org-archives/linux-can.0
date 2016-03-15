From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC] [PATCH v2] can: fix handling of unmodifiable configuration
 options
Date: Tue, 15 Mar 2016 07:14:02 +0000
Message-ID: <SG2PR06MB1038BA6E2181E1B9A61BE1CDC3890@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1457807487-14691-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB1038D9B53602CECA8E34C4D4C3880@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <56E6FE5F.2000500@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:54000 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933405AbcCOHOG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Mar 2016 03:14:06 -0400
In-Reply-To: <56E6FE5F.2000500@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

> -----Original Message-----
> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
> Sent: 14 March 2016 18:10
> To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>;
> linux-can@vger.kernel.org
> Subject: Re: [RFC] [PATCH v2] can: fix handling of unmodifiable
> configuration options
> 
> On 03/14/2016 11:15 AM, Ramesh Shanmugasundaram wrote:
> 
> >> Oliver Hartkopp <socketcan@hartkopp.net>
> >> Subject: [RFC] [PATCH v2] can: fix handling of unmodifiable
> >> configuration options
> >
> > (...)
> >
> >>
> >> +static inline void can_set_static_ctrlmode(struct can_priv *priv,
> >> +					   const u32 static_mode)
> >> +{
> >> +	priv->ctrlmode = static_mode;
> >> +	priv->ctrlmode_static = static_mode; }
> >
> > Is it worth taking the ndev as arg and change the MTU as well in this
> > function? This way mode & MTU would be consistent and would reflect
> > the same in a configuration like this
> >
> > "ip link set can0 up type can bitrate 1000000 dbitrate 1000000"
> >
> > Would this be an overkill?
> 
> My first thought was that setting the MTU in this function smells fishy.
> 
> But as can_set_static_ctrlmode() is intended to be used at CAN device
> setup time only it makes sense to override the MTU which is set in
> can_setup() to CAN_MTU by default.

Thanks.

> 
> It doesn't make sense to pass the MTU to alloc_candev() as setting the MTU
> to CAN_MTU is always to correct default (even for configurable CAN FD
> devices).

Yes, I agree. I too thought of the same initially. can_set_static_ctrlmode() seems to be best for now.
> 
> I'll sed an updated patch which overrides the MTU in
> can_set_static_ctrlmode() when CAN_CTRLMODE_FD is set in ctrlmode_static.
>
Thanks,
Ramesh
