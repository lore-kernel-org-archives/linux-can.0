From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: j1939 for linux 3.12 problem
Date: Sun, 25 May 2014 20:18:34 +0200
Message-ID: <20140525181834.GB1055@vandijck-laurijssen.be>
References: <CALoSW66s1aWz6g=RRLebh_Le6j7Br1Phet_tuisC2oWbGwQzJA@mail.gmail.com>
 <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:26466 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbaEYSSs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 25 May 2014 14:18:48 -0400
Content-Disposition: inline
In-Reply-To: <CALoSW65MXVzugeZVyi7q1znDWgbxxLiUE-apUcgSLRU+XmN9Bw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nimai Mahajan <nimaim@gmail.com>
Cc: linux-can@vger.kernel.org

Hey,

I apologize for not having seen your first post.
I had some problems using my company email.

On Sat, May 24, 2014 at 06:44:59PM -0400, Nimai Mahajan wrote:
> Kurt,
> 
> I posted this on the gname mailing list months ago but I guess it never made it
> there. Here is my humble request (we have an application that requires the use
> of the RP1210 API; however, I believe they are using all J1939 calls so getting
> your stuff to work in Linux would be most appreciated):
> 
> How much work would it be to get this working in a newer kernel? Why haven't
> these changes gotten merged into the official socketcan libraries?
> 
> ---------- Forwarded message ----------
> From: Nimai Mahajan <nimaim@gmail.com>
> Date: Sun, Mar 16, 2014 at 12:29 PM
> Subject: Problem
> To: Nimai Mahajan <nimaim@gmail.com>
> 
> 
> Kurt, I apologize for bumping this but this is the most recent thread I saw
> where you were still active. Are you still maintaining J1939 support in later
> versions of the Linux kernel (as well as the newer can-utils and iproute2
> packages)?

Thanks for your interest.
Yes, I'm still doing that with the ultimate goal of being integrated in mainline.
I'm incorporating advice from the linux-can mailing list.
You may have noticed that the development pace has slowed down a bit :-)

> I am seeking support for this for a Buildroot embedded system for
> vehicle diagnostics and it is important for us to get it working to avoid
> creating our own J1939 wrappers would be too significant an effort. While I'm
> still new to the protocols and all, my understanding is that I will have to use
> CAN_RAW and manual CAN frames to communicate with our devices here (versus
> specific J1939 methods you've written) and I rather not do that. I've
> cross-compiled iproute2 and can-utils from your repo successfully with
> Buildroot libraries with some minor tweaking of the config files. Even though
> you modified older packages of the two, I don't see any significant commits
> since then.
> 
> My problem is merging your j1939-v3.8 branch to the 3.12.13 kernel (3.8 is no
> longer supported and kernel.org states that 3.10.x and 3.12.x are the latest
> longterm supported kernels, so it would be great if I can get it to work on one
> of these). The merge works fine, here is the result of that:

Aha, I started with a 3.12 port, and noticed netlink and procfs changes.

You got quite far on your own.
I'll create a branch solving the core issues soon.
A reworked version with modified core functionality must be tested first
and that will take too long now.

Can you wait a few days?

Kind regards,
Kurt
