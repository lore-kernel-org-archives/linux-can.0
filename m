From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: sendmsg
Date: Mon, 16 Jan 2012 16:36:44 +0100
Message-ID: <20120116153644.GA7763@e-circ.dyndns.org>
References: <20120110085105.GB330@e-circ.dyndns.org>
 <loom.20120110T112815-928@post.gmane.org>
 <20120110152341.GD2524@e-circ.dyndns.org>
 <loom.20120112T155904-850@post.gmane.org>
 <4F0F2195.7050109@hartkopp.net>
 <20120113111251.GD319@e-circ.dyndns.org>
 <loom.20120113T122554-557@post.gmane.org>
 <loom.20120116T103812-141@post.gmane.org>
 <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:28788 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab2APPgq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 Jan 2012 10:36:46 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120116T153805-349@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Mon, Jan 16, 2012 at 03:28:24PM +0000, Wolfgang wrote:
> > I'm just pushed an update that fixes this. 
> Great! Thanks.
> 
> 
>  	while (1) {
> 		
>  		iov.iov_len = s.pkt_len;
>  		msg.msg_namelen = sizeof(src);
>  		msg.msg_controllen = sizeof(ctrlmsg);
> 		msg.msg_flags = 0;
>  
>  			
> 		ret = recvmsg(sock, &msg, 0);
>  
> 
> 		if ((msg.msg_flags & MSG_DONTROUTE) == 0)
>  			{
>  				src.can_addr.j1939.addr = J1939_NO_ADDR;
>  				src.can_ifindex = if_nametoindex("can1");
>  				sendmsg(s2, &msg, 0);
>  			}
> 
>                   } 
> 
> 
> 
> Is it possible or what do I have to change that sendmsg will send the _same_ 
> frame which is received? Now the dlc is always 0x400 as declared in s.pkt_len.
after recvmsg(), do
	msg.iov_len = ret;

I believe you understand why?
Kurt
