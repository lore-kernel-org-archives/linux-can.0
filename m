From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Raw can socket close and disabling filters
Date: Sat, 23 Apr 2016 15:33:32 +0200
Message-ID: <571B79AC.8000800@hartkopp.net>
References: <loom.20160422T133332-34@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:63018 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbcDWNdp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 23 Apr 2016 09:33:45 -0400
In-Reply-To: <loom.20160422T133332-34@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>, linux-can@vger.kernel.org

Hi Laurent,

On 04/22/2016 01:39 PM, laurent vaudoit wrote:

> i'm using a 3.10 kernel with rtpatch applied, with raw can features.
> Running some debug in the release function, i've seen something weird (for
> me).
>
> In the function, we get the socket informations
> and then we unregister the notifier.
>
> After this, we test if the socket is bound and which is the ifindex.
>
> But when the unregister function is called, there is a call to the notifier
> with the event NETDEV_UNREGISTER, who leads to clear the socket inforamtions
> like bound and ifindex.
>
> So in the release function we can never enter in the code specific to a
> device.

The relevant removal is protected by lock_sock().

So when the notifier runs with NETDEV_UNREGISTER it will remove the 
filters & bind status.

In this case the block in raw_release() won't have anything to do to 
release the filters and the bind state, right?

Looks double work - but I wonder why we can rely on a notifier call when 
we call unregister_netdevice_notifier() ??

Regards,
Oliver

