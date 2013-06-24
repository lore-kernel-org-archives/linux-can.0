From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Fwd: Re: [PATCH] can: usb_8dev: unregister netdev before
 free()ing
Date: Mon, 24 Jun 2013 14:55:20 -0700
Message-ID: <20130624215520.GA6621@kroah.com>
References: <51C1DC58.2040705@hartkopp.net>
 <51C4A3B7.9040903@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60459 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab3FXVzW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Jun 2013 17:55:22 -0400
Content-Disposition: inline
In-Reply-To: <51C4A3B7.9040903@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Linux Netdev List <netdev@vger.kernel.org>

On Fri, Jun 21, 2013 at 09:04:23PM +0200, Oliver Hartkopp wrote:
> Hello Greg,
> 
> can you please integrate this patch into stable 3.9 too?
> The usb_8dev driver was introduced in Linux 3.9 and has now been fixed in
> DaveMs net-tree for 3.10 some days ago.
> 
> Upstream commit 4afe2156eb639e563d6ef0c2706b66ea400348b2
> 
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=4afe2156eb639e563d6ef0c2706b66ea400348b2
> 
> I wanted to put stable@kernel.org in CC but that bounced.

That commit is not in Linus's tree, so I can't do anything about it at
this point in time.  When it hits Linus's tree, please resend this
message to stable@vger.kernel.org, so we know to pick it up then.

Also, networking stable patches come from David Miller, so he should be
the one sending this to me...

thanks,

greg k-h
