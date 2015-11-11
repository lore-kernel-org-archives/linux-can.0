From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: can-j1939: semantics question
Date: Wed, 11 Nov 2015 21:49:14 +0100
Message-ID: <5643A9CA.8060509@hartkopp.net>
References: <20151111195255.GB23275@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:23332 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbKKUtS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2015 15:49:18 -0500
In-Reply-To: <20151111195255.GB23275@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alex Layton <alex@layton.in>, linux-can <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

On 11.11.2015 20:52, Kurt Van Dijck wrote:

> I eventually got into investigating the necessary changes to drop
> iproute2 from can-j1939.
> We somewhat agreed that opening a can-j1939 socket and binding
> to a CAN interface should activate can-j1939 processing for that
> interface.
> But how about deactivation?
> Should the last can-j1939 socket on a CAN iface deactivate can-j1939 for
> that iface when that socket closes?

At least this sounds like some kind of natural behaviour.

What would be the other option?

Would you still monitor address claiming inside the kernel without doing 
anything else?

Or is the address claiming in user space the last application that closes the 
last socket anyway??

Regards,
Oliver


