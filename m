From: swapnil <patilswa@gmail.com>
Subject: Re: building  j1939 stack
Date: Tue, 13 May 2014 13:45:33 +0000 (UTC)
Message-ID: <loom.20140513T153515-14@post.gmane.org>
References: <loom.20140510T062609-546@post.gmane.org> <20140510220639.GA18571@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59170 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbaEMNpq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 13 May 2014 09:45:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WkD1c-0007wp-Hz
	for linux-can@vger.kernel.org; Tue, 13 May 2014 15:45:44 +0200
Received: from 192.158.48.18 ([192.158.48.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 13 May 2014 15:45:44 +0200
Received: from patilswa by 192.158.48.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 13 May 2014 15:45:44 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:

> 
> Hey,
> 
> I found already that my can-j1939 does not compile on a 3.12 kernel
> that I'm using.
> I'm working to bring can-j1939 to 3.12 for my own use.
> 
> What kernel version do you use before & now?
I am using 3.8
i missed to do checkout git checkout origin/am33x-v3.8
that's why it did not worked.. I am able to compile now :).
I am targeting to boot my Kernal in 2 Seconds.   
Thanks 
> 
> Kurt
> 





