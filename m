From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Mon, 9 Jan 2012 10:33:18 +0100
Message-ID: <20120109093318.GB386@e-circ.dyndns.org>
References: <20111223110445.GB12091@e-circ.dyndns.org>
 <loom.20111228T114009-686@post.gmane.org>
 <20120104094715.GB320@e-circ.dyndns.org>
 <loom.20120104T160223-182@post.gmane.org>
 <20120104204151.GA306@e-circ.dyndns.org>
 <loom.20120105T113439-912@post.gmane.org>
 <20120105120930.GA372@e-circ.dyndns.org>
 <loom.20120105T215714-788@post.gmane.org>
 <20120106122550.GA17043@e-circ.dyndns.org>
 <loom.20120106T190304-160@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:39366 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab2AIJdU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 9 Jan 2012 04:33:20 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120106T190304-160@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Jan 06, 2012 at 06:25:59PM +0000, Wolfgang wrote:
> 
> Now I have a different question, is it possible to bind different sockets with
> different src.addr to one interface.
of course, yes.
> Because it is saying 'bind failed: Device 
> or resource busy' if I want to do this ('$ip addr add j1939 0x01 dev can0' is 
> working, of course)
It should work. Since '$ ip addr add ...' worked, there must be something in the code.
I look in the code for this. Did I understand well that only the first bind() succeeds?
> Or do I have to do this with recvmsg()? 
no, wrong idea.
> Because as you know I want keep the various src address'.
I understand your goal...
> 
> Kind regards,
> Wolfgang
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
