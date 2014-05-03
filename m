From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: Kvaser socketCAN support
Date: Sat, 3 May 2014 15:18:16 +0200
Message-ID: <20140503131816.GA29125@thinkoso.home>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de>
 <535559FC.70506@hartkopp.net>
 <r049e3q3UHfiSQJ.RZmta@smtp.rzone.de>
 <53620C3B.9080402@hartkopp.net>
 <R0595dq41EVg2BS.RZmta@smtp.rzone.de>
 <53627522.7000106@hartkopp.net>
 <53628879.751e8c0a.6be4.ffffc061SMTPIN_ADDED_MISSING@mx.google.com>
 <20140501204609.GA25569@thinkoso.home>
 <5363a95a.e3208c0a.bc54.574dSMTPIN_ADDED_MISSING@mx.google.com>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:49424 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbaECNSH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 May 2014 09:18:07 -0400
Received: by mail-ee0-f48.google.com with SMTP id e49so2741053eek.21
        for <linux-can@vger.kernel.org>; Sat, 03 May 2014 06:18:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5363a95a.e3208c0a.bc54.574dSMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "Adams, Shawn - 0999 - MITLL" <shawn.adams@ll.mit.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Kvaser Support (support@kvaser.com)" <support@kvaser.com>

Hello Christopher,

On Fri, May 02, 2014 at 10:19:02AM -0400, Smith, Christopher - 0999 - MITLL wrote:
> Sorry for the mix up to the Olivers.  I should have paid closer attention!
> The only thing I can figure at this point is something about the new
> firmware breaks the driver.  We've tried on a few machines and get the same
> error.  I also upgraded to device firmware 3.2.302 and see the same thing.
> I'm not sure how to downgrade the firmware as kvaser doesn't post those
> binaries.  
> 
> As for the kernel version, we're running 3.12.0 so I believe you're saying
> that does include the fix?

Yes this version includes the fix.

Is it possible for you to take a wireshark capture on the usb bus when
the probing of the device is made by the kvaser_usb driver?
Can you also check if the device is correclty probed by the Kvaser leaf
driver, i.e. the one you can find on the kvaser website?

Thanks,

-- 
Olivier
