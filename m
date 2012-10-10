From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: "Blessed" Version
Date: Wed, 10 Oct 2012 12:58:03 +0200
Message-ID: <507554BB.4000809@grandegger.com>
References: <5074B274.7070703@sunverge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43061 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab2JJK6H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 10 Oct 2012 06:58:07 -0400
In-Reply-To: <5074B274.7070703@sunverge.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stuart Statman <sstatman@sunverge.com>
Cc: linux-can@vger.kernel.org

On 10/10/2012 01:25 AM, Stuart Statman wrote:
> 
> Sorry if this is a repeat of an earlier question; I missed the
> transition from Berlios to this mailing list, and am only now catching up.
> 
> I've been sticking with a snapshot of the source tree from months ago.
> It isn't that I don't want the changes, I just don't want to have to
> retest my gear with a new set of drivers. (I'm also sticking with older
> versions of the kernel, same reason.)
> 
> However, we want to start testing against newer 2.6 kernels. However, it
> turns out that my snapshot from so many moons ago no longer compiles
> against the latest CentOS blessed 2.6 kernel.
> 
> So ... how do I get the latest release version of the SocketCAN drivers,
> CAN utils, etc? I could use git to grab from the head, I suppose, but
> that may be too bleeding edge for me.

We have moved to http://gitorious.org/linux-can. CAN utilities and
kernel modules have been separated. You find them under "can-utils" and
"can-modules". If you can, you should use a recent kernel version to
avoid the "can-modules". I'm afraid, they are not really well maintained.

What kernel version do you plan to use? What CAN hardware do you want to
support?

> (Forgive my almost complete ignorance of git, by the way. I'm likely to
> ask wildly stupid questions on this thread.)

You are welcome.

Wolfgang.

