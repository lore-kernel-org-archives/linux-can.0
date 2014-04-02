From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can: add hash based access to single EFF frame filters
Date: Wed, 02 Apr 2014 19:26:16 +0200
Message-ID: <533C4838.2000908@hartkopp.net>
References: <1396378632-5413-1-git-send-email-socketcan@hartkopp.net> <1396378632-5413-3-git-send-email-socketcan@hartkopp.net> <533BE133.8020600@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:48539 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758860AbaDBR0S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 13:26:18 -0400
In-Reply-To: <533BE133.8020600@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 02.04.2014 12:06, Marc Kleine-Budde wrote:

> 
> [1] After a long long long search I found a compiler (Debian clang
> version 3.4-2 (tags/RELEASE_34/final) (based on LLVM 3.4) in 32 Bit
> mode) that produces a function with more more instruction for your
> "backwards" hash compared to a "forward" hash:
> 
> 	hash = can_id;
> 	hash ^= can_id >> CAN_EFF_RCV_HASH_BITS;
> 	hash ^= can_id >> (2 * CAN_EFF_RCV_HASH_BITS);
> 
> 	return hash & ((1 << CAN_EFF_RCV_HASH_BITS) - 1);
> 
> In 64 bit mode it issues the same number of instructions, though your
> backwards hash is a byte shorter :) gcc 4.7 in contrast creates same
> number of instructions and bytes for 32 and 64 bit.
> 

Ok, I see you really had fun with this review :-)

Will change the hash function like this - and the other stuff too.

Thanks,
Oliver
