From: Hubert Denkmair <xor@xor.wtf>
Subject: Re: socketcan and libnl3
Date: Tue, 14 Jun 2016 15:57:39 +0200
Message-ID: <c6d6b34a0c475ec5cf433c90cfa0c26b@xor.wtf>
References: <5741873B.5040300@xor.wtf>
 <loom.20160614T125640-218@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.xor.wtf ([46.38.236.187]:48201 "EHLO mail.xor.wtf"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbcFNN5q (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 14 Jun 2016 09:57:46 -0400
In-Reply-To: <loom.20160614T125640-218@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ajneu <ajneu1@gmail.com>
Cc: linux-can@vger.kernel.org

Greetings ajneu,

> I've tried your canifconfig under Debian Stretch
> with the following command:
> 
>     sudo ./canifconfig -i can0 -u -b 250000
seems right to me, works for me (tm) [ubuntu 16.04/pcan and candleLight 
devices]

> and wow that sure is one destructive command!!
> Command Line shows: "Killed"
> 
> And from then on issuing command
> 
>     sudo ifconfig
> 
> hangs. I cannot even stop it with Ctrl-C.
> 
> This may be a problem with libnl, or with the Debian Testing (Strech) 
> that
> I'm running!! Completely destructive!

So much wow. Glad I could help :-)

No really, i haven't seen something like that on my PC.
Haven't finished debugging the listen-only stuff, but setting bitrate 
and taking interfaces up/down has never been a problem.

Which can hardware and which kernel do you use?
I would suspect the problem is most likely in a socketcan driver?
If not (or if I can get hold of the hardware), maybe I can reproduce 
that in a VM?

Cheers,

Hubert
