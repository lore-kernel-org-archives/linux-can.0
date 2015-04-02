From: Dan Egnor <dan.egnor@gmail.com>
Subject: Re: Fwd: Querying current =?utf-8?b?dHhfcXVldWU=?= usage of a SocketCAN interface
Date: Thu, 2 Apr 2015 00:33:33 +0000 (UTC)
Message-ID: <loom.20150402T022922-646@post.gmane.org>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>	<55187FF1.7020701@optusnet.com.au>	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>	<5519E5A9.7080104@optusnet.com.au>	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>	<551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com> <551C7D79.50906@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34738 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056AbbDBAdm (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 1 Apr 2015 20:33:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YdT4m-0002TM-JM
	for linux-can@vger.kernel.org; Thu, 02 Apr 2015 02:33:40 +0200
Received: from 216.239.45.65 ([216.239.45.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2015 02:33:40 +0200
Received: from dan.egnor by 216.239.45.65 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2015 02:33:40 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Tom Evans <tom_usenet <at> optusnet.com.au> writes:
> As the "System Designer", if your system (your car) uses SJA1000 
controllers, 
> or other ones, but with software that doesn't support the multiple hardware 
> buffers, or has more IDs in use that the number of buffers, they you have 
to 
> design the *SYSTEM* so it works within those constraints.

That's all well and good, but what you're saying is that Linux SocketCAN is 
incapable of supporting anything but the most absolutely basic single-mailbox 
operation.

That seems surprisingly awful for something that's an established generic 
interface for all CAN hardware on this operating system! No matter how many 
mailboxes the controller might support, the operating system simply does not 
support prioritized transmission.

This means that in our system architecture, Linux nodes must be treated as 
substantially less capable than most embedded controllers. (The TI MCUs we're 
using have 64 mailboxes, for example.)

This feels like a massive functional deficit that's acknowledged nowhere in 
the documentation. Is this really the case??

-- egnor

