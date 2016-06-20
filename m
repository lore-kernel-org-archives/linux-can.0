From: ajneu <ajneu1@gmail.com>
Subject: Re: Bug? -- NEVER getting =?utf-8?b?Y29udHJvbGxlci1wcm9ibGVte2JhY2stdG8tZXJyb3ItYWN0aXZlfQ==?=
Date: Mon, 20 Jun 2016 13:53:14 +0000 (UTC)
Message-ID: <loom.20160620T154404-130@post.gmane.org>
References: <loom.20160620T110554-742@post.gmane.org> <5767C65D.2010303@grandegger.com> <loom.20160620T145908-586@post.gmane.org> <5767F01F.50700@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33844 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658AbcFTNxX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 20 Jun 2016 09:53:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bEzdg-0008Om-Ud
	for linux-can@vger.kernel.org; Mon, 20 Jun 2016 15:53:21 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 15:53:20 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2016 15:53:20 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> 
> Am 20.06.2016 um 15:00 schrieb ajneu:
> > Hi Wolfgang,
> >
> > yes wonderful: you patch works (and solves both issues)!
> > Will it be going into the mainline linux kernel?
> 
> I'm going to prepare a patch for mainline inclusion. Can I add your 
> "Tested-by: ajneu <ajneu1 <at> gmail.com>"?

Well ok, you may. 
(Just note I only tested the bugs I reported, and can confirm: those bugs
are gone. I cannot account for any side-effects, since I didn't do any
"complete" tests. But scanning the code (*briefly*) it looks sortof ok... 

Just question: Your change eliminates 
   dev->can.state = CAN_STATE_ERROR_ACTIVE;
where dev references usb_if, which is passed into the function as parameter.
Is it ok to eliminate that call?? 
(Perhaps its equiv to the line 
   can_change_state(netdev, cf, tx_state, rx_state); 
which is called somewhat lower???)

Regards,
ajneu

