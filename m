From: Sandro <sandro.anders@carmedialab.com>
Subject: Re: socket-can raw filter problem
Date: Fri, 31 May 2013 09:40:35 +0000 (UTC)
Message-ID: <loom.20130531T113715-80@post.gmane.org>
References: <18F8639CFC8C7C4D819AB347808079D401F0B47E@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51811 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab3EaJuL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 May 2013 05:50:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1UiLyF-0002Oy-4h
	for linux-can@vger.kernel.org; Fri, 31 May 2013 11:50:03 +0200
Received: from p54809EED.dip0.t-ipconnect.de ([84.128.158.237])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 31 May 2013 11:50:03 +0200
Received: from sandro.anders by p54809EED.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 31 May 2013 11:50:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Sandro Anders | CarMedialab <sandro.anders <at> carmedialab.com> writes:

> 
> Hi all,
> 
> I've a problem with the raw filters in my application. If I set two
> filters, and a received CAN message passes both, then my code receives
> the message twice - see debug output below. 
> 
> I have a temporary work around but would like to know whether this is a
> "feature" of Socket CAN or a bug.
> 0 code:7e8, mask:7ff  // first filter
> 1 code:7e8, mask:7e8  // second filter
> Add message 7e0 1 7 0 to queue at time 171 types 0 1
> tx id: 7e0 1 171 171 10 0 0 1    // send a 7E0 message
> Data is available now.  // received response first time
> Run: received 07e8 at time 7a735
> Data is available now.  // received responce a second time
> 
> Thanks and best regards,
> Sandro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
Hi,

I just found out this problem is already in discussion by another thread 
indruduced by Sebastian. It's exactly the same. So I follow up this thread. 
Sorry for asking the same question twice. 

Regards,
Sandro


