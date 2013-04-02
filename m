From: Giox79 <giovanniparodi79@gmail.com>
Subject: Re: Parsing j1939 from raw candump
Date: Tue, 2 Apr 2013 19:53:58 +0000 (UTC)
Message-ID: <loom.20130402T213730-777@post.gmane.org>
References: <loom.20130325T214842-307@post.gmane.org> <20130326191831.GA22696@vandijck-laurijssen.be> <loom.20130326T221001-133@post.gmane.org> <20130327080926.GA449@vandijck-laurijssen.be> <20130327120438.GD449@vandijck-laurijssen.be> <loom.20130327T132424-152@post.gmane.org> <20130327132521.GF449@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43890 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932457Ab3DBTyO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 2 Apr 2013 15:54:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UN7Hx-0007Z4-5C
	for linux-can@vger.kernel.org; Tue, 02 Apr 2013 21:54:37 +0200
Received: from host31-26-dynamic.0-87-r.retail.telecomitalia.it ([87.0.26.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 02 Apr 2013 21:54:37 +0200
Received: from giovanniparodi79 by host31-26-dynamic.0-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 02 Apr 2013 21:54:37 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> 
> > I will give it a try during the weekend.
> I'll be off next week. My email access may be limited. I
>  hope it just works then.
> 


Hi Kurt thank you again.
I had some little problem since my boss decided to 
avoid recompiling Linux kernel in our board 
(different development teams involved in the project
 and I work on the application layer).
So at present time I have to create a custom SW in 
userspace to parse some J1939 extracting the 
associated SPN.
In order to validate my approach, I would like to have
 an example of candump log (the official candump 
application, integrated in the main branch of Linux kernel) 
and to know what kind of j1939 nformation it represents.
So I would like to ask you if there is some kind of candump
 test vectors somewhere on the web.
I wasn't able to find any resource about this topic.
Do you know if there is some place where I can look for?
Best regards


