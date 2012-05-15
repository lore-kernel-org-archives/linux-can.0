From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v4] CAN FD support
Date: Tue, 15 May 2012 20:48:32 +0200
Message-ID: <20120515184832.GA414@vandijck-laurijssen.be>
References: <4FB25A39.7090608@hartkopp.net>
 <20120515135429.GB1414@vandijck-laurijssen.be>
 <4FB27B78.4070002@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:33059 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965807Ab2EOSsh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 14:48:37 -0400
Content-Disposition: inline
In-Reply-To: <4FB27B78.4070002@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, May 15, 2012 at 05:51:20PM +0200, Oliver Hartkopp wrote:
> On 15.05.2012 15:54, Kurt Van Dijck wrote:
> 
> > [...]
> >> @@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
> >>  	if (!ro->recv_own_msgs && oskb->sk == sk)
> >>  		return;
> >>  
> >> +	/* do not pass frames with DLC > 8 to a legacy socket */
> >> +	if (!ro->fd_frames) {
> >> +		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> >> +
> >> +		if (unlikely(cfd->len > CAN_MAX_DLEN))
> > idea:
> > 			cfd->len = CAN_MAX_LEN;
> > 
> > but this modification must then be done _after_ the skb_clone below.
> 
> 
> I dislike cutting payload data, because people would not be able to detect
> that.
Yep, that true as well.
Better leave it the way it is now.

Regards,
Kurt
