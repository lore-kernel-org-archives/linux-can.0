From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Tue, 10 Jan 2012 16:23:42 +0100
Message-ID: <20120110152341.GD2524@e-circ.dyndns.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
 <loom.20120109T162926-984@post.gmane.org>
 <20120110085105.GB330@e-circ.dyndns.org>
 <loom.20120110T112815-928@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:22852 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756Ab2AJPXo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Jan 2012 10:23:44 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120110T112815-928@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Jan 10, 2012 at 10:45:30AM +0000, Wolfgang wrote:
> > I take back this conclusion. I looked again, and came on this:
> > clear the src_addr.can_ifindex, since that's for sure wrong when bridging.
> 
> It is working, thanks.
> As far as I can judge this, your patch is also working I can bind different 
> sockets on one interface, and then send with different src addr.
Thanks for testing!
> 
> 
> > In a later iteration, You could (if necessary, since I have no clue what kind
> > of traffic you will bridge):
> > * make the receiving socket (s) 'promiscuous', i.e. receiving all traffic.
> > * fetch the original destination by using recvmsg() as illustrated in jspy
> 
> OK, I think I am that far, making one socket promiscuous and than depending 
> on the source address send it with the corresponding socket.
> Is there any 'easy' iteration, of that. Or do I have to rebuild the jspy.c, 
> libj1939.c, libj1939.h according to my wishes?

jspy just serves as illustration here. I don't think you will need the binary.
But I consider using recvmsg() a bit complicated, easily forgotten ...

Kind regards,
Kurt
