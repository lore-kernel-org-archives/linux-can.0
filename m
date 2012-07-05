From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/4] can: gw: Netlink related fixes
Date: Thu, 05 Jul 2012 18:16:41 +0200
Message-ID: <4FF5BDE9.7000001@hartkopp.net>
References: <cover.1341489914.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:34464 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab2GEQQi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 12:16:38 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-can@vger.kernel.org

On 05.07.2012 14:19, Thomas Graf wrote:


> These patches fix some Netlink quirks in the CAN gateway code.
> Unfortunately I do not own any CAN hardware so this is compile
> tested only. I'm fairly confident though as the changes are
> mostly straight forward. I would appreciate if someone could
> run them through a test suite or something though.
> 
> 
> Thomas Graf (4):
>   can: Don't bump nlmsg_len manually
>   can: Use nla_policy to validate netlink attributes
>   can: Properly fill the netlink header when responding to RTM_GETROUTE
>   can: Remove pointless casts
> 
>  net/can/gw.c |   90 +++++++++++++++++++++------------------------------------
>  1 files changed, 33 insertions(+), 57 deletions(-)
> 


Hi Thomas,

thanks for the cleanups!

The can-gw was my first netlink based project and i did the best i knew.

From the first sight it looks good. I now also got behind the nla_policy
trick, which checks the minimal length too.

I'll test the patches this weekend with the virtual CAN interfaces (no CAN HW
needed), so that we probably catch the current development window.

Best regards,
Oliver
