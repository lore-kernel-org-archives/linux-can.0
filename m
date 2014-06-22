From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Kvaser lapcan driver (init and probe)
Date: Sun, 22 Jun 2014 22:02:12 +0200
Message-ID: <20140622200212.GB14910@vandijck-laurijssen.be>
References: <CAGqyy=ZHGDovR1i_ZzKqTYqp5QAVhbSco6uwE2-nFefL-g+ouw@mail.gmail.com>
 <20140621212823.GA28234@vandijck-laurijssen.be>
 <1403455122.3506.12.camel@PCLUK>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:28786 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184AbaFVUCZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Jun 2014 16:02:25 -0400
Content-Disposition: inline
In-Reply-To: <1403455122.3506.12.camel@PCLUK>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Luis de Arquer <ldearquer@gmail.com>
Cc: linux-can@vger.kernel.org

On Sun, Jun 22, 2014 at 05:38:42PM +0100, Luis de Arquer wrote:
> Hi Kurt,
> 
> Thanks for revising.
> 
> > 
> > Did you try to use request_resource, and ommitting pcmcia_request_io.
> > 
> 
> It may be ok to use request_resource, but I am not too sure about
> it. That sounds to me a bit like bypassing the pcmcia socket module,
> which knows the actual range of I/O ports that can be requested -all I
> really know is that I need 3 I/O lines. 

I think pcmcia_enable_device prepares the pcmcia socket for all resources. 
Your driver will just claim it's use.

Kurt

> 
> 
> > The IRQ should only be fired when the CAN chip is running, which is way later.
> > You did well.
> > 
> 
> Thanks, that's reassuring :)
> 
> Luis
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
